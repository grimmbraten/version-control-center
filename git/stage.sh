stage() {
 if [ -z $1 ]; then
  missing "What folder or file would you like to bundle?";
 elif [ ! -z $2 ]; then
  invalid "ga <folder/file> ";
 elif $(runStageRequest $1 true); then
  runStatusRequest;
 fi
}

stageAll() {
 if [ ! -z $1 ]; then
  invalid "gaa";
 else
  $(runStageRequest . true);
 fi
}

runStageRequest() { 
 local target=$1;
 local output=$2;
 local diff;

 local before=$(unstagedCount);

 if ! $(run "git add $target"); then
  echo false;
  return;
 fi

 local after=$(unstagedCount);
 
 if [ $target != . ]; then
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
  prompt $dissapointed "Could not find any changes to bundle in that $target _($staged/$total)]" $output;
  echo false;
 else
  prompt $package "Bundling [$diff] file$(plural $diff) into a package... _($staged/$total)]" $output;
  echo true;
 fi  
}