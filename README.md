# Elmer Package Server


### Build documentation

Install:
+ Python > 3.6.0
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

### Deploy

```
$ cd app
$ cf push
```

or try a blue-green deploy ...

```
$ cd app
$ cf zero-downtime-deploy elmer-package-server -f ./manifest.yml
```
