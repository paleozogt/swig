#include "abstract_typedef2/abstract_change_proxy.h"
#include <assert.h>

int main(int argc, const char *argv[]) {
	Foo *f = new_Foo();
	Foo *f2 = Foo_blah(f);

	assert(f2 != 0);

	delete_Foo(f);
	delete_Foo(f2);

	return 0;
}