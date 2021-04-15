#Input config
read -p "Work Email: " workemail
read -p "Work Git Name: " wgitname

#Homebrew install
echo ">>>>> Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ $? -ne 0 ]; then
  echo "homebrew install failure, exiting. Rerun script"
  exit 1
fi
echo ">>>>> Done"

#Zsh install
echo ">>>>> Install zsh"
homebrew install zsh
if [ $? -ne 0 ]; then
  echo "zsh install failure, exiting. Rerun script"
  exit 1
fi
echo ">>>>> Done"

#Common Dirs
echo ">> Building Common Dirs"
mkdir ~/Projects
mkdir ~/myscripts
cp ./terminal/sources/* ~/myscripts

SOURCES=~/myscripts/*
for f in $SOURCES
do
  echo "> Adding $f to zshrc"
  echo "source ~/myscripts/$f" >> ~/.zshrc
done
echo ">> Done"

#Oh My Zsh
echo ">> Install Oh My Zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ $? -ne 0 ]; then
  echo "oh my zsh install failure, exiting. Rerun script"
  exit 1
fi
echo ">> Done"

#Powerleve10k
echo ">> Powerleve10k Install"
brew install romkatv/powerlevel10k/powerlevel10k
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
echo ">> Done"

#Common App Install
echo ">> Installing Common Apps"
./terminal/commonapps.sh
echo ">> Done"

#Git SSL key and user config
if `git --version`; then
  ./terminal/config-git-user.sh $wgitname $workemail
else
  echo ">> Git not installed correctly."
  echo "Install Git then run:"
  echo "./terminal/config-git-user.sh [name] [email]"
fi
./terminal/gen-ssh-key.sh $workemail

echo ">> Setting Default Shell"
chsh -s /bin/zsh
