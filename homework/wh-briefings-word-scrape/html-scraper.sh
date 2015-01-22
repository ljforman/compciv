cat data-hold/* | pup 'div#content text{}' | \
tr [[:upper:]] [[:lower:]] |   grep -oE '[[:alpha:]]{7,}' |\
sort | uniq -c |   sort -rn | head -n 10
