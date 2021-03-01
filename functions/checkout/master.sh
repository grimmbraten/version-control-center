# checkout local master branch
checkout-master() {
 if $(noArguments $@); then
  $(checkout master);
 else
  invalid;
  echo false;
 fi
}