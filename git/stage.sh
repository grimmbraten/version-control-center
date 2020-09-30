stage() {
 spacer;

 if [ -z $1 ]; then
  missing "What folder or file would you like to bundle?";
 elif [ ! -z $2 ]; then
  invalid "ga <folder/file> ";
 elif $(runStageRequest $1 true); then
  spacer && git status --short;
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

runStageRequest() { 
 local target=$1;
 local verbose=$2;

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
  prompt $disappointed "Could not find any changes to bundle in that $target _($staged/$total)]" $verbose;
  echo false;
 else
  prompt $package "Bundling [$diff] file$(plural $diff) into a package... _($staged/$total)]" $verbose;
  echo true;
 fi  
}