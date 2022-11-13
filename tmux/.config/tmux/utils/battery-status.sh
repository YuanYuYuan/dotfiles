#!/usr/bin/env bash


if [ -z "$(ls /sys/class/power_supply/ | grep 'BAT')" ]; then
    hostname
    exit
fi

acpi_info=$(acpi -b | grep -v 'Unknown' | grep -v 'unavailable' | head -n 1 | cut -d ":" -f 2- | sed "s/,//g" | sed "s/Not charging/Discharging/g")
percentage=$(echo $acpi_info | cut -d " " -f 2)
case $(echo $acpi_info | cut -d " " -f 1) in
    D*) case $percentage in
            [0-9]%|1[0-5]%)      battery_status=" ";;
            1[6-9]%|2[0-5]%)     battery_status=" ";;
            2[6-9]%|[3-4][0-9]%) battery_status=" ";;
            [5-9][0-9]%)         battery_status=" ";;
            100%)                battery_status=" ";;
            *)                   battery_status="Error";;
        esac;;
    F*) battery_status=" ";;
    C*) battery_status="";;
    # *)  battery_status="Error";;
    *)  battery_status=" Charging";;
esac
remained_time=$(echo $acpi_info | cut -d " " -f 3)

echo -n "$battery_status"

if [[ $percentage != "" ]]; then
    echo -n " $percentage"
fi

if [[ $remained_time != "" ]]; then
    echo -n " $remained_time"
fi
