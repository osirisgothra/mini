// readline
// vim:smd:sm:ch=1:cwh=1:ts=4:sw=4:aw:awa

#include "readln.hpp"
#define UNUSED(_tgt) _tgt=_tgt;

int main(int argc,char* argv[], char* envp[])
{
	UNUSED(envp);
	UNUSED(argc);
	UNUSED(argv);
	if (argc) 
	{

		
	}
	else
	{

	}
	
	char* result = readline(NULL);
	if (result) 
	{
		fprintf(stderr,"%s",result);
		printf("%s",result);
		return 0;
	}
	return 1;
}


