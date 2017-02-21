# Elmer Package Server


### Build documentation

Install:
+ `brew install yarn`
+ `brew install libmagic`

Then, run:

```
$ ./scripts/installElmDoc.sh
$ ./scripts/makeElmDoc.sh <path to elmer>
```

### Build elmer-package

Install:
+ docker

Then, run:

```
$ ./scripts/makeLinux.sh
$ ./scripts/makeMacOS.sh
$ ./scripts/deployBin.sh
```
