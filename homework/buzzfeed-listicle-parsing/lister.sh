

cat data-hold/2014/*/*.html | pup 'li.bf_dom a text{}' | grep -o '[0-9][0-9]' | sort -n | uniq -c | awk -v OFS=, '{print $2,$1}'
