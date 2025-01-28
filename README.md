# Charityapidocs

This is the repository for the API Docs for CharityAPI.org. These docs are written in markdown in the /src folder, and then we use ExDoc to generate the static site from the src folder. The outputted docs are in the doc folder. 

## Installation
Install Elixir version 1.16
`asdf install` 

Compile the docs 
`mix docs`

## Adding New Content 

1. Add a new .md file under "src/YourNewFile.md" 
2. Add the new file to the "extras" key in mix.exs. 
3. Run mix docs to generate the static files. 

# Running 

`mix run --no-halt`
