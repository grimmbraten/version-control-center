# print compact status summary of working branch
status() {
 if ! $(noArguments $@); then
  invalid;
  return;
 fi
  
 $(status-list true);

 local commits=$(plant-size);
  
 prompt $(plant-icon) "$(plant-name) with **$commits.. commit$(pluralize $commits) ##($(unstaged)/$(staged))..";
}

# print detailed status summary of working branch
status-detailed() {
 if $(noArguments $@); then
  #TODO, make detailed status custom instead of using default git status command
  #Example, have lines below describing behind/ahead of origin/master etc.
  mention "$(git status)";
 else
  invalid;
 fi
}

# print list of changed files in working branch
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