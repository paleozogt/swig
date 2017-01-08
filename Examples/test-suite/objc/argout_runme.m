#import "argout_proxy.h"
#import <assert.h>

int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
int *int1=[argout copy_intp:42];
assert([argout incp:int1] == 42);
assert([argout intp_value:int1] ==43);

int *int2=[argout copy_intp:2];
assert([argout incp:int2] == 2);
assert([argout intp_value:int2] ==3);

int *int3=[argout copy_intp:7];
assert([argout incp:int3] == 7);
assert([argout intp_value:int3] ==8);

int *int4=[argout copy_intp:4];
assert([argout incp:int4] == 4);
assert([argout intp_value:int4] ==5);

[pool drain];
return 0;
}

