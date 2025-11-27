#!/usr/bin/env node

const { execSync, spawn } = require('child_process');
const { readFileSync, writeFileSync } = require('fs');

(() => {
  try {
    const list = execSync('pnpm ls -g --depth=0 --json').toString();

    const [result] = JSON.parse(list);

    const packages = Object.entries(result.dependencies).filter(([key, value]) => !value.version.startsWith('link:')).map(([key, value]) => key);

	  writeFileSync('NPMfile', packages.join('\n'), 'utf-8')

    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();
