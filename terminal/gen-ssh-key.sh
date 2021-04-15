#Gen new SSH key
echo ">> Generating new SSL key for GIT"
ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519 -C $1
ssh-add -K ~/.ssh/id_ed25519
echo "> PUB KEY FOR GIT"
cat ~/.ssh/id_ed25519.pub
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
