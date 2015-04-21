
/*!
	@header          CKCompletionChunk.h
	@copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author          Jean-David Gadina - www.xs-labs.com
	@abstract        ClangKit completion chunk class
 */

/// @abstract Completion chunk kind

JREnumDeclare(CKCompletionChunkKind,  CKChunkOptional,          CKChunkTypedText,
                                      CKChunkText,              CKChunkPlaceholder,
                                      CKChunkInformative,       CKChunkCurrentParameter,
                                      CKChunkLeftParen,         CKChunkRightParen,
                                      CKChunkLeftBracket,       CKChunkRightBracket,
                                      CKChunkLeftBrace,         CKChunkRightBrace,
                                      CKChunkLeftAngle,         CKChunkRightAngle,
                                      CKChunkComma,             CKChunkResultType,
                                      CKChunkColon,             CKChunkSemiColon,
                                      CKChunkEqual,             CKChunkHorizontalSpace,
                                      CKChunkVerticalSpace)

@interface CKCompletionChunk : NSObject

@property (readonly) NSString* text;

@property (readonly) CKCompletionChunkKind kind;

/*!
	@method          completionChunkWithCXCompletionString:chunkNumber:
	@abstract        Gets a completion chunk from a completion string
	@param           string      The completion string
	@param           chunkNumber The chunk number
	@return          The completion chunk object
	@discussion      The returned object is autoreleased.
*/
+ (instancetype) completionChunkWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber;

@end
