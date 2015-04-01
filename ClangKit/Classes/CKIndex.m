 
/* $Id$ */

#import "CKIndex.h"

@implementation CKIndex

@synthesize cxIndex = _cxIndex;

+ ( instancetype )index
{
    return [[self.alloc 
         init ] autorelease ];
}

- ( instancetype )init
{
    if( ( self = [ super init ] ) )
    {
        _cxIndex = clang_createIndex( 0, 0 );
    }
    
    return self;
}

- ( void )dealloc
{
    clang_disposeIndex( _cxIndex );
    
    [ super dealloc ];
}

- ( BOOL )excludeDeclarationsFromPCH
{
    @synchronized( self )
    {
        return _excludeDeclarationsFromPCH;
    }
}

- ( BOOL )displayDiagnostics
{
    @synchronized( self )
    {
        return _displayDiagnostics;
    }
}

- ( void )setExcludeDeclarationsFromPCH: ( BOOL )value
{
    @synchronized( self )
    {
        if( value != _excludeDeclarationsFromPCH )
        {
            clang_disposeIndex( _cxIndex );
            
            _cxIndex = clang_createIndex( ( int )_excludeDeclarationsFromPCH, ( int )_displayDiagnostics );
        }
    }
}

- ( void )setDisplayDiagnostics: ( BOOL )value
{
    @synchronized( self )
    {
        if( value != _displayDiagnostics )
        {
            clang_disposeIndex( _cxIndex );
            
            _cxIndex = clang_createIndex( ( int )_excludeDeclarationsFromPCH, ( int )_displayDiagnostics );
        }
    }
}

@end
