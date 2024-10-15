# Ruby Data Processing Challenge

This project is a Ruby application designed to read, process, and output user and company data from JSON files. The application performs token top-ups for users based on company configurations.

## TODO
- More data input testing to validate data integrity.
- Unit tests for core features to ensure functionality.
- Improved input handling, including file paths from the command line.
- Create a container for the application to facilitate deployment.

## How to Run
1. Ensure you have Ruby installed on your machine.
2. Place your input JSON files in the `data` folder. The files should be named:
   - `companies.json`
   - `users.json`
3. Run the application by executing the following command in your terminal:

   ```bash
   ruby challenge.rb