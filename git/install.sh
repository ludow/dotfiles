echo ""
echo "[Git]"

echo "››› Setup .gitconfig"

git_config () {
  GIT_CREDENTIAL="cache"

  if [ "$(uname -s)" == "Darwin" ]
  then
    GIT_CREDENTIAL="osxkeychain"
  fi

  echo "- What is your github author name ?"
  read GIT_AUTHORNAME

  echo "- What is your github author email ?"
  read GIT_AUTHOREMAIL

  sed -e "s/AUTHORNAME/${GIT_AUTHORNAME}/g" -e "s/AUTHOREMAIL/${GIT_AUTHOREMAIL}/g" -e "s/GIT_CREDENTIAL_HELPER/${GIT_CREDENTIAL}/g" ./git/gitconfig.symlink.example > ./git/gitconfig.symlink

  echo "Creating gitconfig.symlink file"
}

if [ ! -f "./git/gitconfig.symlink" ]
then
  git_config
fi

exit 0
