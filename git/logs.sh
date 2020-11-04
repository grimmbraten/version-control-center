logs() {
 if [ ! -z $1 ]; then
  invalid "gl";
 else
  git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset';
 fi
}