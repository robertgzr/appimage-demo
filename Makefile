APPNAME := demo
ARCH := x86_64
APPIMAGE := Demo-${ARCH}.AppImage
APPDIR := ${PWD}/${APPNAME}.AppDir
DIST := ${PWD}/dist

bundle: ${APPDIR}/AppRun ${APPDIR}/usr/bin/appimageupdatetool ${DIST}/${APPIMAGE}

serve-updates: ${DIST}/${APPIMAGE}
	python3 -m http.server --directory ${DIST} 8080

# target system independent launcher for the payload application
${APPDIR}/AppRun:
	curl -L https://github.com/AppImage/AppImageKit/releases/latest/download/AppRun-${ARCH} -o $@
	chmod +x $@

# self-update tool
${APPDIR}/usr/bin/appimageupdatetool:
	curl -L https://github.com/AppImageCommunity/AppImageUpdate/releases/latest/download/appimageupdatetool-${ARCH}.AppImage -o $@
	chmod +x $@

${DIST}:
	mkdir -p $@
${DIST}/${APPIMAGE}: ${DIST} ${PWD}/appimagetool ${APPDIR}/${APPNAME}.desktop ${APPDIR}/**/*
	cd ${DIST} && ARCH=${ARCH} ${PWD}/appimagetool \
		--updateinformation "zsync|http://127.0.0.1:8080/${APPIMAGE}.zsync" \
		${APPDIR}

${PWD}/appimagetool:
	curl -L https://github.com/AppImage/AppImageKit/releases/latest/download/appimagetool-$(shell uname -m).AppImage -o $@
	chmod +x $@

clean:
	rm -r ${DIST}
