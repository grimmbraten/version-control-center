logs() {
 if [ ! -z $1 ]; then
  invalid "gl";
 else
  runLogsRequest;
 fi
}

runLogsRequest() {
 git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset';
}

