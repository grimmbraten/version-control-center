question() {
 if [ ! -z $1 ]; then
  prompt $thinking "[Yes/no]: $1";
  local answer=$(bash -c 'read -e -p "" tmp; echo $tmp')

  if [[ $answer = Yes || $answer = yes || $answer = Y || $answer = y ]]; then
   echo true;
  else
   echo false;
  fi
 else
  echo false;
 fi
}

confirmIdentity() {
 if [ ! -z $1 ]; then
  local identity=$(identity);

  prompt $alarm "You are about to $1";
  prompt $keylock "Please enter [$identity] to confirm this action";
  local input=$(bash -c 'read -e -p "" tmp; echo $tmp')

  if [ "$input" = "$identity" ]; then
   echo true;
  else
   echo false;
  fi
 else
  echo false;
 fi
}