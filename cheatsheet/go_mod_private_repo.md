# go module private repo

> Ref: https://dev.to/johanlejdung/a-mini-guide-go-modules-and-private-repositories-4c7o

Go 1.13 introduced a new environmental variable `$GOPRIVATE`.

`GOPRIVATE=*.corp.example.com,rsc.io/private`

Set `$GOPRIVATE` with the following command:

```bash
# value supports wildcards
$ go env -w GOPRIVATE=github.com/repoURL/private-repo
```

If you are using `SSH` to access your Git Repository you should consider adding the following to your `~/.ssh/config` file to enable the Go command to access the git service:

```config
Host github.com
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/id_github
```

> Where ~/.ssh/id_github is the private key for your SSH authentication. The same setup should work with other repositories such as Gitlab and Bitbucket.

If you are using `SSH` to access a Git repo (may be also a local Git Repository) you should add the following to your `~/.gitconfig`

```gitconfig
[url "ssh://git@git.local.intranet/"]
       insteadOf = https://git.local.intranet/
```

Now you can go for your `$go mod` cmds.
