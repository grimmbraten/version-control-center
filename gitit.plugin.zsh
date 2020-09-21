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

 alias gb='spacer && branches && spacer';
 alias gbo='spacer && branchOrigins && spacer';
 alias gbr='spacer && branchRename && spacer';
 alias gbd='spacer && branchDelete && spacer';
 alias gbdo='spacer && branchDeleteOrigin && spacer';

 alias gch='spacer && checkout && spacer';
 alias gchb='spacer && checkoutCreateBranch && spacer';
 alias gchm='spacer && checkoutMaster && spacer';
 alias gchp='spacer && checkoutPrevious && spacer';

 alias gc='spacer && commit && spacer';
 alias gcu='spacer && commitUndo && spacer';
 alias gcp='spacer && commitPush && spacer';
 alias gcr='spacer && commitRename && spacer';
 alias gca='spacer && commitAll && spacer';
 alias gcap='spacer && commitAllPush && spacer';

 alias gf='spacer && fetch && spacer';

 alias gl=logs

 alias gm='spacer && merge && spacer';
 alias gmm='spacer && mergeMaster && spacer';

 alias gpl='spacer && pull && spacer';

 alias gp='spacer && push && spacer';
 alias gpu='spacer && pushUpstream && spacer';

 alias gr='spacer && reset && spacer';
 alias grt='spacer && resetTracked && spacer';
 alias gru='spacer && resetUntracked && spacer';

 alias ga='spacer && stage && spacer';
 alias gaa='spacer && stageAll && spacer';

 alias gst='spacer && stashes && spacer';
 alias gsts='spacer && save && spacer';
 alias gsta='spacer && apply && spacer';
 alias gstd='spacer && drop && spacer';
 
 alias gs='spacer && status && spacer';
 alias gsd='spacer && statusDetailed && spacer';
 alias gsa='spacer && originAheadCount && spacer';
 alias gsb='spacer && originBehindCount && spacer';
 alias gsam='spacer && masterAheadCount && spacer';
 alias gsbm='spacer && masterBehindCount && spacer';

 alias gu='spacer && unstage && spacer';
 alias gua='spacer && unstageAll && spacer';
fi