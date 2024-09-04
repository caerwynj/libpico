<mkconfig

DIRS=\
	libpico\
	tinyusb\
	#cmd/blink\
	cmd/hello_world\
	
all:V:	all-$SHELLTYPE
install:V: install-$SHELLTYPE
uninstall:V: uninstall-$SHELLTYPE
nuke:V: nuke-$SHELLTYPE
clean:V: clean-$SHELLTYPE
	
%-sh:QV:
	for j in $DIRS
	do
		if test -d $j; then
			echo "(cd $j; mk $MKFLAGS $stem)"
			(cd $j; mk $MKFLAGS $stem) || exit 1
		fi || test ! -e $j
	done
