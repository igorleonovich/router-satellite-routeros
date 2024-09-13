#
# M K R
#

# il-mkr
# Local: 192.168.88.1:50022
# Global: 192.168.88.1_global_ip:50022
function mkr-ros() {
  ssh -p 50022 -o IdentitiesOnly=yes -i ~/.ssh/il-mkr2_rsa.pem ros@il-mkr.local
  # ssh -p 50022 -o IdentitiesOnly=yes ros@il-mkr.local
}

# il-mkr-alpine
# Local: 192.168.88.2:50122
# Global: 192.168.88.1_global_ip:50122
function mkr-alpine-root() {
  ssh -p 50122 -o IdentitiesOnly=yes -i ~/.ssh/il-mkr-alpine root@il-mkr-alpine.local
  # ssh root@il-mkr-alpine.local
}