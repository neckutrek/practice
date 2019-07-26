#!/bin/bash

echo "- - - START - - -"
echo `date "+%Y-%m-%d %H:%M:%S"`
echo "- - -"
echo

input=$(</dev/stdin)

current=0
found=0
freqs=()
while true; do
    
    while read -r; do
    
        LINE=$(printf %s "$REPLY" | tr -d '\r\n')
        
        ((current = current $LINE))
        
        if [[ " ${freqs[*]} " == *" $current "* ]]; then
            found=1
            break
        fi
        
        freqs+=($current)
        
        mapfile -t freqs < <(printf '%s\n' "${freqs[@]}" | sort -n)
        
    done < <(printf %s "$input")
    
    if [[ $found == 1 ]]; then
        break
    fi

done

printf "freq = %s\n" "$current"

echo
echo "- - - FINAL - - -"
