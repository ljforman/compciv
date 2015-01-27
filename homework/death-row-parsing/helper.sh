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
