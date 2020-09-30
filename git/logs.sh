logs() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gl";
 else
  runLogsRequest;
 fi

 spacer;
}

runLogsRequest() {
 git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset';
}

