cat data-hold/* | pup 'p text{}' | grep -oE '[[:alpha:]]{7,}+' | sort | uniq -c | sort -rn | head -n 10
