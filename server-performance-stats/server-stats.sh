echo "===== SYSTEM USAGE SUMMARY ====="
echo

echo "######################"
echo "# System Uptime Info #"
echo "######################"

uptime

echo

echo "###################"
echo "# Total CPU Usage #"
echo "###################"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
	awk '{print 100 - $8}')

echo "${CPU_USAGE}%"

echo

echo "######################"
echo "# Total Memory Usage #"
echo "######################"

free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, ($3/$2)*100}'

echo

echo "####################"
echo "# Total Disk Usage #"
echo "####################"

df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s used)\n", $3, $2, $5}'

echo

echo "###################################"
echo "# Top 5 Processes by Memory Usage #"
echo "###################################"

ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo

echo "################################"
echo "# Top 5 Processes by CPU Usage #"
echo "################################"

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo
echo "================================"
