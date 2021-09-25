# Git tag

## part 1

> Forked from [mobilemind/git-tag-delete-local-and-remote.sh](https://gist.github.com/mobilemind/7883996)

```bash
# Add a tag with <tag_name>
$ git tag <tag_name> -a -m "whatever msg"

# Push tag to remote
$ git push origin <branch_name_on_which_tag_created> --tags

# delete local tag '12345'
git tag -d 12345
# delete remote tag '12345' (eg, GitHub version too)
git push origin :refs/tags/12345
# alternative approach
git push --delete origin tagName
git tag -d tagName
```

## part 2

```doc
# The command finds the most recent tag that is reachable from a commit.
# If the tag points to the commit, then only the tag is shown.
# Otherwise, it suffixes the tag name with the number of additional commits on top of the tagged object 
# and the abbreviated object name of the most recent commit.
git describe

# With --abbrev set to 0, the command can be used to find the closest tagname without any suffix:
git describe --abbrev=0

# other examples
git describe --abbrev=0 --tags # gets tag from current branch
git describe --tags `git rev-list --tags --max-count=1` # gets tags across all branches, not just the current branch
```

Ref: https://gist.github.com/rponte/fdc0724dd984088606b0
