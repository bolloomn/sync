#!/bin/bash
#This script run every 15 seconds
while (sleep 10 && php /Applications/XAMPP/htdocs/sync/outlet/cron.php) &
do
  wait $!
done
