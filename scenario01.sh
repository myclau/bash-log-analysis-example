#!/bin/bash
source="./example-log.txt"


#Get Most IP in two date

date_start="01/Jun/2019"
date_end="01/Jun/2019"
#echo ${date_start//\//\\/}
#echo ${date_end//\//\\/}

# assume both day exist in the log, other wise need a while loop keep finding the exist date end
# cat source | grep line date between | get ip field | unique and do count | sort field 1 first (count) field 2 (ip) | print first line | cut ip out

# cut by tab cut -d$'\t'

#using sed
#cat $source | sed -n '/'"${date_start//\//\\/}"'/,/'"${date_end//\//\\/}"'/p' | cut -d ' ' -f 1 | uniq -c | sort -k 1nr,1 -k 2r,2 | head -1 | cut -d ' ' -f 4

#using awk
date_start="01/Jun/2019:00:00:00"
date_end="01/Jun/2019:23:59:59"

#cat $source | remove [ | awk filter from time start to end and return only ip | count ip | sort field 1 first (count) field 2 (ip) | print first line | awk get last field
cat $source | sed "s/\[//g" | awk -vstart="$date_start" -vend="$date_end" '{ if ($4>=start && $4<=end) print $1 }' | uniq -c | sort -k 1nr,1 -k 2n,2 | head -1 | awk '{print $(NF)}'

#sort usage

# Numeric sort (general)	-g / –general-numeric-sort
    # general-numeric
    # support for scientific notation
    # 0.1234e4 = 1234
# Numeric sort (human)	-h / –human-numeric-sort
    # human-numeric
    # 1.234K = 1234
# Numeric	-n / –numeric-sort
    # numeric
    # … < -1 < 0 < 1 < …
# Month	-M / –month-sort
    # month
    # Unknown < Jan < Feb < … < Nov < Dec
# Random	-r / –random-sort
    # random
# Version	-V / –version-sort
    # version

# -t ' ' <-- new seperator

# LC_ALL=C sort ascii.txt sort by ascii

# F1.C1[sorting options],F2.C2
# The F1 and F2 stand for the field indexes. In this case, they are 1 for the 1st field.
# C1 is the character index within field F1 to begin the sort comparison. If we don’t define a C1, the comparison starts from the 1st character of the field F1.
# C2 is the character index within field F2 to end the sort comparison. If we omit C2, the sorting comparison ends at the last character of the field F2.
# In our example, to exclude the titles from the Name field, the sorting comparison should start from the 4th character. Therefore, we have “-k 1.4,1″.

# https://www.baeldung.com/linux/sort-command