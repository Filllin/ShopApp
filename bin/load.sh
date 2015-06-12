#! /bin/bash
echo "Create db"
rake db:create
echo "Schema load"
rake db:schema:load
echo "Fixtures load"
rake db:fixtures:load
