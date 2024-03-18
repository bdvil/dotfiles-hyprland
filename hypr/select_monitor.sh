#!/bin/bash

eDP1Monitor="eDP-1"
eDP1MonitorConfig="3840x2160@60, 0x0, 2"
HDMIA2Monitor="HDMI-A-2"
HDMIA2MonitorConfig="1920x1080@60, 0x1080, 1.2"

echo "Only eDP-1|Only HDMI-A-2|Both" | wofi --show dmenu -Ddmenu-separator='|' -Ddmenu-print_line_num=true | {
    out=(
        "hyprctl keyword monitor $HDMIA2Monitor,disable && hyprctl keyword monitor $eDP1Monitor,$eDP1MonitorConfig"
        "hyprctl keyword monitor $eDP1Monitor,disable && hyprctl keyword monitor $HDMIA2Monitor,$HDMIA2MonitorConfig" 
        "hyprctl keyword monitor $eDP1Monitor,$eDP1MonitorConfig && hyprctl keyword monitor $HDMIA2Monitor,$HDMIA2MonitorConfig"
    )
    read -r item
    if ! [[ $item == "" ]]; then
        eval "${out[$item]}"
    fi
}
