#!/bin/bash

mainMonitor="eDP-1"
mainMonitorConfig="3840x2160@60, 0x0, 2"
secondaryMonitor="HDMI-A-2"
secondaryMonitorConfig="1920x1080@60, 0x1080, 1.2"

echo "Only Main Monitor|Only Second Monitor|Both Monitors" | wofi --show dmenu -Ddmenu-separator='|' -Ddmenu-print_line_num=true | {
    out=(
        "hyprctl keyword monitor $mainMonitor,$mainMonitorConfig && hyprctl keyword monitor $secondaryMonitor,disable"
        "hyprctl keyword monitor $secondaryMonitor,$secondaryMonitorConfig && hyprctl keyword monitor $mainMonitor,disable" 
        "hyprctl keyword monitor $mainMonitor,$mainMonitorConfig && hyprctl keyword monitor $secondaryMonitor,$secondaryMonitorConfig"
    )
    read -r item
    if ! [[ $item == "" ]]; then
        eval "${out[$item]}"
    fi
}
