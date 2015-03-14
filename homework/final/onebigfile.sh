old_years="2000-2001.txt
2001-2002.txt
2002-2003.txt
2003-2004.txt
2004-2005.txt
2005-2006.txt
2006-2007.txt
2007-2008.txt
2008-2009.txt
2009-2010.txt
2010-2011.txt"


new_years="2011-2012.txt
2012-2013.txt
2013-2014.txt
2014-2015.txt"


rm -f all.txt
for file in $old_years $new_years; do
  echo $file
  cat $file | grep -E '^[0-9]{6,}' | while read -r line; do
        echo $file,$line
    echo $file,$line >> all.txt
  done
done



