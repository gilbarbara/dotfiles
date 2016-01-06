#!/bin/sh
#
# chmodr.sh
#


usage()
{
  echo "Usage: $0 [-d DIRPERMS] [-f FILEPERMS] PATH"
  exit 1
}

while getopts ":d:f:" o; do
    case "${o}" in
        d)
            DIRPERMS=${OPTARG}
            ;;
        f)
            FILEPERMS=${OPTARG}
            ;;
        \?)
            usage
            ;;
    esac
done
shift $(($OPTIND - 1))

# Default directory permissions
if [ -z "$DIRPERMS" ] ; then
  DIRPERMS=755
fi

# Default file permissions
if [ -z "$FILEPERMS" ] ; then
  FILEPERMS=644
fi

# Set the root path
ROOT=$1
if [ -z $1 ] ; then
	ROOT='.'
fi

# root path is a valid directory
if [ ! -d $ROOT ] ; then
 echo "$ROOT does not exist or isn't a directory!" ; exit 1
fi

# set directory permissions recursively
if [ -n "$DIRPERMS" ] ; then
  find $ROOT -type d -print0 | xargs -0 chmod -v $DIRPERMS
fi

# set file permissions recursively
if [ -n "$FILEPERMS" ] ; then
  find $ROOT -type f -print0 | xargs -0 chmod -v $FILEPERMS
fi
