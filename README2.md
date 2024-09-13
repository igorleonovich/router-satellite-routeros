#
# M K R
#

# il-mkr
ssh -p 50022 -o IdentitiesOnly=yes -i ~/.ssh/il-mkr.pem ros@il-mkr.local

# il-mkr-alpine
ssh -p 22 -o IdentitiesOnly=yes -i ~/.ssh/il-mkr-alpine root@il-mkr-alpine.local