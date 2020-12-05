checkout-master() {
 if $(isCalledWithNoArguments $@); then
  $(checkout master);
 else
  invalid;
  echo false;
 fi
}