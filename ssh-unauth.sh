#!/bin/bash

# Define log file location based on the OS
if [ -f /etc/debian_version ]; then
  LOG_FILE="/var/log/auth.log"  # Ubuntu/Debian-based
elif [ -f /etc/redhat-release ]; then
  LOG_FILE="/var/log/secure"    # RHEL/CentOS-based
else
  echo "Unsupported OS"
  exit 1
fi

ALERT_THRESHOLD=3   # Number of failed attempts
TIME_WINDOW="10m"   # Time window
ALERT_EMAIL="admin@example.com"  # Email to send alert to

# Define the log pattern to look for (failed SSH attempts)
FAILED_PATTERN="sshd.*Failed password|sshd.*Authentication failure"

# Define a temporary file to store the IPs
TMP_FILE="/tmp/failed_ssh_ips.txt"

# Extract failed SSH login attempts from the log sort and count them and storing to tmp file
grep -i "$FAILED_PATTERN" "$LOG_FILE" | sort | uniq -c > "$TMP_FILE"

# Check the IPs for failed attempts exceeding the threshold
while read -r count ip; do
  if [ "$count" -ge "$ALERT_THRESHOLD" ]; then
# Send an alert if threshold exceeded and mail to administrator about the incident
    cat $TEMP_FILE | mail -s "SSH Login Alert" "$ALERT_EMAIL"

  fi
done < "$TMP_FILE"

# Clean up
rm -f "$TMP_FILE"
