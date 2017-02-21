# Elmer Package server

### Test

To run the tests:

```
$ node test
```


### Deploy

Make sure that the `public` directory contains the appropriate resources:

```
public
  - downloads
    - elmer-package-darwin.zip
    - elmer-package-linux.zip  
    - etc ...
  - versions
    - 1.0.0
      - elm-package.json
    - etc ...
```

Then:

```
$ cf push
```
