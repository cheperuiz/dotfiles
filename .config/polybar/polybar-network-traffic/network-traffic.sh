#!/bin/bash

print_bytes() {
    #if [ "$1" -eq 0 ] || [ "$1" -lt 100 ]; then
    #    bytes="0 kB/s"
    #elif [ "$1" -lt 1000 ]; then
    #    bytes="0$(echo "scale=1;$1/1000" | bc -l ) kB/s"
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kB/s"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB/s"
    fi

    echo "$bytes"
}

INTERVAL=10
INTERFACES="eno1"

declare -A bytes

for interface in $INTERFACES; do
    bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
    bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"
done

echo $bytes[past_rx_eno1]

while true; do
    down="$(cat /sys/class/net/eno1/statistics/rx_bytes)"
    up="$(cat /sys/class/net/eno1/statistics/tx_bytes)"

    for interface in $INTERFACES; do
        bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
        bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

        bytes_down=$((((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]})) / INTERVAL))
        bytes_up=$((((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]})) / INTERVAL))

        down=$(((( "$down" + "$bytes_down" ))))
        up=$(((( "$up" + "$bytes_up" ))))

        bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
        bytes[past_tx_$interface]=${bytes[now_tx_$interface]}
    done

    echo " $(print_bytes $bytes_down) 祝 $(print_bytes $bytes_up)"

    sleep $INTERVAL
done
