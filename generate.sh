#!/usr/bin/env sh

echo "Extension display name: "
read name
echo "Extension remote repository name: "
read repo

sed -i "s|        \"repo\": \"EXTENSION_REPO_NAME\",|        \"repo\": \"$repo\",|i" src/main/resources/extension.json
sed -i "s|rootProject.name = \"EXTENSION_REPO_NAME\"|rootProject.name = \"$repo\"|i" settings.gradle.kts
sed -i "s|var displayName = \"EXTENSION_DISPLAY_NAME\"|var displayName = \"$name\"|i" build.gradle.kts
sed -i "s|EXTENSION_DISPLAY_NAME|$name|g" README.md
sed -i "s|EXTENSION_REPO_NAME|$repo|g" README.md

lowercasename="$(echo "$name" | tr '[:upper:]' '[:lower:]')"
sed -i "s|package com.github.klainstom;|package com.github.klainstom.$lowercasename;|i" src/main/java/com/github/klainstom/*
mkdir src/main/java/com/github/klainstom/"$lowercasename"/
mv src/main/java/com/github/klainstom/* src/main/java/com/github/klainstom/"$lowercasename"/

rm generate.sh
