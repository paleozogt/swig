#import "aggregate_proxy.h"

int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
int result =[aggregate move:UP];
if(result!=UP)
NSLog(@"UP Failed");

result =[aggregate move:DOWN];
if(result!=DOWN)
NSLog(@"DOWN Failed");

result =[aggregate move:LEFT];
if(result!=LEFT)
NSLog(@"LEFT Failed");

result =[aggregate move:RIGHT];
if(result!=RIGHT)
NSLog(@"RIGHT Failed");

if(result ==[aggregate move:0])
NSLog(@"0 test failed");

[pool drain];
return 0;
}
