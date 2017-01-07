
#import "example_proxy.h"

int main(int argc, char* argv[]) {
	
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];

    // First create some objects using the pointer library.
    NSLog(@"Testing the pointer library");
    int* a = [example new_intp];
    int* b = [example new_intp];
    int* c = [example new_intp];
    [example intp_assign:a value:37];
    [example intp_assign:b value:42];
    
    // Note that getCPtr() has package access by default
    NSLog(@"     a =%p",a );
    NSLog(@"     b =%p",b);
    NSLog(@"     c =%p",c);
    
    // Call the add() function with some pointers
    [example add:a y:b result:c];
    
    // Now get the result
    int res = [example intp_value:c];
    NSLog(@"     37 + 42 = %d", res);
    
    // Clean up the pointers
    [example delete_intp:a];
    [example delete_intp:b];
    [example delete_intp:c];
    
    // Now try the typemap library
    // Now it is no longer necessary to manufacture pointers.
   // Instead we use a single element array which in Java is modifiable.
    
    NSLog(@"Trying the typemap library");
    int r[] = {0};
    [example sub:37 arg1:42 OUTPUT:r];
    NSLog(@"     37 - 42 = %d", r[0]);
    
    // Now try the version with return value
    
    NSLog(@"Testing return value");
    int q = [example divide:42 d:37 r:r];
    NSLog(@"     42/37 =%d and remainder=%d", q, r[0]);
    [pool drain];
     return 0;
}
