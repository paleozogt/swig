// Users can provide their own SWIG_SHARED_PTR_TYPEMAPS macro before including this file to change the
// visibility of the constructor and getCPtr method if desired to public if using multiple modules.
#ifndef SWIG_SHARED_PTR_TYPEMAPS
#define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE...) SWIG_SHARED_PTR_TYPEMAPS_IMPLEMENTATION(protected, protected, CONST, TYPE)
#endif

%include <shared_ptr.i>

// Language specific macro implementing all the customisations for handling the smart pointer
%define SWIG_SHARED_PTR_TYPEMAPS_IMPLEMENTATION(PTRCTOR_VISIBILITY, CPTR_VISIBILITY, CONST, TYPE...)

// %naturalvar is as documented for member variables
%naturalvar TYPE;
%naturalvar SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >;

// destructor wrapper customisation
%feature("unref") TYPE 
//"if (debug_shared) { cout << \"deleting use_count: \" << (*smartarg1).use_count() << \" [\" << (boost::get_deleter<SWIG_null_deleter>(*smartarg1) ? std::string(\"CANNOT BE DETERMINED SAFELY\") : ( (*smartarg1).get() ? (*smartarg1)->getValue() : std::string(\"NULL PTR\") )) << \"]\" << endl << flush; }\n"
                               "(void)arg1; delete smartarg1;"

// Typemap customisations...

// plain value
%typemap(in) CONST TYPE ($&1_type argp = 0) %{
  argp = (*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input) ? (*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input)->get() : 0;
  if (!argp) {
    SWIG_ObjcThrowException(jenv, SWIG_ObjcNullPointerException, "Attempt to dereference nil $1_type");
    return $nil;
  }
  $1 = *argp; %}
%typemap(out) CONST TYPE 
%{ *(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$result = new SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >(new $1_ltype(($1_ltype &)$1)); %}

// plain pointer
%typemap(in) CONST TYPE * (SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *smartarg = 0) %{
  smartarg = *(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input;
  $1 = (TYPE *)(smartarg ? smartarg->get() : 0); %}
%typemap(out, fragment="SWIG_null_deleter") CONST TYPE * %{
  *(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$result = $1 ? new SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >($1 SWIG_NO_NULL_DELETER_$owner) : 0;
%}

// plain reference
%typemap(in) CONST TYPE & %{
  $1 = ($1_ltype)((*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input) ? (*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input)->get() : 0);
  if (!$1) {
    SWIG_ObjcThrowException(jenv, SWIG_ObjcNullPointerException, "$1_type reference is nil");
    return $nil;
  } %}
%typemap(out, fragment="SWIG_null_deleter") CONST TYPE &
%{ *(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$result = new SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >($1 SWIG_NO_NULL_DELETER_$owner); %}

// plain pointer by reference
%typemap(in) TYPE *CONST& ($*1_ltype temp = 0)
%{ temp = (TYPE *)((*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input) ? (*(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$input)->get() : 0);
   $1 = &temp; %}
%typemap(out, fragment="SWIG_null_deleter") TYPE *CONST&
%{ *(SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > **)&$result = new SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >(*$1 SWIG_NO_NULL_DELETER_$owner); %}

// shared_ptr by value
%typemap(in) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > ($&1_type argp)
%{ argp = *($&1_ltype*)&$input; 
   if (argp) $1 = *argp; %}
%typemap(out) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >
%{ *($&1_ltype*)&$result = $1 ? new $1_ltype($1) : 0; %}

// shared_ptr by reference
%typemap(in) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > & ($*1_ltype tempnull)
%{ $1 = $input ? *($&1_ltype)&$input : &tempnull; %}
%typemap(out) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > &
%{ *($&1_ltype)&$result = *$1 ? new $*1_ltype(*$1) : 0; %} 

// shared_ptr by pointer
%typemap(in) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > * ($*1_ltype tempnull)
%{ $1 = $input ? *($&1_ltype)&$input : &tempnull; %}
%typemap(out) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *
%{ *($&1_ltype)&$result = ($1 && *$1) ? new $*1_ltype(*$1) : 0;
   if ($owner) delete $1; %}

// shared_ptr by pointer reference
%typemap(in) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *& (SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > tempnull, $*1_ltype temp = 0)
%{ temp = $input ? *($1_ltype)&$input : &tempnull;
   $1 = &temp; %}
%typemap(out) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *&
%{ *($1_ltype)&$result = (*$1 && **$1) ? new SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >(**$1) : 0; %} 

// various missing typemaps - If ever used (unlikely) ensure compilation error rather than runtime bug
%typemap(in) CONST TYPE[], CONST TYPE[ANY], CONST TYPE (CLASS::*) %{
#error "typemaps for $1_type not available"
%}
%typemap(out) CONST TYPE[], CONST TYPE[ANY], CONST TYPE (CLASS::*) %{
#error "typemaps for $1_type not available"
%}


%typemap (imtype)   SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >, 
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > &,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *& "void*"
%typemap (objctype) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >, 
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > &,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *& "$typemap(objctype, TYPE)"

%typemap(objcin)    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >, 
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > &,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *,
                    SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *& "[$objcinput getCPtr]"


%typemap(objcout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }
%typemap(objcout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > & {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }
%typemap(objcout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > * {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }
%typemap(objcout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE > *& {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }


%typemap(objcout) CONST TYPE {
    return new $typemap(objctype, TYPE)($imcall, true);
  }
%typemap(objcout) CONST TYPE & {
    return new $typemap(objctype, TYPE)($imcall, true);
  }
%typemap(objcout) CONST TYPE * {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }
%typemap(objcout) TYPE *CONST& {
    void* cPtr = $imcall;
    return (cPtr == 0) ? nil : [[[$typemap(objcclasstype, TYPE) alloc] initWithCptr:cPtr swigOwnCObject:YES] autorelease];
  }

// Base proxy classes
%typemap(objcimplementationcode) TYPE %{
-(void*)getCptr {
	return swigCPtr;
}

-(id)initWithCptr: (void*)cptr swigOwnCObject: (BOOL)ownCObject {
	if((self = [super init])) {
		swigCPtr = cptr;
        swigCMemOwn = ownCObject;
	}
	return self;
}
%}

// Derived proxy classes
%typemap(objcimplementationcode_derived) TYPE %{
%}

%typemap(objcdestruct, methodname="dealloc", methodmodifiers="public") TYPE %{
  if (swigCPtr != NULL) {
    if (swigCMemOwn) {
        $imcall;
        swigCMemOwn = NO;
    }
    swigCPtr = NULL;
  }
  [super dealloc];
%}

%template() SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< CONST TYPE >;
%enddef

