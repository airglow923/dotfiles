#!/bin/sh

# For optimum usage, you can git clone your remote repository before executing
# this script so that it is applied to package.json.

jq_inplace() {
  # create temporary file
  TEMP=$(mktemp)

  # remove temoorary file in case the program terminates unexpectedly
  trap "{ rm -f $TEMP; }" EXIT

  # redirect the result of jq [FIRST ARG] [SECOND ARG] to temporary file
  jq "$1" "$2" > $TEMP

  # replace original json with new one
  cat $TEMP > "$2"

  # remove used temporary file
  rm $TEMP
}

# node is a runtime for JavaScript code
# npm is dependent on nodejs so installing npm only is sufficient
# jq is for JSON manipulation
DEPS="node npm jq"
MISSING_DEPS=""

for DEP in ${DEPS}; do
  if [ ! -x "$(which ${DEP})" ]; then
    MISSING_DEPS="${MISSING_DEPS} ${DEP}"
  fi
done

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
  echo "Missing dependencies: ${MISSING_DEPS}"
  exit 1;
fi

# initialize npm package
npm init -y

# install eslint and typescript for development
npm i --save-dev eslint typescript @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin nodemon prettier

# get default tsconfig.json
npx tsconfig.json

# edit tsconfig.json
jq_inplace '.compilerOptions += {"rootDir": "."}' tsconfig.json

# edit tsconfig.json

# create source directory
mkdir src test

# create placeholder .ts file
echo 'console.log("Hello, World!");' > src/index.ts
echo 'console.log("test.ts executed");' > test/test.ts

# scripts for TS project
JSON='{
  "main": "dist/src/index.js",
  "files": [
    "/dist/src"
  ],
  "scripts": {
    "build": "tsc",
    "start": "node dist/src/index.js",
    "watch": "tsc -w",
    "dev": "nodemon dist/src/index.js",
    "test": "tsc -p test && node dist/test/test.js",
    "lint": "npx eslint . --ext .js,.jsx,.ts,.tsx",
    "fix": "npm run lint -- --fix",
    "format": "npx prettier -w ."
  }
}'

jq_inplace ". + $JSON" package.json

# test/tsconfig.json
JSON='{
  "extends": "../tsconfig.json",
  "compilerOptions": {
    "baseUrl": "."
  },
  "include": [
    "./**/*.tsx",
    "./**/*.ts"
  ]
}'

echo "$JSON" > test/tsconfig.json

# configure eslint
TEMP='node_modules
dist
coverage'

echo "${TEMP}" > .eslintignore

TEMP="module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: [
    '@typescript-eslint',
  ],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  env: {
    node: true
  }
};"

echo "${TEMP}" > .eslintrc.js

# add node_modules and dist directories to .gitignore
if [ -d .git ]; then
  TEMP='node_modules/
dist/'
  echo "${TEMP}" > .gitignore
fi

TEMP='node_modules
dist
coverage
test
.eslintrc.js
*.yml
*.json'

echo "${TEMP}" > .prettierignore

echo {} > .prettierrc.json
