#!/bin/bash
input=$(cat)

# ---- color helpers (TTY-aware, respect NO_COLOR) ----
use_color=1
# Note: TTY check removed - Claude Code handles ANSI codes in statusline
[ -n "$NO_COLOR" ] && use_color=0

C() { if [ "$use_color" -eq 1 ]; then printf '\033[%sm' "$1"; fi; }
RST() { if [ "$use_color" -eq 1 ]; then printf '\033[0m'; fi; }

# ---- basic colors ----
dir_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;36m'; fi; }    # cyan
model_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;35m'; fi; }  # magenta
version_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;33m'; fi; } # yellow
rst() { if [ "$use_color" -eq 1 ]; then printf '\033[0m'; fi; }

# ---- time helpers ----
to_epoch() {
  ts="$1"
  if command -v gdate >/dev/null 2>&1; then gdate -d "$ts" +%s 2>/dev/null && return; fi
  date -u -j -f "%Y-%m-%dT%H:%M:%S%z" "${ts/Z/+0000}" +%s 2>/dev/null && return
  python3 - "$ts" <<'PY' 2>/dev/null
import sys, datetime
s=sys.argv[1].replace('Z','+00:00')
print(int(datetime.datetime.fromisoformat(s).timestamp()))
PY
}

fmt_time_hm() {
  epoch="$1"
  if date -r 0 +%s >/dev/null 2>&1; then date -r "$epoch" +"%H:%M"; else date -d "@$epoch" +"%H:%M"; fi
}

progress_bar() {
  pct="${1:-0}"; width="${2:-10}"
  [[ "$pct" =~ ^[0-9]+$ ]] || pct=0; ((pct<0))&&pct=0; ((pct>100))&&pct=100
  filled=$(( pct * width / 100 )); empty=$(( width - filled ))

  # Warning colors for filled portion (only at high usage)
  if   (( pct >= 90 )); then fill_color='\033[38;5;196m'  # red
  elif (( pct >= 75 )); then fill_color='\033[38;5;208m'  # orange
  else                       fill_color=''                # default/dim
  fi
  empty_color='\033[38;5;240m'  # dark gray
  rst='\033[0m'

  # Build bar with colors
  filled_bar=""; for ((i=0; i<filled; i++)); do filled_bar+="█"; done
  empty_bar="";  for ((i=0; i<empty; i++));  do empty_bar+="█"; done

  printf '%b%s%b%s%b' "$fill_color" "$filled_bar" "$empty_color" "$empty_bar" "$rst"
}

# git utilities
num_or_zero() { v="$1"; [[ "$v" =~ ^[0-9]+$ ]] && echo "$v" || echo 0; }

# ---- basics ----
if command -v jq >/dev/null 2>&1; then
  current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "unknown"' 2>/dev/null | sed "s|^$HOME|~|g" | sed 's|.*/||')
  model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"' 2>/dev/null)
  model_version=$(echo "$input" | jq -r '.model.version // ""' 2>/dev/null)
  # context window - calculate effective percentage (accounting for 45k autocompact buffer)
  raw_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' 2>/dev/null)
  context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000' 2>/dev/null)
  buffer=45000
  usable=$((context_size - buffer))
  # effective_pct = raw_pct * context_size / usable
  context_pct=$(( raw_pct * context_size / usable ))
else
  current_dir="unknown"
  model_name="Claude"; model_version=""
  context_pct=0
fi

# ---- context usage validation ----
[[ "$context_pct" =~ ^[0-9]+$ ]] || context_pct=0

# ---- git colors ----
git_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;32m'; fi; }
rst() { if [ "$use_color" -eq 1 ]; then printf '\033[0m'; fi; }

# ---- git ----
git_branch=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
fi

# ---- usage colors ----
usage_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;35m'; fi; }
cost_color() { if [ "$use_color" -eq 1 ]; then printf '\033[1;36m'; fi; }
session_color() {
  # session_pct is remaining %, so check directly
  if   (( session_pct <= 10 )); then printf '\033[38;5;196m'  # red when <10% left
  elif (( session_pct <= 25 )); then printf '\033[38;5;208m'  # orange when <25% left
  fi
  # normal color above 25% remaining
}
# ---- ccusage integration ----
#session_txt=""; session_pct=0;
#
#if command -v jq >/dev/null 2>&1; then
#  blocks_output=$(npx ccusage@latest blocks --json 2>/dev/null || ccusage blocks --json 2>/dev/null)
#  if [ -n "$blocks_output" ]; then
#    active_block=$(echo "$blocks_output" | jq -c '.blocks[] | select(.isActive == true)' 2>/dev/null | head -n1)
#    if [ -n "$active_block" ]; then
#      # Session time calculation
#      reset_time_str=$(echo "$active_block" | jq -r '.endTime // .usageLimitResetTime // empty')
#      start_time_str=$(echo "$active_block" | jq -r '.startTime // empty')
#
#      if [ -n "$reset_time_str" ] && [ -n "$start_time_str" ]; then
#        start_sec=$(to_epoch "$start_time_str"); end_sec=$(to_epoch "$reset_time_str"); now_sec=$(date +%s)
#        total=$(( end_sec - start_sec )); (( total<1 )) && total=1
#        elapsed=$(( now_sec - start_sec )); (( elapsed<0 ))&&elapsed=0; (( elapsed>total ))&&elapsed=$total
#        session_pct=$(( (total - elapsed) * 100 / total ))
#        remaining=$(( end_sec - now_sec )); (( remaining<0 )) && remaining=0
#        rh=$(( remaining / 3600 )); rm=$(( (remaining % 3600) / 60 ))
#        # Ensure values are valid numbers
#        [[ "$rh" =~ ^[0-9]+$ ]] || rh=0
#        [[ "$rm" =~ ^[0-9]+$ ]] || rm=0
#        [[ "$session_pct" =~ ^[0-9]+$ ]] || session_pct=0
#        session_txt="$(printf '%dh%dm (%d%%)' "$rh" "$rm" "$session_pct")"
#      fi
#    fi
#  fi
#fi

# ---- render statusline ----
printf '📁 %s%s%s' "$(dir_color)" "$current_dir" "$(rst)"
# git display
if [ -n "$git_branch" ]; then
  printf '  🌿 %s%s%s' "$(git_color)" "$git_branch" "$(rst)"
fi
printf '  🤖 %s' "$model_name"
ctx_bar=$(progress_bar "$context_pct" 8)
printf ' %s %d%%' "$ctx_bar" "$context_pct"
if [ -n "$model_version" ] && [ "$model_version" != "null" ]; then
  printf '  🏷️ %s%s%s' "$(version_color)" "$model_version" "$(rst)"
fi
# session time
#if [ -n "$session_txt" ]; then
#  printf '  ⌛ %s%s%s' "$(session_color)" "$session_txt" "$(rst)"
#fi
