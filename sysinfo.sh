#!/bin/bash

# Danner Santiago
# CYBIT-210-480
# Server Fundamentals
# Eric Spangler
# 16 May 2025

# Clear the screen of previous commands
clear

# Print a simple header
echo "======================================================"
echo "    Danner's System Information Report Script v1.2    "
echo "======================================================"
echo

# Print system hostname
echo "HOSTNAME:"
hostname
echo

# Print the general information of the OS
echo "OPERATING SYSTEM:"
cat /etc/os-release 
echo

# Print system uptime
echo "SYSTEM UPTIME:"
uptime
echo

# Print kernel name and verison
echo "KERNEL VERSION:"
uname
uname -r
echo

# Print CPU info. Only greps general information and not all the other stuff.
echo "CPU INFORMATION:"
lscpu | grep -E "Model name|Architecture|CPU\(s\)"
echo

# Print memory available in human-raedable output
echo "MEMORY INFORMATION:"
free -h
echo

# Print IP and MAC address info of all network interfaces on the system. Pipe into sed to get rid of annoying spaces
echo "NETWORK INFORMATION:"
ip addr show | grep -E "^[0-9]+:|inet |ether " | sed 's/^[ \t]*//'
echo

# Print filesystem util in human-readable output and its types
echo "FILESYSTEM UTILIZATION + TYPES:"
df -hT
echo

# Print potential error logs (last 5 lines containing 'error', case-insensitive). If no error logs were found, this section simply echoes "No errors found."
echo "LAST 5 ERROR LOGS:"
grep -i "error" /var/log/syslog 2>/dev/null | tail -5 || echo "No errors were found."
echo

# --------------------------------------------
# Extra features are added beyond this point!
# --------------------------------------------

# Print who is currently logged into the System
echo "CURRENTLY LOGGED IN USERS:"
who
echo

# Print last five reboots of the system and their times
echo "LAST 5 SYSTEM REBOOTS:"
last reboot | head -5
echo

# Prints certain statuses of services for the Ubuntu server. Can be added upon if needed. Will print error if service is not found.
echo "SYSTEM SERVICES STATUS:"
systemctl status vsftpd --no-pager 2>/dev/null || echo "vsftpd: Service not found or is missing."
systemctl status apache2 --no-pager 2>/dev/null || echo "apache2: Service not found or is missing."
systemctl status docker --no-pager 2>/dev/null || echo "docker: Service not found or is missing."
echo

# Prints whether any updates are available for any packages
echo "Upgradable packages: $(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)"
echo "Please run 'sudo apt-get update && sudo apt upgrade -y' to upgrade packages"
echo

# Print footer to indicate end of report
echo "======================================================"
echo "           END OF SYSTEM INFORMATION REPORT           "
echo "======================================================"
