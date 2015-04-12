
/*!
 * @header          CKCompletionChunk.h
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit completion chunk class
 */

/// @abstract Completion chunk kind

typedef NSUInteger CKCompletionChunkKind;
FOUNDATION_EXPORT CKCompletionChunkKind CKCompletionChunkKindOptional,
                                        CKCompletionChunkKindTypedText,
                                        CKCompletionChunkKindText,
                                        CKCompletionChunkKindPlaceholder,
                                        CKCompletionChunkKindInformative,
                                        CKCompletionChunkKindCurrentParameter,
                                        CKCompletionChunkKindLeftParen,
                                        CKCompletionChunkKindRightParen,
                                        CKCompletionChunkKindLeftBracket,
                                        CKCompletionChunkKindRightBracket,
                                        CKCompletionChunkKindLeftBrace,
                                        CKCompletionChunkKindRightBrace,
                                        CKCompletionChunkKindLeftAngle,
                                        CKCompletionChunkKindRightAngle,
                                        CKCompletionChunkKindComma,
                                        CKCompletionChunkKindResultType,
                                        CKCompletionChunkKindColon,
                                        CKCompletionChunkKindSemiColon,
                                        CKCompletionChunkKindEqual,
                                        CKCompletionChunkKindHorizontalSpace,
                                        CKCompletionChunkKindVerticalSpace;

@interface CKCompletionChunk : NSObject

@property (readonly) NSString* text;

@property (readonly) CKCompletionChunkKind kind;

/*!
 * @method          completionChunkWithCXCompletionString:chunkNumber:
 * @abstract        Gets a completion chunk from a completion string
 * @param           string      The completion string
 * @param           chunkNumber The chunk number
 * @return          The completion chunk object
 * @discussion      The returned object is autoreleased.
*/
+ (instancetype)completionChunkWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber;

/*!
 * @method          initWithCXCompletionString:chunkNumber:
 * @abstract        Initializes a completion chunk from a completion string
 * @param           string      The completion string
 * @param           chunkNumber The chunk number
 * @return          The completion chunk object
*/
- (instancetype)initWithCXCompletionString:(CXCompletionString)string chunkNumber:(NSUInteger)chunkNumber;

@end
