
                                                        

estat: estat.cpp
	g++ estat.cpp -o estat

#estat.o: estat.cpp
#g++ estat.cpp -o estat.o

clean: estat.o estat
	rm estat.o estat

install: estat
	sudo -H install estat /usr/bin

uninstall: /usr/bin/estat
	sudo rm -fv /usr/bin/estat
	
