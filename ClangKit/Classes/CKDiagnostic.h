 
/* $Id$ */
#import <Foundation/Foundation.h>

/*!
	@header          CKDiagnostic.h
	@copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author          Jean-David Gadina - www.xs-labs.com
	@abstract        ClangKit diagnostic class
 */

@class CKTranslationUnit;

/*!
	@typedef         CKDiagnosticSeverity
	@abstract        Diagnostic severity
 */
typedef NSInteger CKDiagnosticSeverity;

/*!
	@var             CKDiagnosticSeverityIgnored
	@abstract        Diagnostic severity - Ignored
 */
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityIgnored;

/*!
	@var             CKDiagnosticSeverityNote
	@abstract        Diagnostic severity - Notice
 */
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityNote;

/*!
	@var             CKDiagnosticSeverityWarning
	@abstract        Diagnostic severity - Warning
 */
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityWarning;

/*!
	@var             CKDiagnosticSeverityError
	@abstract        Diagnostic severity - Error
 */
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityError;

/*!
	@var             CKDiagnosticSeverityFatal
	@abstract        Diagnostic severity - Fatal error
 */
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityFatal;

/*!
	@class           CKDiagnostic
	@abstract        Diagnostic class
 */
@interface CKDiagnostic: NSObject

/*!
	@property        cxDiagnostic
	@abstract        Internal libclang diagnostic object
 */
@property (readonly) CXDiagnostic cxDiagnostic;

/*!
	@property        spelling
	@abstract        Diagnostic's spelling
 */
@property (readonly) NSString * spelling;
@property (nonatomic) NSString *file;

/*!
	@property        severity
	@abstract        Diagnostic's severity
 */
@property (readonly) CKDiagnosticSeverity severity;

/*!
	@property        fixIts
	@abstract        An array containing instances of 'CKFixIt'
 */
@property (readonly) NSArray * fixIts;

/*!
	@property        line
	@abstract        Line number for the diagnostic
 */
@property (readonly) NSUInteger line;

/*!
	@property        column
	@abstract        Column number for the diagnostic
 */
@property (readonly) NSUInteger column;

/*!
	@property        range
	@abstract        Range of the diagnostic, based on the source code
 */
@property (readonly) NSRange range;

/*!
	@method          diagnosticsForTranslationUnit:
	@abstract        Gets diagnostics objects for a translation unit
	@param           translationUnit     The translation unit from which to get the diagnostics
	@return          An array with instances of 'CKFixIt'
 */
+ (NSArray*)diagnosticsForTranslationUnit:(CKTranslationUnit*)translationUnit;

/*!
	@method          diagnosticWithTranslationUnit:index:
	@abstract        Gets a specific diagnostic from a translation unit
	@param           translationUnit     The translation unit from which to get the diagnostic
	@param           index               The index of the diagnostic in the translation unit
	@return          The diagnostic object
	@discussion      The returned object is autoreleased.
 */
+ (instancetype) diagnosticWithTranslationUnit:(CKTranslationUnit*)translationUnit index:(NSUInteger)index;

/*!
	@method          initWithTranslationUnit:
	@abstract        Initializes a specific diagnostic with a translation unit
	@param           translationUnit     The translation unit from which to get the diagnostic
	@param           index               The index of the diagnostic in the translation unit
	@return          The diagnostic object
 */
- initWithTranslationUnit:(CKTranslationUnit*)translationUnit index:(NSUInteger)index;

@end
