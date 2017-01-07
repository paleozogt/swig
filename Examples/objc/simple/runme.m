
#import "example_proxy.h"

int main(int argc, char* argv[]) {
   // Call the gcd() function
    int x = 42;
    int y = 105;
    int g = [example gcd:x y:y];
    NSLog(@"The gcd of %d and %d is %d\n", x, y, g);
    
    // Manipulate the Foo global variable
    // Output its current value
    NSLog(@"Foo = %f \n", [example getFoo]);
    
    // Change its value
    [example setFoo:3.1415926];
    
    // See if the change took effect
    NSLog(@"Changed Foo = %f \n", [example getFoo]);

   return 0;
}
