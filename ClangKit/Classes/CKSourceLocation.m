 
/* $Id$ */

#import "CKSourceLocation.h"

@implementation CKSourceLocation

@synthesize ptrData1 = _ptrData1, ptrData2 = _ptrData2, intData  = _intData, fileName = _fileName;

+ ( instancetype )sourceLocationWithPointerData1: ( void * )ptrData1 pointerData2: ( void * )ptrData2 intData: ( unsigned int )intData
{
    return [self.alloc 
         initWithPointerData1: ptrData1 pointerData2: ptrData2 intData: intData ];
}

- ( instancetype )initWithPointerData1: ( void * )ptrData1 pointerData2: ( void * )ptrData2 intData: ( unsigned int )intData
{
    CXSourceLocation location;
    CXFile           file;
    CXString         fileName;
    unsigned int     line;
    unsigned int     column;
    unsigned int     offset;
    
    if( ( self = [ self init ] ) )
    {
        _ptrData1 = ptrData1;
        _ptrData2 = ptrData2;
        _intData  = intData;
        
        location.ptr_data[ 0 ] = ptrData1;
        location.ptr_data[ 1 ] = ptrData2;
        location.int_data      = intData;
        
        clang_getExpansionLocation( location, &file, &line, &column, &offset );
        
        fileName = clang_getFileName( file );
        
        if( clang_getCString( fileName ) != NULL )
        {
            _fileName =[NSString.alloc 
         initWithCString: clang_getCString( fileName ) encoding: NSUTF8StringEncoding ];
        }
    }
    
    return self;
}


@end
