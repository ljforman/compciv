
dirname="data-hold/scrapes/$(date +'%Y-%m-%d_%H00')"
mkdir -p $dirname

numbers=$(cat data-hold/OccupationalSeries.xml | grep -oE 'JobFamily>\b[0-9]{4}\b<' | grep -oE '[0-9]+' | sort | uniq )

puppy="https://data.usajobs.gov/api/jobs?NumberOfJobs=250"


for n in $numbers; do 
# curl -o 
  curl "$puppy&series=$n"  -so "$dirname/$n-1.json" 
  echo "$dirname/$n-1.json" 
  
  total_pages=$(cat "$dirname/$n-1.json" | jq -r '.Pages') 

  for page_number in $(seq 2 $total_pages); do 
    curl "$puppy&series=$n&Page=$page_number" -so "$dirname/$n-$page_number.json"
    echo "$dirname/$n-$page_number.json"
  done
done

