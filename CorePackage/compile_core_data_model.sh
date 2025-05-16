#!/bin/bash

# Path to the xcdatamodel
model_path="Data/Models/GamersHubDataModel.xcdatamodel"
# Output path for the compiled momd
output_path="Data/Models/GamersHubDataModel.momd"

# Ensure the output directory exists
mkdir -p "Data/Models"

# Compile the Core Data model using momc
/Applications/Xcode.app/Contents/Developer/usr/bin/momc "$model_path" "$output_path"

if [ $? -eq 0 ]; then
    echo "Successfully compiled Core Data model."
else
    echo "Error compiling Core Data model."
    exit 1
fi

