
baseurl="http://www.cdph.ca.gov"
curl -s http://www.cdph.ca.gov/programs/immunize/pages/immunizationlevels.aspx  | pup 'a attr{href}' | grep -i 'Kindergarten' | grep 'xls' |
while read -r line; do 
   url="$baseurl$line"
   yearnum=$(echo $url | grep -oE '/[0-9]{2,4}-[0-9]{2,4}' | tr -d '/')
   echo $url

   curl -s $url > $yearnum.xls

done
