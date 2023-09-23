#!/bin/sh

# [WARNING] Clean all stopped Docker resources
docker system prune -a -f

./up.sh
