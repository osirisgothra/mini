//
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <memory.h>
#include <stdio.h>
#include <iostream>
#include "estat.h"

using namespace std;


int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        printf("\nusage: estat [filename]\n");
        return 1;
    }
    else
    {
        char* file=argv[1];
        struct stat buf;
        memset(&buf,sizeof(buf),0);

        if (!stat(file,&buf))
        {					  
            printf("device: %lu\n",buf.st_dev);
            printf("inode number: %lu\n",buf.st_ino);
            printf("protection: %u\n",buf.st_mode);
            printf("numlinks: %lu\n",buf.st_nlink);
            printf("user id: %u\n",buf.st_uid);
            printf("group id: %u\n",buf.st_gid);
            printf("device id: %lu\n",buf.st_dev);
            printf("size: %lu\n",buf.st_size);
            printf("blocksize i/o: %lu\n",buf.st_blksize);
            printf("512k block count: %lu\n",buf.st_blocks);
            printf("lastmod(secs): %lu\n",buf.st_atime);
            printf("lastacc(secs): %lu\n",buf.st_atime);
            printf("laststc(secs): %lu\n",buf.st_ctime);
        }
        else
        {
				    printf("stat on %s failed!\n",file);

        }
    }
}
