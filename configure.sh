#!/bin/sh

yes "y" | ssh-keygen -o -a 100 -t ed25519 -C "router-satellite-alpine" -f ./Private/key -N ""
