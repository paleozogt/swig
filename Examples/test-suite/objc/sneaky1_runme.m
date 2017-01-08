#import "sneaky1_proxy.h"

int main(int argc,char *argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
if([sneaky1 add:30 arg1:2] !=32)
NSLog(@"add test failed");
if([sneaky1 subtract:20 arg1:2] !=18)
NSLog(@"subtract test failed");
if([sneaky1 mul:20 arg1:2] !=40)
NSLog(@"mul test failed");
if([sneaky1 divide:20 arg1:2] !=10)
NSLog(@"div test failed");

[pool drain];
return 0;
} 
