cat fldrroster.asp | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]'

cat fldrold.html | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]'

cat fldrnew.html | pup 'td:nth-of-type(3) text{}' | grep -io '[[:alpha:]][[:alpha:]]'
