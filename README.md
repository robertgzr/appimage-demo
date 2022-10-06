## resources

- https://docs.appimage.org/packaging-guide/
- https://github.com/AppImage/AppImageKit
- https://github.com/AppImageCommunity/AppImageUpdate

- next-gen implementation of appimagespec?: https://github.com/probonopd/go-appimage

## internals

manual creation of appimage needs spec-complicant (contains `AppRun` exectuable)
squashfs filesystem appeneded to their [runtime](https://github.com/AppImage/AppImageKit/blob/master/src/runtime.c):

```
mksquashfs Your.AppDir Your.squashfs -root-owned -noappend
cat runtime >> Your.AppImage
cat Your.squashfs >> Your.AppImage
```

The runtime elf binary contains empty sections, that are used to embed metadata:
- update information
- md5 digest
- sha256 signature
- signing key

## updating

- `appimageupdate[tool]` supports consuming updates from static file server, github releases: https://github.com/AppImage/AppImageSpec/blob/master/draft.md#update-information

## signing

- https://docs.appimage.org/packaging-guide/optional/signatures.html
- using local gpg key: `appimagetool --sign --sign-key <KEY_ID> <SOURCE>`
- embeds the signature into ELF section `.sig_key`
- is not part of the spec
  - https://github.com/AppImage/AppImageSpec/issues/29
  - https://github.com/AppImage/AppImageSpec/pull/30
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

## demo app

```
usage: demo

  -U  self-update
  -v  print information
  -h  show this help
```
