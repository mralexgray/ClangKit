 
/* $Id$ */

/*!
 * @header          CKToken.h
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit token class
 */

/*!
 * @typedef         CKTokenKind
 * @abstract        Token kind
 */
typedef NSInteger CKTokenKind;

FOUNDATION_EXPORT CKTokenKind CKTokenKindPunctuation,
                              CKTokenKindKeyword,
                              CKTokenKindIdentifier,
                              CKTokenKindLiteral,
                              CKTokenKindComment;

@class CKTranslationUnit, CKCursor, CKSourceLocation;

@interface CKToken: NSObject

@property (readonly) NSString * spelling;

@property (readonly) CKTokenKind kind;

@property (readonly) NSUInteger line, column;

@property (readonly) NSRange range;

@property (readonly) CKCursor * cursor;

@property (readonly) CKSourceLocation * sourceLocation;

/*!
 * @method          tokensForTranslationUnit:tokens:
 * @abstract        Gets a list of token objects from a translation unit
 * @param           translationUnit     The translation unit
 * @param           tokensPointer       Optional - Used to retrieve the internal libclang tokens
 * @return          An array of token objects
 */
+ ( NSArray * )tokensForTranslationUnit: ( CKTranslationUnit * )translationUnit tokens: ( void ** )tokensPointer;

@end
