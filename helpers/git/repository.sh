# returns the repository url
repository-url() {
 echo $(git config --get remote.origin.url);
}

# returns the repository name
repository-name() {
 echo $(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p');
}