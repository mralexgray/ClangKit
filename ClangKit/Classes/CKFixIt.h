 
/* $Id$ */

/*!
	@header          CKFixit.h
	@copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author          Jean-David Gadina - www.xs-labs.com
	@abstract        ClangKit fix-it class
 */

@class CKDiagnostic;

/*!
	@class           CKFixIt
	@abstract        Fix-it class
 */
@interface CKFixIt: NSObject
/*!
	@property        string
	@abstract        The fix-it's string
 */
@property (readonly) NSString * string;

/*!
	@property        range
	@abstract        The fix-it's range
 */
@property (readonly) NSRange range;

/*!
	@method          fixItsForDiagnostic:
	@abstract        Gets fix-it objects from a diagnostic object
	@param           diagnostic  The diagnostic object
	@return          An array of fix-it objects
 */
+ (NSArray *)fixItsForDiagnostic: (CKDiagnostic *)diagnostic;

/*!
	@method          fixItWithDiagnostic:index:
	@abstract        Gets a fix-it object from a diagnostic object
	@param           diagnostic  The diagnostic object
	@param           index       The index
	@return          The fix-it object
	@discussion      The returned object is autoreleased.
 */
+ (instancetype)fixItWithDiagnostic: (CKDiagnostic *)diagnostic index: (NSUInteger)index;

/*!
	@method          initWithDiagnostic:index:
	@abstract        Initializes a fix-it object with a diagnostic object
	@param           diagnostic  The diagnostic object
	@param           index       The index
	@return          The fix-it object
 */
- (instancetype)initWithDiagnostic: (CKDiagnostic *)diagnostic index: (NSUInteger)index;
    
@end
