mkdir -p data-hold/geodata
if [[ -s tables/geocodes.psv ]]; then
rm -f tables/geocodes.psv
fi
echo "location|latitude|longitude|" >> tables/geocodes.psv
cat data-hold/*.html | pup 'table table tr json{}' | jq '.[] .children | { 
case_pdf_href: .[0] .children[0] .href, 
case_id: .[0] .children[0] .text, 
date: .[1] .text ,
address: .[2] .text,
suspect_status: .[3] .text,
suspect_weapons: .[4] .text,
suspects: .[5] .text,
officers: .[6] .text,
grand_jury: .[7] .text
}' | jq -r '.address' | grep -v "Location" | 
while read -r x; do 
addr=$(echo $x | tr ' ' '+')
url="https://maps.googleapis.com/maps/api/geocode/json?address=$addr+Dallas+TX"
if [[ -s "data-hold/geodata/$addr.json" ]]; then
echo "Already Downloaded data-hold/geodata/$addr.json"
else
echo "Downloading $url"
curl -s $url > data-hold/geodata/$addr.json
sleep 3
fi
latitude=$(cat data-hold/geodata/$addr.json | jq '.results[0].geometry.location.lat')
longitude=$(cat data-hold/geodata/$addr.json | jq '.results[0].geometry.location.lng')
echo "$x|$latitude|$longitude" >> tables/geocodes.psv
done
