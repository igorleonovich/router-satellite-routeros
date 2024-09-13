# [TODO] Use HTTPS
# [TODO] Use variables
/tool fetch url="http://192.168.88.210:3000/private/router-ssh-key.pub" mode=http dst-path="router-ssh-key.pub"
delay 2s
/user ssh-keys import public-key-file="router-ssh-key.pub" user="ros"