
/* $Id$ */

#import "CKCompletionChunk.h"

CKCompletionChunkKind CKCompletionChunkKindOptional = CXCompletionChunk_Optional,
                      CKCompletionChunkKindTypedText = CXCompletionChunk_TypedText,
                      CKCompletionChunkKindText = CXCompletionChunk_Text,
                      CKCompletionChunkKindPlaceholder = CXCompletionChunk_Placeholder,
                      CKCompletionChunkKindInformative = CXCompletionChunk_Informative,
                      CKCompletionChunkKindCurrentParameter = CXCompletionChunk_CurrentParameter,
                      CKCompletionChunkKindLeftParen = CXCompletionChunk_LeftParen,
                      CKCompletionChunkKindRightParen = CXCompletionChunk_RightParen,
                      CKCompletionChunkKindLeftBracket = CXCompletionChunk_LeftBracket,
                      CKCompletionChunkKindRightBracket = CXCompletionChunk_RightBracket,
                      CKCompletionChunkKindLeftBrace = CXCompletionChunk_LeftBrace,
                      CKCompletionChunkKindRightBrace = CXCompletionChunk_RightBrace,
                      CKCompletionChunkKindLeftAngle = CXCompletionChunk_LeftAngle,
                      CKCompletionChunkKindRightAngle = CXCompletionChunk_RightAngle,
                      CKCompletionChunkKindComma = CXCompletionChunk_Comma,
                      CKCompletionChunkKindResultType = CXCompletionChunk_ResultType,
                      CKCompletionChunkKindColon = CXCompletionChunk_Colon,
                      CKCompletionChunkKindSemiColon = CXCompletionChunk_SemiColon,
                      CKCompletionChunkKindEqual = CXCompletionChunk_Equal,
                      CKCompletionChunkKindHorizontalSpace = CXCompletionChunk_HorizontalSpace,
                      CKCompletionChunkKindVerticalSpace = CXCompletionChunk_VerticalSpace;

@implementation CKCompletionChunk

@synthesize text = _text, kind = _kind;

+ (instancetype)completionChunkWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber {
  return [self.alloc initWithCXCompletionString:string
                   chunkNumber:chunkNumber];
}

- (instancetype)initWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber {
  CXString text;

  if ((self = [self init])) {
    _kind = clang_getCompletionChunkKind(string, (unsigned int)chunkNumber);
    text = clang_getCompletionChunkText(string, (unsigned int)chunkNumber);
    _text = [NSString.alloc
      initWithCString:clang_getCString(text)
             encoding:NSUTF8StringEncoding];
  }

  return self;
}

- (NSString*)description {
  NSString* description;
  NSString* kind;

  description = [super description];

  if (_kind == CKCompletionChunkKindOptional) {
    kind = @"Optional";
  } else if (_kind == CKCompletionChunkKindTypedText) {
    kind = @"Typed text";
  } else if (_kind == CKCompletionChunkKindText) {
    kind = @"Text";
  } else if (_kind == CKCompletionChunkKindPlaceholder) {
    kind = @"Placeholder";
  } else if (_kind == CKCompletionChunkKindInformative) {
    kind = @"Informative";
  } else if (_kind == CKCompletionChunkKindCurrentParameter) {
    kind = @"Parameter";
  } else if (_kind == CKCompletionChunkKindLeftParen) {
    kind = @"Left parenthesis";
  } else if (_kind == CKCompletionChunkKindRightParen) {
    kind = @"Right parenthesis";
  } else if (_kind == CKCompletionChunkKindLeftBracket) {
    kind = @"Left bracket";
  } else if (_kind == CKCompletionChunkKindRightBracket) {
    kind = @"Right bracket";
  } else if (_kind == CKCompletionChunkKindLeftBrace) {
    kind = @"Left brace";
  } else if (_kind == CKCompletionChunkKindRightBrace) {
    kind = @"Right brace";
  } else if (_kind == CKCompletionChunkKindLeftAngle) {
    kind = @"Left angle";
  } else if (_kind == CKCompletionChunkKindRightAngle) {
    kind = @"Right angle";
  } else if (_kind == CKCompletionChunkKindComma) {
    kind = @"Comma";
  } else if (_kind == CKCompletionChunkKindResultType) {
    kind = @"Result type";
  } else if (_kind == CKCompletionChunkKindColon) {
    kind = @"Colon";
  } else if (_kind == CKCompletionChunkKindSemiColon) {
    kind = @"Semi colon";
  } else if (_kind == CKCompletionChunkKindEqual) {
    kind = @"Equal";
  } else if (_kind == CKCompletionChunkKindHorizontalSpace) {
    kind = @"Horizontal space";
  } else if (_kind == CKCompletionChunkKindVerticalSpace) {
    kind = @"Vertical space";
  } else {
    kind = @"N/A";
  }

  return [NSString stringWithFormat:@"%@: %@ - %@", description, kind, _text];
}

@end
