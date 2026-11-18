# Linux System Monitor

## Overview
An interactive Bash script that monitors a Linux system and generates a full health report. It runs from a simple menu, so each check can be run on its own or all together in a single timestamped report file.

## Features
- **System Information:** hostname, OS, date, and uptime
- **CPU:** number of cores and load average
- **Memory:** usage summary with `free -h`
- **Disk:** usage per filesystem with `df -h`
- **Top Processes:** top 5 processes by CPU usage
- **Log Analysis:** last 10 error entries from `/var/log/syslog` or `/var/log/messages`
- **Service Monitor:** checks whether key services are running using `systemctl`
- **Full Report:** saves everything to `reports/report_YYYY-MM-DD_HH-MM-SS.txt`

## Technologies Used
Bash scripting, functions, loops, `case` statements, `awk`, `grep`, `systemctl`, standard Linux utilities (`ps`, `free`, `df`, `uptime`)

## Requirements
- Linux with systemd (tested on: ubuntu)
- Bash 4+

## Menu
1. System Information
2. CPU Usage
3. Memory Usage
4. Disk Usage
5. Top Processes
6. Analyze Logs
7. Check Services
8. Generate Full Report
0. Exit

## Future Improvements
- Make the monitored services configurable
- Add email alerts when disk or memory usage passes a threshold
- Schedule automatic reports with cron
