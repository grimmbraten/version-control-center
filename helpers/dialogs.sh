# $1: string (question for the user)
question() {
 if [ ! -z $1 ]; then
  prompt $thinkingIcon "[Yes/no]: $1";
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

# $1: string (message describing intended action)
confirmIdentity() {
 if [ ! -z $1 ]; then
  local identity=$(identity);

  prompt $alarmIcon "You are about to $1";
  prompt $lockIcon "Please enter [$identity] to confirm this action";
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