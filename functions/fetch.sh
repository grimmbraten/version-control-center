fetch() {
 if $(isCalledWithNoArguments $@); then
  prompt $boots "Hiking throughout $(repository-name) ##($(repository-url))..";

  if $(run "git fetch -p"); then
   prompt $compass "Discovered every nook and cranny";
   echo true;
  else
   error "Failed to map out remote destination";
   echo false;
  fi
 else
  invalid;
  echo false;
 fi
}