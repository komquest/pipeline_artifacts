##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will Create a Unique Server ID that can be fed into Jenkins and Docker as to keep track 
# of new server
##############################################################################################################

ID=$(hexdump -n 4 -e '4/4 "%04X" 1 "\n"' /dev/urandom)
NAME="webserver:${ID}"

echo $NAME