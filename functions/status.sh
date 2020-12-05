status() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  return;
 fi

 local changes=$(leafs);
  
 if [ $changes -gt 0 ]; then
  $(status-list true);
 fi

 spacer;
  
 prompt $(plant-icon $changes) "$(plant-name $changes) with *$changes. file$(pluralize $changes) #($(unbundled-leafs)/$(bundled-leafs))";
}

status-detailed() {
 if $(isCalledWithNoArguments $@); then
  #TODO, make detailed status custom instead of using default git status command
  #Example, have lines below describing behind/ahead of origin/master etc.
  git status;
 else
  invalid;
 fi
}

status-list() {
 if [ "$1" = "true" ]; then
  mention "$(git -c color.status=always status --short)\n";
 else
  mention "$(git -c color.status=always status --short)";
 fi
}

#TODO Add additional commands to display specific statuses, eg. ahead of origin/master etc.