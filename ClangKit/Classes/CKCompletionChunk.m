
/* $Id$ */

#import "CKCompletionChunk.h"

JREnumDefine(CKCompletionChunkKind);

//CKCompletionChunk CKChunkOptional = CXCompletionChunk_Optional,
//                      CKChunkTypedText = CXCompletionChunk_TypedText,
//                      CKChunkText = CXCompletionChunk_Text,
//                      CKChunkPlaceholder = CXCompletionChunk_Placeholder,
//                      CKChunkInformative = CXCompletionChunk_Informative,
//                      CKChunkCurrentParameter = CXCompletionChunk_CurrentParameter,
//                      CKChunkLeftParen = CXCompletionChunk_LeftParen,
//                      CKChunkRightParen = CXCompletionChunk_RightParen,
//                      CKChunkLeftBracket = CXCompletionChunk_LeftBracket,
//                      CKChunkRightBracket = CXCompletionChunk_RightBracket,
//                      CKChunkLeftBrace = CXCompletionChunk_LeftBrace,
//                      CKChunkRightBrace = CXCompletionChunk_RightBrace,
//                      CKChunkLeftAngle = CXCompletionChunk_LeftAngle,
//                      CKChunkRightAngle = CXCompletionChunk_RightAngle,
//                      CKChunkComma = CXCompletionChunk_Comma,
//                      CKChunkResultType = CXCompletionChunk_ResultType,
//                      CKChunkColon = CXCompletionChunk_Colon,
//                      CKChunkSemiColon = CXCompletionChunk_SemiColon,
//                      CKChunkEqual = CXCompletionChunk_Equal,
//                      CKChunkHorizontalSpace = CXCompletionChunk_HorizontalSpace,
//                      CKChunkVerticalSpace = CXCompletionChunk_VerticalSpace;

@implementation CKCompletionChunk

@synthesize text = _text, kind = _kind;

+ (instancetype)completionChunkWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber {
  return [self.alloc initWithCXCompletionString:string chunkNumber:chunkNumber];
}

- (instancetype)initWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber {

  SUPERINIT;

  _kind = clang_getCompletionChunkKind(string, (unsigned int)chunkNumber);
  CXString text = clang_getCompletionChunkText(string, (unsigned int)chunkNumber);
  _text = [NSString.alloc initWithCString:clang_getCString(text) encoding:NSUTF8StringEncoding];
  return self;
}

- (NSString*)description {



  NSString* description = [super description];

//  if (_kind == CKChunkOptional) {
//    kind = @"Optional";
//  } else if (_kind == CKChunkTypedText) {
//    kind = @"Typed text";
//  } else if (_kind == CKChunkText) {
//    kind = @"Text";
//  } else if (_kind == CKChunkPlaceholder) {
//    kind = @"Placeholder";
//  } else if (_kind == CKChunkInformative) {
//    kind = @"Informative";
//  } else if (_kind == CKChunkCurrentParameter) {
//    kind = @"Parameter";
//  } else if (_kind == CKChunkLeftParen) {
//    kind = @"Left parenthesis";
//  } else if (_kind == CKChunkRightParen) {
//    kind = @"Right parenthesis";
//  } else if (_kind == CKChunkLeftBracket) {
//    kind = @"Left bracket";
//  } else if (_kind == CKChunkRightBracket) {
//    kind = @"Right bracket";
//  } else if (_kind == CKChunkLeftBrace) {
//    kind = @"Left brace";
//  } else if (_kind == CKChunkRightBrace) {
//    kind = @"Right brace";
//  } else if (_kind == CKChunkLeftAngle) {
//    kind = @"Left angle";
//  } else if (_kind == CKChunkRightAngle) {
//    kind = @"Right angle";
//  } else if (_kind == CKChunkComma) {
//    kind = @"Comma";
//  } else if (_kind == CKChunkResultType) {
//    kind = @"Result type";
//  } else if (_kind == CKChunkColon) {
//    kind = @"Colon";
//  } else if (_kind == CKChunkSemiColon) {
//    kind = @"Semi colon";
//  } else if (_kind == CKChunkEqual) {
//    kind = @"Equal";
//  } else if (_kind == CKChunkHorizontalSpace) {
//    kind = @"Horizontal space";
//  } else if (_kind == CKChunkVerticalSpace) {
//    kind = @"Vertical space";
//  } else {
//    kind = @"N/A";
//  }

  id kind = [CKCompletionChunkKindToString(_kind) substringFromIndex:7];
  return [NSString stringWithFormat:@"%@: %@ - %@", description, kind, _text];
}

@end
