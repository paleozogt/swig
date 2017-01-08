#import "using2_proxy.h"
#import<assert.h>
int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
assert([using2 spam:37]==37);
[pool drain];
return 0;
}
