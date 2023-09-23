#!/bin/sh

yes "y" | ssh-keygen -o -a 100 -t ed25519 -C "alpine-sample" -f ./Private/key -N ""
