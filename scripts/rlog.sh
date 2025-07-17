#!/usr/bin/env bash

SHOW_LOG=0
CHART_PATH=""
TAG_BUILD=0

function show_help() {
    echo "rlog.sh - generate a release log file from based on the commits on top of the last tag"
    echo ""
    echo "rlog.sh [options]"
    echo ""
    echo "options:"
    echo "-h, --help          show brief help"
    echo "-v                  show the contents of the log file"
    echo "--chart-path, -c    path to the helm chart"
    echo "--tag-build         whether to build the tag and push release commit with tag. no value required"
}

while test $# -gt 0; do
  case "$1" in
    help | -h | --help)
      show_help
      exit 0
      ;;
    -v)
      SHOW_LOG=1
      shift
      ;;
    -c | --chart-path)
      CHART_PATH="$2"
      shift 2
      ;;
    --chart-path=*)
      CHART_PATH="${1#*=}"
      shift
      ;;
    --tag-build)
      TAG_BUILD=1
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

$(git log --no-merges --pretty=format:"* %B [%h](${remote}/commit/%H)" ${old_tag}.. | grep -v '^Signed-off-by:' | sed '/^\s*$/d')

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

BOLD_START="\033[1;4m"; BOLD_END="\033[0m"
echo -e "${BOLD_START}NOTE: The newly created release file may need to be edited/formatted depending on the need(s) before committing.${BOLD_END}"; echo

printf "${log}" > ${release_filepath}

# Change the app container version that is going to live
if [[ -n "${CHART_PATH}" ]]; then
    os_type="$(uname)"
    echo "==> updating the chart file.."
    if [[ "$os_type" == "Darwin" ]]; then
        sed -i '' "s/^appVersion: .*/appVersion: ${new_tag}/" "${CHART_PATH}/Chart.yaml"
    elif [[ "$os_type" == "Linux" ]]; then
        sed -i "s/^appVersion: .*/appVersion: ${new_tag}/" "${CHART_PATH}/Chart.yaml"
    else
        echo "Unknown OS: $os_type"
    fi

    echo
fi

if [ ${TAG_BUILD} = 1 ]; then
    echo "==> commiting.."
    git add ${release_filepath} ${CHART_PATH}
    git commit -m "$(echo "added release logs for tag ${new_tag}")"
    echo

    echo "==> input a tag message"
    read tag_msg;
    echo

    echo "==> creating tag ${new_tag}"
    git tag ${new_tag} -a -m "$(echo "${new_tag}")"
    echo

    echo "==> push the release commit with tag ${new_tag}"
    git push origin HEAD --tags
    echo
fi

echo "Enjoy !!!"
