#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>


#define MAX_BUF 4096

void buff_restore(char *buff, int len)
{
	int i;
	memset(buff, 0, len);
	for (i = 0; i < len; i++) {
		buff[i] = '0' + i%10;
	}
	buff[len-1] = '\n';
}

int main(int argc, char *argv[])
{
	int ret, len;
	int sock, port;
	char buff[MAX_BUF];
	struct sockaddr_in server, client;
	int client_len;

	if (argc != 2) {
		ret = 1; goto err;
	}

	port = atoi(argv[1]);
	if (port > 65535 || port < 0) {
		ret = 2; goto err;
	}

	sock = socket(AF_INET, SOCK_DGRAM, 0);
	if (sock < 0) {
		ret = 3; goto err;
	}

	//绑定
	memset(&server, 0, sizeof(server));
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = htonl(INADDR_ANY);
	server.sin_port = htons(port);
	ret = bind(sock, (struct sockaddr *)&server, sizeof(server));
	if (ret < 0) {
		ret = 4; goto err;
	}
	//循环接收
	while (1) {
		ret = recvfrom(sock, buff, MAX_BUF, 0, (struct sockaddr *)&client, &client_len);
		if (ret > 0) {
			len = atoi(buff);
			if (len > 4096 || len < 1450) {
				len = 1600;
			}
			buff_restore(buff, len);
			sendto(sock, buff, len, 0, (struct sockaddr *)&client, client_len);
		}
	}

	close(sock);

	return 0;
err:
	fprintf(stderr, "%d %s\n", ret, strerror(errno));
	return -1;
}
