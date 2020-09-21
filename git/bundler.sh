local git=$(dirname "$0");

# dependencies (none)
. $git/status.sh
. $git/reset.sh
. $git/fetch.sh
. $git/stash.sh
. $git/push.sh
. $git/logs.sh

# dependencies (status)
. $git/stage.sh
. $git/unstage.sh

# dependencies (fetch)
. $git/merge.sh
. $git/pull.sh

# dependencies (stash)
. $git/checkout.sh

# dependencies (push)
. $git/branch.sh

# dependencies (stage, unstage, push)
. $git/commit.sh