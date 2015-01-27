curl -s http://www.cdcr.ca.gov/capital_punishment/docs/condemnedinmatelistsecure.pdf > cadr.pdf

pdftotext -layout cadr.pdf

cat cadr.txt

cat cadr.txt | grep -oE 'Living .+' |  grep -oE '\b[[:upper:]]{3}\b' 
