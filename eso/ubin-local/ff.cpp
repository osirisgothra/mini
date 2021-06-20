
#include <stdio.h>
#include <sys/statfs.h>
#include <memory.h>

using namespace std;

char* progname = NULL;

int main(int argc, char** argv, char** envp)
{
    progname = argv[0];
    argv++; argc--;
    int retval = 0;
    struct statfs fsi;
    memset(&fsi,0,sizeof(fsi));
    int sr = statfs(argv[0], &fsi);


    printf("results:\n f_type=%ld\n f_bsize=%ld\n f_blocks=%ld\n f_bfree=%ld\n f_bavail=%ld\n f_files=%ld\n f_ffree=%ld\n f_namelen=%ld\n f_frsize=%ld\n f_flags=%ld\n", fsi.f_type, fsi.f_bsize, fsi.f_blocks, fsi.f_bfree, fsi.f_bavail, fsi.f_files, fsi.f_ffree, fsi.f_namelen, fsi.f_frsize, fsi.f_flags);



    return retval;
}


