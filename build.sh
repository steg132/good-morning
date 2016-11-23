#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "No version number specified"
    exit
fi

[ -d "bin/" ] || mkdir "bin/"

xcodebuild -target 'Good Morning' -scheme 'Good Morning' -configuration Deploy CONFIGURATION_BUILD_DIR=./build/

TAR_NAME="bin/good_morning_$1.tar.gz"

tar cvzf "$TAR_NAME" "Good Morning/" "Good Morning.xcodeproj/project.pbxproj" "Good Morning.xcodeproj/project.xcworkspace/contents.xcworkspacedata"

if [ "$?" -eq 0 ]; then 
	echo "Sucessfully generated \"$TAR_NAME\""
else 
	echo "Failed to generate \"$TAR_NAME\""
fi



