if [ -d .git ]; then

 local root=$(dirname "$0");
 . $root/config/bundler.sh;
 . $root/helpers/bundler.sh;
 . $root/git/bundler.sh;

 # $1: string (git query)
 run() {
  local response=$(eval "$1 2>&1");

  if [ $? -eq 0 ]; then
   if ( $(contains "$response" "error") || $(contains "$response" "fatal") ); then
    error "$1";
    mention "$response" true;
    echo false;
   else
    echo true;
   fi
  fi 
 }

 alias gbt="cat $types/branch.txt | sed s/"%"//";
 alias gbte="nano $types/branch.txt";

 alias gb=branch;
 alias gbo=branch-origins;
 alias gbr=branch-rename;
 alias gbd=branch-delete;
 alias gbdo=branch-delete-origin;

 alias gch=checkout;
 alias gchb=checkout-branch;
 alias gchm=checkout-master;
 alias gchp=checkout-previous;

 alias gc=commit;
 alias gct="cat $types/commit.txt | sed s/"%"//";
 alias gcte="nano $types/commit.txt";
 alias gcu=commitUndo;
 alias gcp=commitPush;
 alias gcr=commitRename;
 alias gca=commitAll;
 alias gcap=commitAllPush;

 alias gf=fetch;

 alias gl=logs

 alias gm=merge;
 alias gmm=mergeMaster;

 alias gpl=pull;

 alias gp=push;
 alias gpu=pushUpstream;

 alias gr=reset;
 alias grt=resetTracked;
 alias gru=resetUntracked;

 alias ga=stage;
 alias gaa=stageAll;

 alias gst=stashes;
 alias gsts=save;
 alias gsta=apply;
 alias gstd=drop;
 
 alias gs=status;
 alias gsd=statusDetailed;
 alias gsa=originAheadCount;
 alias gsb=originBehindCount;
 alias gsam=masterAheadCount;
 alias gsbm=masterBehindCount;

 alias gu=unstage;
 alias gua=unstageAll;
fi