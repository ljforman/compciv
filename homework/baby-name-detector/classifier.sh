
datafile='data-hold/namesample.txt' 
name=$name

if [[ $@ == '' ]]; then
echo "Please input at least one name"
fi

for name in "$@"; do
echo "What's in a $name?"
name_matches=$(cat $datafile | grep "$name,")
m_count=0
f_count=0
for row in $name_matches; do 
babies=$(echo $row | cut -d ',' -f '3')
if [[ $row =~ ',M,' ]]
        then 
        m_count=$((m_count + babies))
else  
        f_count=$((f_count + babies))
fi
done

if [[ m_count -eq 0 && f_count -eq 0 ]]; then
echo "$name,NA,0,0"
else
total_babies=$((m_count + f_count))
pct_female=$((100 * f_count / total_babies))
pct_male=$((100 * m_count / total_babies))
fi

if [[ $pct_female -ge 50 ]]; then 
        g_and_pct="F,$pct_female" 
elif [[ $pct_female == 50 ]]; then 
        g_and_pct="F,$pct_female"
elif [[ $pct_male -ge 50 ]]; then 
        g_and_pct="M,$pct_male"
else 
        g_and_pct="M,$pct_male"
fi

if [[ m_count -gt 0 || f_count -gt 0 ]]; then
echo "$name,$g_and_pct,$total_babies"
fi
done

