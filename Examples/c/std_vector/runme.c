#include "example_proxy.h"

int main() {
  Klass *klass = new_Klass();
  Vint *vint = Klass_vi_get(klass);
  VA *va = Klass_va_get(klass);

  printf("Vector of ints:\n");
  printf("size=%d\ncapacity=%d\n\n", Vint_size(vint), Vint_capacity(vint));
  
  int i;
  for (i = 0; i < 10; i++)
    Vint_push_back(vint, i*i);
  
  printf("size=%d\ncapacity=%d\n\n", Vint_size(vint), Vint_capacity(vint));
  
  for (i = 0; i < Vint_size(vint); i++)
    printf("%d%c", Vint_at(vint, i), i+1 == Vint_size(vint) ? '\n' : ',');
  
  Vint_clear(vint); 
  Vint_reserve(vint, 100);
  printf("\nsize=%d\ncapacity=%d\n", Vint_size(vint), Vint_capacity(vint));
  
  printf("\nVector of objects:\n");
  
  for (i = 0; i < 10; i++) {
    A *a = new_A_std_string_i("hello", i);
    VA_push_back(va, a);
  }
    
  for (i = 0; i < VA_size(va); i++) {
    A *a = VA_at(va, i);
    printf("%s %d\n", A_name_get(a), A_value_get(a));
  }
  
  SWIG_exit(0);
}