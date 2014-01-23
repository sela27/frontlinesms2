#/bin/bash

OPTIND=1
generateZip=false

while getopts "z:" opt; do
	case $opt in
		z) generateZip=true
			;;
	esac
done

tempDir="`mktemp -d`"
cp -r grails-app/conf/help/* $tempDir
cp -r web-app/* $tempDir
for f in $(find $tempDir -name \*.txt); do
	filename=$(basename "$f")
	filenameWithoutExtension="${filename%.*}"
	pandoc --from=markdown --to=html $f -o $f.html
	rm $f
done

for f in $(ls web-app | grep images --invert-match); do
	rm -rf "$tempDir/$f"
done

for f in $(ls web-app/images | grep help --invert-match); do
	rm -rf "$tempDir/images/$f"
done

if $generateZip; then
	echo "Generating ZIP archive"
	zip target/help.zip -r $tempDir
	echo "Done generating ZIP archive"
fi

google-chrome "$tempDir"

exit 0

