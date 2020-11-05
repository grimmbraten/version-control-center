fetch() {
 if [ ! -z $1 ]; then
  invalid "gf";
 else
  if ! $(run "git fetch -p"); then
   echo false;
   return;
  fi

  prompt $tadaIcon "Successfully synchronized references";
  echo true;
 fi
}