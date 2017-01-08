#import "clientdata_prop_a_proxy.h"
int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
A *a=[clientdata_prop_a new_tA];
[clientdata_prop_a test_tA:a];
[clientdata_prop_a test_A:a];

[pool drain];
return 0;
}
