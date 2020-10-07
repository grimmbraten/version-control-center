unstage() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gu <target>";
 else
  $(runUnstageRequest $1 true);
 fi

 spacer;
}

unstageAll() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gua";
 else
  $(runUnstageRequest "" true);
 fi

 spacer;
}

# $1: string  (targeted file or folder to unstage)
# $2: boolean (verbose)
runUnstageRequest() {
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
  prompt $telescopeIcon "$(capitalize $(getTargetType $target)) does not exist in repository" $2;
  echo false;
 else
  mention "$(git -c color.status=always status --short)\n";
  prompt $packageIcon "Removed [$diff file$(plural $diff)] from unlabeled package _($(stagedCount)/$(changeCount))]" $2;
  echo true;
 fi
}