stage() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "ga <target> ";
  echo false;
  return;
 fi

 local diff;
 local before=$(unstagedCount);

 if ! $(run "git add $1"); then
  echo false;
  return;
 fi

 local after=$(unstagedCount);
 
 if [ $1 != . ]; then
  diff=$(($before - $after));
 else
  diff=$before;
 fi
 
 if [ $diff -eq 0 ]; then
  prompt $telescopeIcon "Could not find $(getTargetType $target)";
  echo false;
 else
  mention "$(git -c color.status=always status --short)\n";
  prompt $packageIcon "Added [$diff] file$(plural $diff) to package _($(stagedCount)/$(changeCount))]";
  echo true;
 fi 
}

stage-all() {
 if [ ! -z $1 ]; then
  invalid "gaa";
 else
  $(stage .);
 fi
}