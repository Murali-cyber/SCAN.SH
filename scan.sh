#!/bin/bash

#!/bin/bash

cat << "EOF"


░██████╗░█████╗░░█████╗░███╗░░██╗░░░░██████╗██╗░░██╗
██╔════╝██╔══██╗██╔══██╗████╗░██║░░░██╔════╝██║░░██║
╚█████╗░██║░░╚═╝███████║██╔██╗██║░░░╚█████╗░███████║
░╚═══██╗██║░░██╗██╔══██║██║╚████║░░░░╚═══██╗██╔══██║
██████╔╝╚█████╔╝██║░░██║██║░╚███║██╗██████╔╝██║░░██║
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚═════╝░╚═╝░░╚═╝

EOF


# Check if a domain was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi


DOMAIN=$1

# Blank Report creation

#!/bin/bash

# Define the directory and file name
DIRECTORY="./"  # You can change this to any directory
BASENAME="${DOMAIN}_scan_report"
EXTENSION=".txt"

# Check if the base file exists
if [[ -e "$DIRECTORY$BASENAME$EXTENSION" ]]; then
  # If file exists, increment file name with a number
  COUNT=1
  while [[ -e "$DIRECTORY$BASENAME$COUNT$EXTENSION" ]]; do
    COUNT=$((COUNT + 1))
  done
  # Create the new numbered file
  OUTPUT_FILE="$DIRECTORY$BASENAME$COUNT$EXTENSION"

else
  # Create the base file if it doesn't exist
  OUTPUT_FILE="${DOMAIN}_scan_report.txt"
fi
 




# Run nslookup and extract the IP address
echo "Running nslookup for $DOMAIN..." >> $OUTPUT_FILE
IP=$(nslookup $DOMAIN | grep -A 1 "Name:" | grep "Address:" | tail -n 1 | awk '{print $2}')

nslookup $DOMAIN >> $OUTPUT_FILE

# Check if nslookup was successful
if [ -z "$IP" ]; then
  echo "Error: Unable to resolve domain $DOMAIN" >> $OUTPUT_FILE
  exit 1
fi

echo "IP Address for $DOMAIN is: $IP" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE


# Run nmap on the IP address and append the result to the same file
echo "Running nmap for $IP..." >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
nmap $IP >> $OUTPUT_FILE


# You can add more commands and append their outputs
echo "Running whois for $DOMAIN..." >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
whois $DOMAIN >> $OUTPUT_FILE



echo "All results saved to $OUTPUT_FILE"
