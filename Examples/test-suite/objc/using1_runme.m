#import "using1_proxy.h"
#import <assert.h>

int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
_FooImpl *fmpl=[[_FooImpl alloc]init];
assert([fmpl isMemberOfClass: [_FooImpl class]] == YES); 
assert([using1 spam:3]==3);
[pool drain];
return 0;
}
