# About

I have been meaning to work through an example of using Neo4j's `import-tool` to
seed datasets that are larger in size.  I have had success combining `R` and the
`shell` tool to load datasets using `LOAD CSV` and `cypher`, but as my data grows,
the import-tool seems to be the way to go.

This repo contains some really basic code to generate a small, fake dataset, format the files so they can be used
within the import tool, and then run a simple shell command to build out the database.  

Since the majority of my analytical work is
in `R`, I wanted to highlight how easy it is to script some of the backend work to easily inject Neo4j into an analytical pipeline for larger data.

## References  

1.  https://neo4j.com/blog/bulk-data-import-neo4j-3-0/   
2.  http://neo4j.com/docs/operations-manual/current/deployment/#import-tool  

And an example of how I call the shell tools from R to seed data and get around iterating over
datasets row by row.

- http://btibert3.github.io/2016/03/02/Neo4j-Import-with-R.html  


## Data Model

![fig](https://raw.githubusercontent.com/Btibert3/public-figs/master/neo-import/data-model.png)

## Process  

1.  Use the R package [wakefield](https://github.com/trinker/wakefield)  to create a small dataset with `build-data.R`  
2.  Beat up the `data.frame` and build out the csv (including header) files to be used in the `import-tool`.  This is also done with `build-data.R`    
3.  Use `import.sh` to build out the database using the created files, and build the database in the `/databases` directory within the Neo4j directory.  

To start up Neo4j with the database created via `import-tool`, you will need to edit the config files to point to your database upon startup, instead of the `default.db` location.

__One note:__  After the database starts up, you should create indexes on your nodes.  
__One Tip:__  Each node is referenced by the ID that you create on import.  Create them if they do not exist naturally, so that the `relationship` files are easy to manage.
