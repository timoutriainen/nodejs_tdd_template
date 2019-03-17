# Node.js TDD project template
This tool is meant to provide a quick way to setup new Node.js project ready for TDD.

## Usage
Clone this tool to your empty to-be-project directory.
Delete this project's .git directory and README.md file.
Run script to create module, repeat when needed.

### Run add_module.sh
- Open shell, for example Git bash, in the to-be-project directory

- execute ./add_module.sh <module name>
E.g.
./add_module.sh database_abstraction

- script will create the following files:
src/database_abstraction.js
test/test_database_abstraction.js
README.md (if it doesn't exist yet - make sure to update correct details to the file)
package.json (if it doesn't exist yet - make sure to update correct details to the file)

- script will run first failing unit test on the newly created module and report test coverage
