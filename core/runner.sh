# $1: string (git query)
run() {
 local response=$(eval "$1 2>&1");

 if [ $? -eq 0 ]; then
  if ( $(contains "$response" "error") || $(contains "$response" "fatal") ); then
   error "$1";
   mention "$response";
   echo false;
  else
   echo true;
  fi
 fi 
}