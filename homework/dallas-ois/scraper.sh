curl -s "http://www.dallaspolice.net//ois/ois.html" -o "data-hold/ois.html"
for snum in `seq 2003 2012`; do 
if [[ ! -s "data-hold/$snum.html" ]]; then
curl -s "http://www.dallaspolice.net//ois/ois_$snum.html" -o "data-hold/$snum.html"
fi
done
cat data-hold/*.html | pup 'a attr{href}' | grep 'narrative' > urls.txt
mkdir -p pdfs
mv urls.txt pdfs
cd pdfs
allthings=$(cat urls.txt)
mv urls.txt ..
for x in $allthings; do 
filename=$(basename $x | cut -d'.' --complement -f2-)
if [[ ! -s "$filename.pdf" ]]; then
echo 'I am downloading' http://www.dallaspolice.net$x
curl http://www.dallaspolice.net/$x -O
fi
if [[ ! -s "$filename.txt" ]]; then
pdftotext $filename.pdf
fi
done

