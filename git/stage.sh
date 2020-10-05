stage() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "ga <target> ";
 else
  $(runStageRequest $1 true);
 fi

 spacer;
}

stageAll() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gaa";
 else
  $(runStageRequest . true);
 fi

 spacer;
}

# $1: string  (targeted file or folder to stage)
# $2: boolean (verbose)
runStageRequest() { 
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
  prompt $telescopeIcon "$(capitalize $(getTargetType $target)) does not exist in repository" $2;
  echo false;
 else
  mention "$(git -c color.status=always status --short)\n";
  prompt $packageIcon "Added [$diff file$(plural $diff)] to unlabeled package _($(stagedCount)/$(changeCount))]" $2;
  echo true;
 fi  
}