
#import "example_proxy.h"

int main(int argc, char* argv[]) {
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];

	//Try to set the values of global variables
	[example setIvar:42];
	[example setSvar:-31000];
	[example setLvar:65537];
	[example setUivar:123456];
	[example setUsvar:61000];
	[example setUlvar:654321];
	[example setScvar:-13];
	[example setUcvar:251];
	[example setDvar:0];
	[example setCvar:'S'];
	[example setFvar:3.14159];
	[example setStrvar:@"Hello World"];
	[example setIptrvar:[example new_int:37]];
	[example setPtptr:[example new_TPoint:37 y:42]];
	[example setName:@"Bill"];
	
	//Now print out the values of variables
	
	NSLog(@"Variables (values printed from Objective C)\n");
	
	NSLog(@"ivar      = %i\n",[example getIvar]);
	NSLog(@"svar      = %i\n", [example getSvar]);
	NSLog(@"lvar      = %li\n", [example getLvar]);
	NSLog(@"uivar     = %u\n", [example getUivar]);
	NSLog(@"usvar     = %u\n", [example getUsvar]);
	NSLog(@"ulvar     = %lu\n", [example getUlvar]);
	NSLog(@"scvar     = %i\n", [example getScvar]);
	NSLog(@"ucvar     = %u\n", [example getUcvar]);
	NSLog(@"fvar      = %g\n", [example getFvar]);
	NSLog(@"dvar      = %g\n", [example getDvar]);
	NSLog(@"cvar      = %c\n", [example getCvar]);
	NSLog(@"strvar    = %@\n", [example getStrvar]);
	NSLog(@"iptrvar    =%p\n", [example getIptrvar]);
	NSLog(@"name      = %@\n", [example getName]);
	NSLog(@"ptptr     = %p %@\n", [example getPtptr], [example TPoint_print:[example getPtptr]]);	
	NSLog(@"pt        ="); [example pt_print];
	NSLog(@"status    = %d\n", [example getStatus]);
	
	
	NSLog(@"\nVariables (values printed from C)\n");
	[example print_vars];
	
    // This line would not compile: since status is marked with
	// %immutable, there is no [example setStatus] function.
	// NSLog(@"\nNow I'm going to try and modify some read only variables")
	// [example setStatus:0]
		
	NSLog(@"\nI'm going to try and update a structure variable.\n");
	
	[example setPt:(SWIGTYPE_TPoint*)[example getPtptr]];
	
	NSLog(@"The new value is \n");
	
	[example pt_print];
	NSLog(@"You should see the value %@",[example TPoint_print:[example getPtptr]]); 
        
    [pool drain];
	return 0;
}
