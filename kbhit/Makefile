# Makes the target

kbhit: kbhit.cpp
	g++ kbhit.cpp -o kbhit

clean: kbhit
	rm kbhit -f

install: kbhit
	cp kbhit /usr/local/bin/kbhit -f

uninstall: /usr/local/bin/kbhit
	rm -f /usr/local/bin/kbhit

