mkdir -p ./data-hold
cd data-hold
curl -o names.zip http://stash.compciv.org/ssa_baby_names/names.zip
unzip -p names.zip yob1973.txt yob2013.txt | dos2unix > namesample.txt
cd ..
