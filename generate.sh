#!/usr/bin/env sh

echo "Extension display name: "
read name
echo "Extension remote repository name: "
read repo
echo "Extension remote repository owner: "
read owner
lowercaseowner="$(echo "$owner" | tr '[:upper:]' '[:lower:]' | tr -d '-')"

sed -i "s|EXTENSION_DISPLAY_NAME|$name|g" LICENSE README.md build.gradle.kts settings.gradle.kts src/main/resources/extension.json
sed -i "s|EXTENSION_REPO_NAME|$repo|g" LICENSE README.md build.gradle.kts settings.gradle.kts src/main/resources/extension.json
sed -i "s|EXTENSION_REPO_OWNER|$owner|g" LICENSE README.md build.gradle.kts settings.gradle.kts src/main/resources/extension.json
sed -i "s|EXTENSION_REPO_LOWER_OWNER|$lowercaseowner|g" LICENSE README.md build.gradle.kts settings.gradle.kts src/main/resources/extension.json

lowercasename="$(echo "$name" | tr '[:upper:]' '[:lower:]')"
sed -i "s|package com.github;|package com.github.$lowercaseowner.$lowercasename;|i" src/main/java/com/github/*
mkdir -p src/main/java/com/github/"$lowercaseowner"/"$lowercasename"/
mv src/main/java/com/github/* src/main/java/com/github/"$lowercaseowner"/"$lowercasename"/

rm generate.sh
