## resources

- https://docs.appimage.org/packaging-guide/
- https://github.com/AppImage/AppImageKit
- https://github.com/AppImageCommunity/AppImageUpdate

- next-gen implementation of appimagespec?: https://github.com/probonopd/go-appimage

## demo app

```
usage: demo

  -U  self-update
  -v  print information
  -h  show this help
```

## updating

- `appimageupdate[tool]` supports consuming updates from static file server, github releases: https://github.com/AppImage/AppImageSpec/blob/master/draft.md#update-information

## signing

- is not part of the spec yet: https://github.com/AppImage/AppImageSpec/pull/30
- has issues with gpg keys containing subkeys: https://github.com/AppImage/AppImageKit/issues/1010

## metadata

- https://docs.appimage.org/packaging-guide/optional/appstream.html
- https://www.freedesktop.org/software/appstream/metainfocreator
- https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html

## in container

```
$ docker build -t appimage-demo -f Dockerfile .
$ docker run --rm -it \
  --mount=type=bind,src=$PWD,target=/src \
  --mount=type=volume,src=appimage-tmp,target=/tmp \
  --workdir=/src \
  appimage-demo \
  make bundle
```
