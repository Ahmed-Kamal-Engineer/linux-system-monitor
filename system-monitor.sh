#!/usr/bin/env bash

REPORT_DIR="./reports"

mkdir -p "$REPORT_DIR"

REPORT_FILE="$REPORT_DIR/report_$(date +%Y-%m-%d_%H-%M-%S).txt"


system_info() {
    echo "===== SYSTEM INFORMATION ====="

    echo "Hostname: $(hostname)"
    echo "Operating System: $(grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2)"
    echo "Date: $(date)"
    echo "Uptime: $(uptime -p)"

    echo
}


cpu_usage() {
    echo "===== CPU INFORMATION ====="

    echo "CPU Cores: $(nproc)"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"

    echo
}


memory_usage() {
    echo "===== MEMORY USAGE ====="

    free -h

    echo
}


disk_usage() {
    echo "===== DISK USAGE ====="

    df -h

    echo
}


top_processes() {
    echo "===== TOP 5 PROCESSES ====="

    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

    echo
}


log_analysis() {
    echo "===== LOG ANALYSIS ====="

    if [ -f /var/log/syslog ]; then
        grep -i "error" /var/log/syslog | tail -n 10

    elif [ -f /var/log/messages ]; then
        grep -i "error" /var/log/messages | tail -n 10

    else
        echo "No log file found."
    fi

    echo
}


service_monitor() {
    echo "===== SERVICE STATUS ====="

    services=("ssh" "cron")

    for service in "${services[@]}"; do

        if systemctl is-active --quiet "$service"; then
            echo "$service is running"

        else
            echo "$service is not running"
        fi

    done

    echo
}


generate_report() {

    {
        system_info
        cpu_usage
        memory_usage
        disk_usage
        top_processes
        log_analysis
        service_monitor

    } > "$REPORT_FILE"

    echo "Report generated successfully!"
    echo "File: $REPORT_FILE"
}


while true; do

    echo "=============================="
    echo "      LINUX SYSTEM MONITOR"
    echo "=============================="

    echo "1. System Information"
    echo "2. CPU Usage"
    echo "3. Memory Usage"
    echo "4. Disk Usage"
    echo "5. Top Processes"
    echo "6. Analyze Logs"
    echo "7. Check Services"
    echo "8. Generate Full Report"
    echo "0. Exit"

    read -rp "Choose an option: " choice

    case "$choice" in

        1) system_info ;;
        2) cpu_usage ;;
        3) memory_usage ;;
        4) disk_usage ;;
        5) top_processes ;;
        6) log_analysis ;;
        7) service_monitor ;;
        8) generate_report ;;

        0)
            echo "Goodbye!"
            break
            ;;

        *)
            echo "Invalid option!"
            ;;

    esac

    echo
    read -rp "Press Enter to continue..."

done
