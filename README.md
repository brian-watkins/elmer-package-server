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

Make sure you're targeting the correct PCF instance, org, and space.

```
$ cd app
$ cf push
```

or try a blue-green deploy ...

```
$ cd app
$ cf zero-downtime-push elmer-package-server -f ./manifest.yml
```

### Release a new version

1. Bump the version in `elmer/elm-package.json`
2. Tag a release:
    ```
    git tag -a '2.0.0' -m 'Awesome release'
    git push --tags
    ```
2. Make the docs
3. Update `app/public/index.html` to add a link to the new documentation
4. Add a directory and `elm-package.json` to `app/public/versions`
5. Update `app/app.js` to include the new version
6. Deploy to PCF
