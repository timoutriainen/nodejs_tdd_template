# Node.js TDD project template #
This tool is meant to provide a quick way to setup a new Node.js project ready for TDD.

## Usage ##
- Clone this tool to empty to-be-project directory.  
- Delete this project's .git directory, LICENSE and README.md file.  
- Run script add_module.sh to create source and test files, repeat for each new source file as needed.

### Run add_module.sh ###
- Open shell, for example Git bash, in the to-be-project directory

- execute ./add_module.sh <module name>  
E.g.  
./add_module.sh database_abstraction

- script will create the following files:  
src/database_abstraction.js  
test/test_database_abstraction.js  
README.md (if it doesn't exist yet - make sure to update correct details to the file afterwards)  
package.json (if it doesn't exist yet - make sure to update correct details to the file afterwards)  

- finally the script will run the first failing unit test on the newly created module and report test coverage
