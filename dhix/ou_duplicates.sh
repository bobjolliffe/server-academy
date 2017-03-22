#!/bin/bash
# lists duplicate orgunits

echo "select name from organisationunit order by name" | psql -at  dhims |uniq -cd 
