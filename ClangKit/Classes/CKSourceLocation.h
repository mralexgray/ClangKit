 
/* $Id$ */

/*!
	@header          CKSourceLocation.h
	@copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author          Jean-David Gadina - www.xs-labs.com
	@abstract        ClangKit source location class
 */

/*!
	@class           CKSourceLocation
	@abstract        Source location class
 */
@interface CKSourceLocation: NSObject
{
@protected
    
    void       * _ptrData1;
    void       * _ptrData2;
    unsigned int _intData;
    NSString   * _fileName;
}

/*!
	@property        ptrData1
	@abstract        Internal pointer data 1
 */
@property (readonly) void * ptrData1;

/*!
	@property        ptrData2
	@abstract        Internal pointer data 1
 */
@property (readonly) void * ptrData2;

/*!
	@property        intData
	@abstract        Internal integer data
 */
@property (readonly) unsigned int intData;

/*!
	@property        fileName
	@abstract        The source location's filename
 */
@property (readonly) NSString * fileName;

/*!
	@method          sourceLocationWithPointerData1:pointerData2:intData:
	@abstract        Gets a source location object
	@param           ptrData1    Pointer data 1
	@param           ptrData2    Pointer data 2
	@param           intData     Integer data
	@return          The source location object
	@discussion      The returned object is autoreleased.
 */
+ (instancetype)sourceLocationWithPointerData1: (void *)ptrData1 pointerData2: (void *)ptrData2 intData: (unsigned int)intData;

/*!
	@method          initWithPointerData1:pointerData2:intData:
	@abstract        Initializes a source location object
	@param           ptrData1    Pointer data 1
	@param           ptrData2    Pointer data 2
	@param           intData     Integer data
	@return          The source location object
 */
- (instancetype)initWithPointerData1: (void *)ptrData1 pointerData2: (void *)ptrData2 intData: (unsigned int)intData;

@end
