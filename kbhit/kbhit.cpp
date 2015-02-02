			char ch = getchar();#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <termios.h>
#include <stropts.h>
#include <sys/ioctl.h>

int _kbhit() {
    static const int STDIN = 0;
    static bool initialized = false;

    if (! initialized) {
        // Use termios to turn off line buffering
        termios term;
        tcgetattr(STDIN, &term);
        term.c_lflag &= ~ICANON;
        tcsetattr(STDIN, TCSANOW, &term);
        setbuf(stdin, NULL);
        initialized = true;
    }
    int bytesWaiting;
    ioctl(STDIN, FIONREAD, &bytesWaiting);
    return bytesWaiting;
}

int main(int argc, char* argv[], char**)
{
	argc--; argv++; // skip the command argument

	if (!argc)
	{
		if (_kbhit())
			return _getch();
		
	}
	else
	{
		char rv = 0;
		char ch, first, last, total;
		while (_kbhit())
		{
			ch = getchar();
			if (!first)
				first = ch;			
			printf("%c",ch);
		}
		return rv;
	}
	return 0;	
}
