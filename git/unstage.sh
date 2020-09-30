unstage() {
 if [ -z $1 ]; then
  missing "What folder or file would you like to unbundle?";
 elif [ ! -z $2 ]; then
  invalid "gu <folder/file>";
 elif $(runUnstageRequest $1 true); then
  runStatusRequest;
 fi
}

unstageAll() {
 if [ ! -z $1 ]; then
  invalid "gua";
 else
  $(runUnstageRequest "" true);
 fi
}

runUnstageRequest() {
 local target=$1;
 local verbose=$2;
 local resetType;

 local before=$(stagedCount);

 if [ -z $target ]; then
  resetType="reset";
 elif $(isFile $target); then
  resetType="reset $target";
 else
  resetType="reset $target/*";
 fi

 if ! $(run "git $resetType"); then
  echo false;
  return;
 fi

 local after=$(stagedCount);

 if [ ! -z $target ]; then
  if $(isFile $target); then
   target="file";
  else
   target="folder";
  fi

  diff=$(($before - $after));
 else
  diff=$before;
 fi

 local staged=$(stagedCount);
 local total=$(changeCount);

 if [ $diff -eq 0 ]; then
  prompt $disappointed "Could not find any changes to unbundle in that $target _($staged/$total)]" $verbose;
  echo false;
 else   
  prompt $package "Unbundling [$diff] file$(plural $diff) from package... _($staged/$total)]" $verbose;
  echo true;
 fi
}