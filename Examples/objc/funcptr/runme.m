
#import "example_proxy.h"

int main(int argc, char* argv[]) {
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
    int a = 37;
    int b = 42;

    // Now call our C function with a bunch of callbacks
    NSLog(@"Trying some C callback functions");
    NSLog(@"a        = %i", a);
    NSLog(@"b        = %i", b);
    NSLog(@"ADD(a,b) = %i", [example do_op:a b:b op:ADD]);
    NSLog(@"SUB(a,b) = %i", [example do_op:a b:b op:SUB]);
    NSLog(@"MUL(a,b) = %i", [example do_op:a b:b op:MUL]);

    NSLog(@"Here is what the C callback function objects look like in ObjectiveC" );
    NSLog(@"ADD      = %@", ADD);
    NSLog(@"SUB      = %@", SUB);
    NSLog(@"MUL      = %@", MUL);
    [pool drain];

    return 0;
}
