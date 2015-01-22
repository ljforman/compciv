
cat wh-briefings-word-scrape/data-hold/* | pup 'div#content' | sed 's/\(<tr>\|<\/tr>\)//g' | sed 's/|/\n/g' | tr [[:upper:]] [[:lower:]] |   grep -oE '[[:alpha:]]{7,}' |   sort | uniq -c |   sort -rn | head -n 10
