#!/usr/bin/env bash

SHOW_LOG=0

function show_help() {
    echo "rlog.sh - generate a release log file from based on the commits on top of the last tag"
    echo ""
    echo "rlog.sh [options]"
    echo ""
    echo "options:"
    echo "-h, --help          show brief help"
    echo "-v                  show the contents of the log file"
}

while test $# -gt 0; do
  case "$1" in
    help | -h | --help)
      show_help
      exit 0
      ;;
    -v)
      export SHOW_LOG=1
      shift
      ;;
    *)
      shift
      ;;
  esac
done

old_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
echo "The last tag version is '${old_tag}'"; echo

echo "enter the new tag version: "
read new_tag; echo

origin=$(git remote -v | grep ${PWD##*/} | grep fetch | awk '{print $2}')
remote=$(echo $origin | sed -e 's/:/\//' | sed -e 's/git@/https:\/\//g' | sed -e 's/.git//')
today_date=$(date +'%Y-%m-%d')

log="# Version ${new_tag} (${today_date})

## Features / Fixes

$(git log --pretty=format:"* %B [%h](${remote}/commit/%H)" ${old_tag}..)

## Diff

* ${remote}/compare/${old_tag}...${new_tag}
"

release_filepath="release-logs/release-log-${today_date}.md"

echo "Logs will be written to '${release_filepath}' file"; echo
if [ ${SHOW_LOG} = 1 ]; then
    echo "-----------------------------"
    printf "${log}"
    echo "-----------------------------"; echo
fi

BOLD_START="\e[1;4m"; BOLD_END="\e[0m"
echo -e "${BOLD_START}NOTE: The newly created release file may need to be edited/formatted depending on the need(s) before committing.${BOLD_END}"; echo

printf "${log}" > ${release_filepath}

echo "Enjoy !!!"
