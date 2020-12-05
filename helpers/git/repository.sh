forest-url() {
 echo $(git config --get remote.origin.url);
}

forest-name() {
 echo $(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p');
}