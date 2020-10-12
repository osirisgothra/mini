#include <string>

#define I_SHOULD_NEVER_COMPILE_WITHOUT_ERRORS	TRUE
#define THROW_THIS_IN_MY_FACE	3.14

void main(void)	// bad sig must be int
{
	int*** &badptr;
	int[*] badarray;
	int*	item=&unknownref;
	item="wrong type";
	char x = void badassignment;
	for ((undeclared_int=0;i<0;i++)) {
		what_the_hell++;
	}
	switch(x) {
		case what:	the_hell;
		default: badly formed switch;
	}

	return badreturn_voidvalue___AND___undeclared_variable;

}

// a program that causes errors on purpose