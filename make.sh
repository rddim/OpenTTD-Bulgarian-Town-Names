#!/bin/sh
echo "***************************************************************"
echo "*"
echo "* OpenTTD \"Bulgarian Town Names\""
echo "* Copyright (c) 2017 Rusi Dimitrov"
echo "* This program comes with ABSOLUTELY NO WARRANTY."
echo "* This is free software, and you are welcome to redistribute it"
echo "* under certain conditions of GPL v3 license."
echo "*"
echo "***************************************************************"

# Set variables
NMLC=$(which nmlc)
TAR=$(which tar)
SRC="$PWD/src"
cp $SRC/custom_tags-base.txt $SRC/custom_tags.txt
VERSION=$(grep VERSION "${SRC}/custom_tags.txt" | cut -d':' -f2)
NAME="bg_names"
BUILD="Bulgarian_Town_Names-${VERSION}"
RELEASE="$PWD/build/${BUILD}"

# Preliminary checks
if [ -z ${NMLC} ]; then
    echo "ERROR: NML not found!"
    exit 1
fi

if [ -z ${VERSION} ]; then
    echo "ERROR: Failed to get version!"
    exit 1
fi

# Create folder
echo "\n *** Creating folder: /build/${BUILD}\n"
mkdir -p "${RELEASE}"

# Building
echo "\n *** Building from the source, please wait...\n"
${NMLC} --grf="${RELEASE}/${NAME}.grf" \
        --custom-tags="${SRC}/custom_tags.txt" \
        --lang-dir="${SRC}/lang" \
        "${SRC}/${NAME}.nml" \
        --verbosity=4

# If failed, then clean up and exit
if [ $? -eq 1 ]; then
    echo "\n*********************** Building failed ***********************\n"
    rm -R "${RELEASE}"
    exit 1
fi

# Copy files
cp $PWD/docs/*.txt ${RELEASE}
cp $PWD/LICENSE ${RELEASE}/license.txt

# Create TAR
echo "\n *** Creating archive: ${RELEASE}.tar\n"
cd "$PWD/build/"
${TAR} -cf "${RELEASE}.tar" "${BUILD}"

# Clean up files and dirs
cd - > /dev/null
rm -R "${RELEASE}" "$PWD/.nmlcache" "$SRC/custom_tags.txt"

# Finish
echo "\n********************** Building finished **********************\n"
echo "To install copy the NewGRF archive to the OpenTTD NewGRF directory:"
echo "    \$ cp ${RELEASE}.tar ~/.openttd/newgrf/\n"
exit 0
