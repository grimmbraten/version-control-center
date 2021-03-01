# returns the repository url
repository-url() {
 echo $(git config --get remote.origin.url);
}