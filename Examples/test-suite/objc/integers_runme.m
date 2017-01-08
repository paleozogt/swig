#import "integers_proxy.h"
#import <assert.h>

int main(int argc,char* argv[])
{
NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];

assert([integers signed_char_identity:-3]   == -3);
assert([integers unsigned_char_identity:5]  == 5);
assert([integers signed_short_identity:-3]  == -3);
assert([integers unsigned_short_identity:5] == 5);
assert([integers signed_int_identity:-3]  == -3);
assert([integers unsigned_int_identity:5] == 5);
assert([integers signed_long_identity:-3]  == -3);
assert([integers unsigned_long_identity:5] == 5);
assert([integers signed_long_long_identity:-3]  == -3);
assert([integers unsigned_long_long_identity:5] == 5);

[pool drain];
return 0;
}
