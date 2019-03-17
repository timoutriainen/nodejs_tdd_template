#!/bin/bash

function create_file () {
  echo "Creating file $1"
  touch $1
}

function create_test_file () {
  new_test_module=test/test_$1.js
  mkdir -p test
  create_file $new_test_module
  echo "// comment for test file" > $new_test_module
  echo "const { assert } = require('chai');" >> $new_test_module
  echo "const $1 = require('../src/$1');" >> $new_test_module
  echo "" >> $new_test_module
  echo "let $1Obj;" >> $new_test_module
  echo "" >> $new_test_module
  echo "describe('$1#Test', () => {" >> $new_test_module
  echo "  beforeEach(() => {" >> $new_test_module
  echo "    $1Obj = $1.create();" >> $new_test_module
  echo "  });" >> $new_test_module
  echo "  it('first failing test', () => {" >> $new_test_module
  echo "    assert($1Obj.returnTrue() === 'true', 'returns always true');" >> $new_test_module
  echo "  });" >> $new_test_module
  echo "" >> $new_test_module
  echo "});" >> $new_test_module
}

function create_source_file () {
  new_module=src/$1.js
  mkdir -p src
  create_file $new_module
  echo "const debug = require('debug')('$1');" > $new_module
  echo "" >> $new_module
  echo "function $1() {" >> $new_module
  echo "  debug('$1()');" >> $new_module
  echo "}" >> $new_module
  echo "$1.prototype.returnTrue = () => {" >> $new_module
  echo "  debug('returnTrue()');" >> $new_module
  echo "};" >> $new_module
  echo "" >> $new_module
  echo "function create() {" >> $new_module
  echo "  return new $1();" >> $new_module
  echo "}" >> $new_module
  echo "" >> $new_module
  echo "module.exports = { create };" >> $new_module
}

function create_package_json_file () {
  npm init -y
  cmd="npx json -I -f package.json -e 'this.name=\"$1\"'"
  eval $cmd
  cmd="npx json -I -f package.json -e 'this.description=\"$1\"'"
  eval $cmd
  cmd="npx json -I -f package.json -e 'this.private=true'"
  eval $cmd
  npm install debug
  npm install chai --only=dev
  npm install eslint --only=dev
  npm install eslint-plugin-import --only=dev
  npm install eslint-config-airbnb-base --only=dev
  npm install mocha --only=dev
  npm install nyc --only=dev
  npm install json
  cmd="npx json -I -f package.json -e 'this.scripts.test=\"nyc --reporter=html --reporter=text-summary mocha --timeout=3000\"'"
  eval $cmd
}

function create_readme_md_file () {
  readme_md=README.md
  create_file $readme_md
  echo "# $1" > $readme_md
  echo "$1 allows ..." >> $readme_md
  echo "" >> $readme_md
  echo "## Installation" >> $readme_md
  echo "" >> $readme_md
  echo "## Usage" >> $readme_md
  echo "" >> $readme_md
  echo "### Run $1" >> $readme_md
  echo "" >> $readme_md
}

# validate input
if [ "$#" -ne 1 ]; then
  echo "Please provide new module name as a parameter, e.g. $0 my_new_module"
	exit 1
fi

# create source and test files
create_source_file $1
create_test_file $1

# create package.json if it doesn't exist yet
if [ ! -f package.json ]; then
  create_package_json_file $1
fi

# create README.md if it doesn't exist yet
if [ ! -f README.md ]; then
  create_readme_md_file $1
fi

# run tests and create coverage report to /coverage
npm test
