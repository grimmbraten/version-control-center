if [ -d .git ]; then

 local root=$(dirname "$0");
 . $root/helpers/bundler.sh
 . $root/git/bundler.sh

 run() {
  local response=$(eval "$1 2>&1");

  if [ $? -eq 0 ]; then
   echo true;
  else
   error "$1";
   spacer;
   prompt "" $response true;
   echo false;
  fi
 }

 alias gb=branches;
 alias gbpe='nano branch.txt';
 alias gbp='cat branch.txt | sed s/"%"//';
 alias gbo=branchOrigins;
 alias gbr=branchRename;
 alias gbd=branchDelete;
 alias gbdo=branchDeleteOrigin;

 alias gch=checkout;
 alias gchb=checkoutCreateBranch;
 alias gchm=checkoutMaster;
 alias gchp=checkoutPrevious;

 alias gc=commit;
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