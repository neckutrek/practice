# Hello World Program in Bash Shell

echo "- - - START - - -"
echo `date "+%Y-%m-%d %H:%M:%S"`
echo "- - -"
echo

input=$(</dev/stdin)

current=0
freqs=()
while true; do
    
    while read -r; do
    
        LINE=$(printf %s "$REPLY" | tr -d '\r\n')
        ((current = current $LINE))
        
        if [[ " ${freqs[*]} " == *" $current "* ]]; then
            break 2
        fi
        
        freqs+=($current)
        mapfile -t freqs < <(printf '%s\n' "${freqs[@]}" | sort -n)
        
    done < <(printf %s "$input")
done

printf "freq = %s\n" "$current"

echo
echo "- - - FINAL - - -"
