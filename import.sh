export NEO=/Users/brock/neo4j-community-3.0.2

$NEO/bin/neo4j-import \
  --into $NEO/data/databases/test.db \
  --id-type string \
  --nodes:Person data/person_header.csv,data/person.csv \
  --nodes:Browser data/browser_header.csv,data/browser.csv \
  --nodes:Employment data/job_header.csv,data/job.csv \
  --relationships:IS_EMPLOYED data/rel_browser.csv