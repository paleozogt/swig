#import "typedef_reference_proxy.h"
#import<assert.h>

int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
int *int2=[typedef_reference copy_intp:2];
assert([typedef_reference somefunc:int2] ==2);
int *int3=[typedef_reference copy_intp:3];
assert([typedef_reference somefunc:int3] ==3);
[pool drain];
return 0;
}

