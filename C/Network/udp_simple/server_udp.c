#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <limits.h>
#include <linux/netfilter_ipv4.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <time.h>
#include <sys/time.h>

#define MAX_BUF (1024)

int main (int argc, char **argv)
{
	int                     s;
	short int               port;
	struct sockaddr_in      servaddr;
	int                     ret;
	char                    *endptr;
	int 			num, old_num = -1;

	if (argc < 2)
	{
		printf ("usage: %s <port>\n", argv[0]);
		return -1;
	}

	port = strtol (argv[1], &endptr, 0);
	if (*endptr || port <= 0)
	{
		fprintf (stderr, "invalid port number %s.\n", argv[1]);
		return -2;
	}

	if ((s = socket (AF_INET, SOCK_DGRAM, 0)) < 0)
	{
		fprintf (stderr, "error creating listening socket.\n");
		return -3;
	}

	memset (&servaddr, 0, sizeof (servaddr));
	servaddr.sin_family = AF_INET;
	servaddr.sin_addr.s_addr = htonl (INADDR_ANY);
	servaddr.sin_port = htons (port);

	if (bind (s, (struct sockaddr *) &servaddr, sizeof (servaddr)) < 0)
	{
		fprintf (stderr, "error calling bind()\n");
		return -6;
	}
	char* buf_recv=(char*)malloc(MAX_BUF);
	struct sockaddr_in peeraddr;
	socklen_t peerlen;
	peerlen = sizeof(peeraddr);

	memset(buf_recv, 0x0, MAX_BUF);

	fd_set rset;
	struct timeval tv;
	memset(&tv, 0, sizeof(struct timeval));
	while(1)
	{
		FD_ZERO(&rset);
		FD_SET(s,&rset);
		tv.tv_sec = 20; 
		tv.tv_usec = 0; 

		ret = select(s+1, &rset, NULL, NULL, &tv);
		if(ret < -1)
		{    
			fprintf (stderr, "error select. err (#%d %s)\n", errno, strerror(errno));
		}    
		else if(0 == ret)
		{
			printf ("timeout...\n");
			break;
		}
		else 
		{
			if(FD_ISSET(s, &rset))
			{
				ret = recvfrom(s, buf_recv, MAX_BUF, 0, (struct sockaddr *)&peeraddr, &peerlen);
				if(ret <= 0)
				{
					fprintf (stderr, "error recv. err (#%d %s)\n", errno, strerror(errno));
				}
				else
				{
					num = atoi(buf_recv);
					if (old_num+1 != num) {
						printf("not sorted, %d %d\n", old_num, num);
					}
					old_num = num;
				}
			}
		}
	}

	close (s);

	return 0;
}
