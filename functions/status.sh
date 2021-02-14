status() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  return;
 fi
  
 $(status-list true);

 local commits=$(plant-size);
  
 prompt $(plant-icon) "$(plant-name) with **$commits.. commit$(pluralize $commits) ##($(unstaged)/$(staged))..";
}

status-detailed() {
 if $(isCalledWithNoArguments $@); then
  #TODO, make detailed status custom instead of using default git status command
  #Example, have lines below describing behind/ahead of origin/master etc.
  mention "$(git status)";
 else
  invalid;
 fi
}

status-list() {
 if [ $(changes) -eq 0 ]; then
  return;
 fi

 if [ "$1" = "true" ]; then
  mention "$(git -c color.status=always status --short)\n";
 else
  mention "$(git -c color.status=always status --short)";
 fi
}

#TODO Add additional commands to display specific statuses, eg. ahead of origin/master etc.