
/* $Id$ */

/*!
 * @header          CKTranslationUnit.h
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit translation unit class
 */

@class CKIndex;

/*!
 * @class           CKTranslationUnit
 * @abstract        Translation unit class
 */
@interface CKTranslationUnit : NSObject {
@protected

  NSString* _path;
  NSString* _text;
  CXTranslationUnit _cxTranslationUnit;
  CKIndex* _index;
  char** _args;
  int _numArgs;
  NSArray* _diagnostics;
  NSArray* _tokens;
  void* _tokensPointer;
  void* _unsavedFile;
  NSLock* _lock;
}

@property (readonly) NSString* path;

@property NSString* text;

@property (readonly) CKIndex* index;

@property (readonly) NSArray* diagnostics, *tokens;

/// Internal libclang translation unit object
@property (readonly) CXTranslationUnit cxTranslationUnit;

/// Internal libclang file object
@property (readonly) CXFile cxFile;

/// Returns an autoreleased translation unit object from a path

+ (instancetype)translationUnitWithPath:(NSString*)path;

/*!
 * @method          translationUnitWithPath:index:
 * @abstract        Gets a translation unit from a path and an index
 * @param           path        The path
 * @param           index       The index
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithPath:(NSString*)path index:(CKIndex*)index;

/*!
 * @method          translationUnitWithPath:args:
 * @abstract        Gets a translation unit from a path and arguments
 * @param           path        The path
 * @param           args        The arguments
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithPath:(NSString*)path args:(NSArray*)args;

/*!
 * @method          translationUnitWithPath:index:args:
 * @abstract        Gets a translation unit from a path, index and arguments
 * @param           path        The path
 * @param           index       The index
 * @param           args        The arguments
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithPath:(NSString*)path index:(CKIndex*)index args:(NSArray*)args;

/*!
 * @method          translationUnitWithText:language:
 * @abstract        Gets a translation unit from a text
 * @param           text        The text
 * @param           language    The language to use
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language;

/*!
 * @method          translationUnitWithText:language:index:
 * @abstract        Gets a translation unit from a text and an index
 * @param           text        The text
 * @param           language    The language to use
 * @param           index       The index
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index;

/*!
 * @method          translationUnitWithText:language:args:
 * @abstract        Gets a translation unit from a text and arguments
 * @param           text        The text
 * @param           language    The language to use
 * @param           args        The arguments
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language args:(NSArray*)args;

/*!
 * @method          translationUnitWithText:language:index:args:
 * @abstract        Gets a translation unit from a text, index and arguments
 * @param           text        The text
 * @param           language    The language to use
 * @param           index       The index
 * @param           args        The arguments
 * @return          The translation unit object
 * @discussion      The returned object is autoreleased.
 */
+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index args:(NSArray*)args;

/*!
 * @method          initWithPath:
 * @abstract        Initializes a translation unit with a path
 * @param           path        The path
 * @return          The translation unit objectb                                                                                                                                             
 */
- (instancetype)initWithPath:(NSString*)path;

/*!
 * @method          initWithPath:index:
 * @abstract        Initializes a translation unit from a path and an index
 * @param           path        The path
 * @param           index       The index
 * @return          The translation unit object
 */
- (instancetype)initWithPath:(NSString*)path index:(CKIndex*)index;

/*!
 * @method          initWithPath:args:
 * @abstract        Initializes a translation unit from a path and arguments
 * @param           path        The path
 * @param           args        The arguments
 * @return          The translation unit object
 */
- (instancetype)initWithPath:(NSString*)path args:(NSArray*)args;

/*!
 * @method          initWithPath:index:args:
 * @abstract        Initializes a translation unit from a path, index and arguments
 * @param           path        The path
 * @param           index       The index
 * @param           args        The arguments
 * @return          The translation unit object
 */
- (instancetype)initWithPath:(NSString*)path index:(CKIndex*)index args:(NSArray*)args;

/*!
 * @method          initWithText:language:
 * @abstract        Initializes a translation unit from a text
 * @param           text        The text
 * @param           language    The language to use
 * @return          The translation unit object
 */
- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language;

/*!
 * @method          initWithText:language:index:
 * @abstract        Initializes a translation unit from a text and an index
 * @param           text        The text
 * @param           language    The language to use
 * @param           index       The index
 * @return          The translation unit object
 */
- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index;

/*!
 * @method          initWithText:language:args:
 * @abstract        Initializes a translation unit from a text and arguments
 * @param           text        The text
 * @param           language    The language to use
 * @param           args        The arguments
 * @return          The translation unit object
 */
- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language args:(NSArray*)args;

/*!
 * @method          initWithText:language:index:args:
 * @abstract        Initializes a translation unit from a text, index and arguments
 * @param           text        The text
 * @param           language    The language to use
 * @param           index       The index
 * @param           args        The arguments
 * @return          The translation unit object
 */
- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index args:(NSArray*)args;

/*!
 * @method          reparse
 * @abstract        Reparses the translation unit
 */
- (void)reparse;

/*!
 * @method          completionResultsForLine:column:
 * @abstract        Gets completion results for a specific line and column
 * @param           line        The line number
 * @param           column      The column number
 * @return          An array of completion results
 */
- (NSArray*)completionResultsForLine:(NSUInteger)line column:(NSUInteger)column;

@end
