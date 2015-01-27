cd ~/compciv/homework/death-row-parsing
mkdir data-hold1
cd data-hold1
curl -s http://www.tdcj.state.tx.us/death_row/dr_offenders_on_dr.html > txdr.html
curl -s http://www.tdcj.state.tx.us/death_row/dr_list_all_dr_1923-1973.html > txdrold.html
curl -s http://www.dc.state.fl.us/activeinmates/deathrowroster.asp > fldrroster.asp
curl -s http://www.dc.state.fl.us/oth/deathrow/execlist2.html > fldrold.html
curl -s http://www.dc.state.fl.us/oth/deathrow/execlist.html > fldrnew.html
curl -s http://www.cdcr.ca.gov/capital_punishment/docs/condemnedinmatelistsecure.pdf > cadr.pdf
cd ..


cat data-hold1/txdr.html | pup 'td:nth-of-type(7) text{}' | sed s/Hispanic/TX,Hispanic/ | sed s/White/TX,White/ | sed s/Other/TX,Other/ | sed s/Black/TX,Black/
cat data-hold1/txdrold.html | pup 'td:nth-of-type(4) text{}' | sed s/Hispanic/TX,Hispanic/ | sed s/White/TX,White/ | sed s/Other/TX,Other/ | sed s/Black/TX,Black/


cat data-hold1/fldrroster.asp | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]' | sed s/HF/FL,Hispanic/ | sed s/BM/FL,Black/ | sed s/WM/FL,White/ | sed s/BM/FL,Black/ | sed s/WF/FL,White/ | sed s/OM/FL,Other/ | sed s/HM/FL,Hispanic/ | sed s/BF/FL,Black/

cat data-hold1/fldrold.html | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]' | sed s/HF/FL,Hispanic/ | sed s/BM/FL,Black/ | sed s/WM/FL,White/ | sed s/BM/FL,Black/ | sed s/WF/FL,White/ | sed s/OM/FL,Other/ | sed s/HM/FL,Hispanic/ | sed s/BF/FL,Black/

cat data-hold1/fldrnew.html | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]' | sed s/HF/FL,Hispanic/ | sed s/BM/FL,Black/ |  sed s/WM/FL,White/ | sed s/BM/FL,Black/ | sed s/WF/FL,White/ | sed s/OM/FL,Other/ | sed s/HM/FL,Hispanic/ | sed s/BF/FL,Black/


pdftotext -layout data-hold1/cadr.pdf
cat data-hold1/cadr.txt
cat data-hold1/cadr.txt | grep -oE 'Living .+' |  grep -oE '\b[[:upper:]]{3}\b' | sed s/BLA/CA,Black/ | sed s/WHI/CA,White/ | sed s/HIS/CA,Hispanic/ | sed s/OTH/CA,Other/

