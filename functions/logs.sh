# print out git graph
logs() {
 if $(noArguments $@); then
   git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset';
   echo true;
 else
  invalid;
  echo false;
 fi 
}