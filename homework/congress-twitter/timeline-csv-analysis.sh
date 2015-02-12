username=$1
mkdir -p ./data-hold
echo "Fetching tweets for $username into ./data-hold/$username"
file="./data-hold/$username"

t timeline -n 3200 --csv $username > $file
count=$(csvfix order -f 1 $file | wc -l)
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)
echo "Analyzing $count tweets by $1 since $lastdate"

echo "Top 10 hashtags by $username"
cat $file | csvfix order -fn 'Text' | grep -oE '#[A-z0-9_]+' | tr "[:upper:]" "[:lower:]" | sort | uniq -c | sort -rn | head -n 10 

echo "Top 10 retweeted users by $username"
cat $file | csvfix order -fn 'Text' |  grep -oE 'RT @[A-z0-9_]+' | grep -oE '@[A-z0-9_]+' | sort | uniq -c | sort -rn | head -n 10

echo "Top 10 mentioned users (not including retweets) by $username"
 cat $file | csvfix order -fn 'Text' | grep -v "RT" | grep -oE '@[A-z0-9_]+' | tr "[:upper:]" "[:lower:]" | sort | uniq -c | sort -rn | head -n 10 

echo "Top tweeted 10 words with 5+ letters by $username"
cat $file | csvfix order -fn 'Text' | grep -oE '[[:alpha:]]{5,}' | sort | uniq -c | sort -rn | head -n 10
