unstage() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gu <target>";
  echo false;
  return;
 fi

 local query;

 if [ -z $1 ]; then
  query="reset";
 elif $(isFile $1); then
  query="reset $1";
 else
  query="reset $1/*";
 fi

 local before=$(stagedCount);

 if ! $(run "git $query"); then
  echo false;
  return;
 fi

 local after=$(stagedCount);

 if [ ! -z $1 ]; then
  diff=$(($before - $after));
 else
  diff=$before;
 fi

 if [ $diff -eq 0 ]; then
  prompt $telescopeIcon "could not find $(getTargetType $target)";
  echo false;
 else
  mention "$(git -c color.status=always status --short)\n";
  prompt $packageIcon "Removed [$diff] file$(plural $diff) from package _($(stagedCount)/$(changeCount))]";
  echo true;
 fi
}

unstage-all() {
 if [ ! -z $1 ]; then
  invalid "gua";
 else
  $(unstage "");
 fi
}