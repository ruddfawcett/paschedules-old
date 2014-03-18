#!/bin/bash

rake db:reset
cp db/fresh-preSchedules.yml db/data.yml
rake db:data:load
rake schedules:parseSchedules
rake schedules:purgeBlankSchedules
rake schedules:convertToCommitments
./dumpDB.sh
git commit -am "AUTOMATED COMMIT. Update data.tar.gz"
git push heroku master
heroku run '/app/restoreDB.sh'
