# checkout previous local working branch
checkout-previous() {
 if $(noArguments $@); then
  local branch=$(git rev-parse --symbolic-full-name @{-1});  
  $(checkout ${branch#"refs/heads/"});
 else
  invalid;
  echo false;
 fi
}