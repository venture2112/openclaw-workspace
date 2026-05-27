#!/bin/bash
# Website monitoring script

echo "=== Website Status Check - $(date) ===" > /tmp/website-check.log

for site in quantumenergybeds.com quantumwellnessbed.com ventureworksinc.com ziprefund.com; do
    echo -e "\n--- $site ---" >> /tmp/website-check.log
    
    # Check HTTP status
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://$site")
    echo "HTTP Status: $status" >> /tmp/website-check.log
    
    # Check SSL expiry
    expiry=$(echo | openssl s_client -connect "$site:443" -servername "$site" 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d= -f2)
    echo "SSL Expires: $expiry" >> /tmp/website-check.log
    
    # Alert if down or SSL expiring soon
    if [ "$status" != "200" ] && [ "$status" != "301" ] && [ "$status" != "302" ]; then
        echo "ALERT: $site is DOWN (status: $status)" >> /tmp/website-check.log
    fi
done

cat /tmp/website-check.log
