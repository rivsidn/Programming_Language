all: make_target

clean: clean_target

clean_target:
	rm client_udp server_udp

make_target:
	gcc -Wall -o client_udp client_udp.c 
	gcc -Wall -o server_udp server_udp.c 
