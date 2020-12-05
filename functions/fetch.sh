fetch() {
 if ( $(isCalledWithNoArguments $@) && $(run "git fetch -p") ); then
  successfully "Synchronized references";
  echo true;
 else
  invalid;
  echo false;
 fi
}