# ideal-potato

## Scripts

There are some scripts helpful to use in regarding aspects.

- ***cp+:*** Build and run `c++` source file, flags for `c++11` and `c++14` can be used, some simple checking for flags and arg, show help.

  ```bash
  $ wget https://gist.githubusercontent.com/shudipta/adbe1d5ef3d9a792ac5b88757659665d/raw/81161e2257312376d84973bfebbcee74c48d4776/cp+.sh \
    && chmod +x cp+.sh \
    && sudo mv cp+.sh /usr/local/bin/cp+

  $ cp+ --help
  c++14 - builds and runs a c++ source file specified by the only argument

  Usage: c++14 <file_path>

  arg:
  <file_path>         specifies a c++ source file path that must have '.cpp' as extension

  options:
  -h, --help          show brief help
      --14            use -std=c++14 as compiler, default
      --11            use -std=c++11 as compiler
  ```

- ***rlog:*** Generate a release log file from based on the commits on top of the last tag.

  ```bash
  $ wget https://gist.githubusercontent.com/shudipta/7e7b8d0419ff0597fe074c6c4dea6ed7/raw/f4b6b5dadda13d0f14856c88a48f5ad905720f8e/rlog.sh \
    && chmod +x rlog.sh \
    && sudo mv rlog.sh /usr/local/bin/rlog

  $ rlog --help
  rlog.sh - generate a release log file from based on the commits on top of the last tag

  rlog.sh [options]

  options:
  -h, --help          show brief help
  -v                  show the contents of the log file
  ```

- ***mkc:*** Update your `minikube` and `kubectl` version.

  ```bash
  $ wget https://gist.githubusercontent.com/shudipta/207dec0fa9d6b64ab7a7341dd830a9d4/raw/9a57c413431fa805c8462452bbdf7ec68b5d45e7/mkc.sh \
    && chmod +x ./mkc.sh \
    && sudo cp ./mkc.sh /usr/local/bin/mkc \
    && rm ./mkc.sh

  $ mkc --help
  mk-kc.sh - update minikube and kubectl

  mk-kc.sh [options]

  options:
  -h, --help          show brief help
      --minikube      minikube version that will be used for minikube (default is v1.0.0)
      --kubectl       kubectl version that will be used for kubectl (default is from https://storage.googleapis.com/kubernetes-release/release/stable.txt)
  ```
