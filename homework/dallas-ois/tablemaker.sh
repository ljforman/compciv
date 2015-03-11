if [[ -s tables/incidents.psv ]]; then
rm -f tables/incidents.psv
fi
if [[ -s tables/officers.psv ]]; then
rm -f tables/officers.psv
fi
if [[ -s tables/suspects.psv ]]; then
rm -f tables/suspects.psv
fi
echo "case_number|date|location|suspect_status|suspect_weapon|suspects|officers|grand_jury|latitude|longitude|narrative" >> tables/incidents.psv
echo "case_number|date|suspect_killed|suspect_weapon|last_name|first_name|race|gender" >> tables/officers.psv
echo "case_number|date|suspect_weapon|last_name|first_name" >> tables/suspects.psv
cases=(`cat data-hold/*.html | pup 'table table tr json{}' | jq '.[] .children | { 
case_pdf_href: .[0] .children[0] .href, 
case_id: .[0] .children[0] .text, 
date: .[1] .text ,
address: .[2] .text,
suspect_status: .[3] .text,
suspect_weapons: .[4] .text,
suspects: .[5] .text,
officers: .[6] .text,
grand_jury: .[7] .text
}' | jq -r .case_id | grep -v null | tr "\n" " "`)
for case_id in ${cases[*]}; do
echo "Processing case $case_id"
json_blob=`cat data-hold/*.html | pup 'table table tr json{}' | jq '.[] .children | { 
case_pdf_href: .[0] .children[0] .href, 
case_id: .[0] .children[0] .text, 
date: .[1] .text ,
address: .[2] .text,
suspect_status: .[3] .text,
suspect_weapons: .[4] .text,
suspects: .[5] .text,
officers: .[6] .text,
grand_jury: .[7] .text
}' | jq 'select(.case_id=="'${case_id}'")' `
date=`echo $json_blob | jq -r .date`
location=`echo $json_blob | jq -r .address`
suspect_status=`echo $json_blob | jq -r .suspect_status`
suspect_weapon=`echo $json_blob | jq -r .suspect_weapons`
suspects=`echo $json_blob | jq -r .suspects`
officers=`echo $json_blob | jq -r .officers`
grand_jury=`echo $json_blob | jq -r .grand_jury`
case_file_name=`echo $json_blob | jq -r .case_pdf_href`
case_file_name=$(basename $case_file_name | cut -d'.' --complement -f2-)
latitude=`grep "$location" tables/geocodes.psv | cut -d "|" -f 2`
longitude=`grep "$location" tables/geocodes.psv | cut -d "|" -f 3`
narrative=$(cat data-hold/pdfs/$case_file_name.txt | tr "\n" " " )
echo "$case_id|$date|$location|$suspect_status|$suspect_weapon|$suspects|$officers|$grand_jury|$latitude|$longitude|$narrative" >> tables/incidents.psv

echo $suspect_status | grep -q "DECEASED"
if [[ $? -eq 0 ]]; then
suspect_killed="TRUE"
else
suspect_killed="FALSE"
fi
slashes_found=$(echo $officers | grep -o "/" | wc -l)
(( slashes_found-- ))
for i in `seq 0 $slashes_found`; do

first=`echo $officers | cut -d "/" -f $(($i + 1))`

second=`echo $officers | cut -d "/" -f $(($i + 2))`
last_name=`echo $first| cut -d "," -f 1 | sed 's/^[A-Z]\{1\} //'`
first_name=`echo $first| cut -d "," -f 2 | sed 's/ [A-Z]\{1\}$//'`
first_name=${first_name:1}
race=`echo ${first:(-1)}`
gender=`echo ${second:0:1}`
done

echo "$case_id|$date|$suspect_killed|$suspect_weapon|$last_name|$first_name|$race|$gender" >> tables/officers.psv

slashes_found=$(echo $suspects | grep -o "/" | wc -l)
(( slashes_found-- ))
for i in `seq 0 $slashes_found`; do

first=`echo $officers | cut -d "/" -f $(($i + 1))`

second=`echo $officers | cut -d "/" -f $(($i + 2))`
last_name=`echo $first| cut -d "," -f 1 | sed 's/^[A-Z]\{1\} //'`
first_name=`echo $first| cut -d "," -f 2 | sed 's/ [A-Z]\{1\}$//'`
first_name=${first_name:1}
race=`echo ${first:(-1)}`
gender=`echo ${second:0:1}`
done

echo "$case_id|$date|$suspect_weapon|$last_name|$first_name" >> tables/suspects.psv
done
