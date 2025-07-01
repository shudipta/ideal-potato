# Cherry-pick Advanced

To cherry-pick from different remote repository, one can follow below steps,

```bash
# check current remote info
git remote -v

# add new origin
git remote add neworigin <clone_url_of_any_other_repo>

# check remote info again
git remote -v

# fetch neworigin
git fetch neworigin

# log of target branch from neworigin
git log neworigin/<branch_name>

# just cherry-pick
git cherry-pick <commit_from_target_branch>
```
