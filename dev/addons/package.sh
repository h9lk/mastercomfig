#!/bin/bash
# Run script within the directory
BINDIR=$(dirname "$(readlink -fn "$0")")
cd "${BINDIR}" || exit 2

# Delete old VPKs and folders
rm -f -- *.vpk
rm -rf -- */

for F in ../../config/cfg/addons/*; do
    if [ -f "${F}" ]; then
        ext=${F##*.}
        if [ "${ext}" = cfg ]; then
            A=$(basename "${F}" ."${ext}")
            mkdir -p mastercomfig-addon-"${A}"/cfg/addons
            cp -f ../../config/cfg/addons/"${A}".cfg mastercomfig-addon-"${A}"/cfg/addons/"${A}".cfg
        fi
    fi
done

# Copy over custom addons
cp -rf ../../config/addons/* .

. ../common.sh

cleanAndPackage

printf "\n"
