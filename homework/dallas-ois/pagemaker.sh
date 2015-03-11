echo "<html>"
echo "<head><title>DALLAS OIS</title></head>"
echo "<body>"
echo "<h2>Incidents:</h2>"
echo "<table border=\"1\" bordercolor=\"black\" cellpadding=\"2\">"
while read line
do
name=$line
case_id=`echo $name | cut -d "|" -f 1`
date=`echo $name | cut -d "|" -f 2`
location=`echo $name | cut -d "|" -f 3`
suspect_status=`echo $name | cut -d "|" -f 4`
suspect_weapon=`echo $name | cut -d "|" -f 5`
suspects=`echo $name | cut -d "|" -f 6`
officers=`echo $name | cut -d "|" -f 7`
grand_jury=`echo $name | cut -d "|" -f 8`
latitude=`echo $name | cut -d "|" -f 9`
longitude=`echo $name | cut -d "|" -f 10`
narrative=`echo $name | cut -d "|" -f 11`
echo "<tr><td>$case_id</td><td>$date</td><td>$location</td><td>$suspect_status</td><td>$suspect_weapon</td><td>$suspects</td><td>$officers</td><td>$grand_jury</td><td>$latitude</td><td>$longitude</td><td>$narrative</td></tr>"
done < tables/incidents.psv
echo "</table>"
echo "<br /><br /><br /><br />"
echo "<h2>Officers:</h2>"
echo "<table border=\"1\" bordercolor=\"black\" cellpadding=\"2\">"
while read line
do
name=$line
case_id=`echo $name | cut -d "|" -f 1`
date=`echo $name | cut -d "|" -f 2`
suspect_killed=`echo $name | cut -d "|" -f 3`
suspect_weapon=`echo $name | cut -d "|" -f 4`
last_name=`echo $name | cut -d "|" -f 5`
first_name=`echo $name | cut -d "|" -f 6`
race=`echo $name | cut -d "|" -f 7`
gender=`echo $name | cut -d "|" -f 8`
echo "<tr><td>$case_id</td><td>$date</td><td>$suspect_killed</td><td>$suspect_weapon</td><td>$last_name</td><td>$first_name</td><td>$race</td><td>$gender</td></tr>"
done < tables/officers.psv
echo "</table>"
echo "<br /><br /><br /><br />"
echo "<h2>Suspectss:</h2>"
echo "<table border=\"1\" bordercolor=\"black\" cellpadding=\"2\">"
while read line
do
name=$line
case_id=`echo $name | cut -d "|" -f 1`
date=`echo $name | cut -d "|" -f 2`
suspect_weapon=`echo $name | cut -d "|" -f 3`
last_name=`echo $name | cut -d "|" -f 4`
first_name=`echo $name | cut -d "|" -f 5`
echo "<tr><td>$case_id</td><td>$date</td><td>$suspect_weapon</td><td>$last_name</td><td>$first_name</td></tr>"
done < tables/suspects.psv
echo "</table>"
echo "</body>"
echo "</html>"
