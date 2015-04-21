
/* $Id$ */

#import "CKToken.h"
#import "CKTranslationUnit.h"
#import "CKCursor.h"
#import "CKSourceLocation.h"

JREnumDefine(CKTokenKind);

@implementation CKToken

@synthesize spelling = _spelling, kind = _kind, line = _line, column = _column, range = _range, cursor = _cursor, sourceLocation = _sourceLocation;

+ (NSArray*)tokensForTranslationUnit:(CKTranslationUnit*)translationUnit tokens:(void**)tokensPointer {

  if (!translationUnit) return @[];

  CXFile file = clang_getFile(translationUnit.cxTranslationUnit, translationUnit.path.fileSystemRepresentation);
  CXSourceLocation startLocation = clang_getLocationForOffset(translationUnit.cxTranslationUnit, file, 0);
  CXSourceLocation endLocation   = clang_getLocationForOffset(translationUnit.cxTranslationUnit, file, (unsigned int)translationUnit.text.length);
  CXSourceRange range = clang_getRange(startLocation, endLocation);
  unsigned int numTokens = 0;
  CXToken* cxTokens = NULL;

  clang_tokenize( translationUnit.cxTranslationUnit, range, &cxTokens, &numTokens);

  if (numTokens == 0) return nil;

  clang_annotateTokens(translationUnit.cxTranslationUnit, cxTokens, numTokens, NULL);

  NSMutableArray* tokens = [NSMutableArray arrayWithCapacity:(NSUInteger)numTokens];

  for (unsigned int i = 0; i < numTokens; i++) { CKToken* token;

    if ((token = [CKToken.alloc initWithCXToken:cxTokens[i] translationUnit:translationUnit]))
                 [tokens addObject:token];
  }

  if (tokensPointer != NULL) *(tokensPointer) = (char*)cxTokens;

  return tokens.copy;
}
- (NSString*)description {

  NSString* kind = _kind == CKTokenKindPunctuation ? @"Punctuation" :
                   _kind == CKTokenKindKeyword ? @"Keyword" :
                   _kind == CKTokenKindIdentifier ? @"Identifier" :
                   _kind == CKTokenKindLiteral ? @"Literal" :
                   _kind == CKTokenKindComment ? @"Comment" : @"Unknown";


  return [NSString stringWithFormat:@"%@ [%2lu:%2lu] %12s  %-20s %@", self.className,

          _line, _column, kind.UTF8String, _spelling.UTF8String, _cursor.kindSpelling];
}

// Private

- (id)initWithCXToken:(CXToken)token translationUnit:(CKTranslationUnit*)translationUnit {
  CXString spelling;
  CXSourceRange range;
  CXSourceLocation location;
  unsigned int line;
  unsigned int column;
  unsigned int offset;

  if ((self = [self init])) {
    spelling = clang_getTokenSpelling(translationUnit.cxTranslationUnit, token);
    _spelling = [NSString.alloc
      initWithCString:clang_getCString(spelling)
             encoding:NSUTF8StringEncoding];
    _kind = clang_getTokenKind(token);
    location = clang_getTokenLocation(translationUnit.cxTranslationUnit, token);
    range = clang_getTokenExtent(translationUnit.cxTranslationUnit, token);

    clang_getExpansionLocation(location, translationUnit.cxFile, &line, &column, &offset);

    _line = (NSUInteger)line;
    _column = (NSUInteger)column;
    _range = NSMakeRange((NSUInteger)offset, range.end_int_data - range.begin_int_data);
    _sourceLocation = [CKSourceLocation.alloc
      initWithPointerData1:(void*)location.ptr_data[0]
              pointerData2:(void*)location.ptr_data[1]
                   intData:location.int_data];
    _cursor = [CKCursor.alloc
      initWithLocation:_sourceLocation
       translationUnit:translationUnit];
  }

  return self;
}
@end
