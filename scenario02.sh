#!/bin/bash
source="./example-log-2.txt"

cat $source | awk 'BEGIN {
        FS  = "\n"
        RS  = ""
        OFS = ";"
        ORS = "\n"
        t1  = "2010-03-23T07:45:00"
        t2  = "2010-03-23T08:00:00"
        m1  = "eventTimestamp: " t1
        m2  = "eventTimestamp: " t2
        }
{
    if ($1 >= m1 && $1 <= m2) print $1, $2, $3, $4;
}' "$@"
# cat $source | awk 'BEGIN {
#         FS  = "\n"
#         RS  = ""
#         OFS = ";"
#         ORS = "\n"
#         }
# {print $0;}'