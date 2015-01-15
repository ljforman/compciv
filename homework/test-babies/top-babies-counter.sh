for txtfile in $(ls data-hold/*.TXT)
do
  cat $txtfile | sort -n -r -t ',' -k 5 | head -n 1
done
