
school_name="$1"
source_file="allfixed.txt"

grep "$school_name" $source_file |  cut  -d ',' -f 1,8 | sed 's/.txt//' | csvfix echo -smq   | cut -c 1-4,10-14 | tr  ',' ' ' > $1.txt
