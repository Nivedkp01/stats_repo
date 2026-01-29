#!/bin/bash


# 1. Total CPU Usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "  Total Usage: " 100-$1 "%"}'

# 2. Total Memory Usage (Free vs Used)
echo "Memory Usage:"
free -m | grep Mem | awk '{
    printf "  Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3/$2*100
}'

# 3. Total Disk Usage (Free vs Used)
echo "Disk Usage:"
df -h --total | grep 'total' | awk '{
    printf "  Used: %s / Total: %s (%s)\n", $3, $2, $5
}'


# 4. Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6



# 5. Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

