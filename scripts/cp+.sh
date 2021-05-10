#!/bin/bash
set -eou pipefail

export VERSION=14
export ARGS=0
export FILE=

show_help() {
    echo "c++14 - builds and runs a c++ source file specified by the only argument"
    echo " "
    echo "Usage: c++14 <file_path>"
    echo " "
    echo "arg:"
    echo "<file_path>         specifies a c++ source file path that must have '.cpp' as extension"
    echo " "
    echo "options:"
    echo "-h, --help          show brief help"
    echo "    --14            use -std=c++14 as compiler, default"
    echo "    --11            use -std=c++11 as compiler"
}

clean_up() {
    rm -rf ./a.out
}

trap clean_up EXIT

while test $# -gt 0; do
    case "$1" in
        -h | --help)
            show_help
            exit 0
            ;;
        --14)
            export VERSION=14
            shift
            ;;
        --11)
            export VERSION=11
            shift
            ;;
        --*)
            echo -e "Error: $1 unknown flag\nRun 'c++ -h|--help' for help"
            exit 1
            ;;
        *)
            ARGS=$(($ARGS+1))
            if [ $ARGS -gt 1 ]; then
                echo -e "Error: more than one arguments are provided\nRun 'c++ -h|--help' for help"
                exit 1
            fi
            export FILE=$1
            shift
            ;;
    esac
done
    
if [ $ARGS -eq 0 ]; then
    echo -e "Error: c++ source file must be provided\nRun 'c++ -h|--help' for help"
    exit 1
elif [ ${#FILE} -lt 4 ] || [ ${FILE: -4} != ".cpp" ]; then
    echo -e "Error: the specified file must be a c++ source file and must have '.cpp' as extension\nRun 'c++ -h|--help' for help"
    exit 1
fi

g++ -std=c++${VERSION} ${FILE}
./a.out