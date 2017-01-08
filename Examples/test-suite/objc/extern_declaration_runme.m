#import "extern_declaration_proxy.h"
int main(int argc,char *argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
if([extern_declaration externimport:100] !=100)
NSLog(@"extern import called");
if([extern_declaration externexport:200] !=200)
NSLog(@"externexport failed");
if([extern_declaration externstdcall:300] !=300)
NSLog(@"externstdcall failed");

[pool drain];
return 0;
}

