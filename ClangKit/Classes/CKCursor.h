 
/* $Id$ */

/*!
 * @header          CKCursor.h
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit cursor class
 */

/*!
 * @typedef         CKCursorKind
 * @abstract        Cursor kind
 */
typedef NSInteger CKCursorKind;

FOUNDATION_EXPORT CKCursorKind CKCursorKindUnexposedDecl,
                               CKCursorKindStructDecl,
                               CKCursorKindUnionDecl,
                               CKCursorKindClassDecl,
                               CKCursorKindEnumDecl,
                               CKCursorKindFieldDecl,
                               CKCursorKindEnumConstantDecl,
                               CKCursorKindFunctionDecl,
                               CKCursorKindVarDecl,
                               CKCursorKindParmDecl,
                               CKCursorKindObjCInterfaceDecl,
                               CKCursorKindObjCCategoryDecl,
                               CKCursorKindObjCProtocolDecl,
                               CKCursorKindObjCPropertyDecl,
                               CKCursorKindObjCIvarDecl,
                               CKCursorKindObjCInstanceMethodDecl,
                               CKCursorKindObjCClassMethodDecl,
                               CKCursorKindObjCImplementationDecl,
                               CKCursorKindObjCCategoryImplDecl,
                               CKCursorKindTypedefDecl,
                               CKCursorKindCXXMethod,
                               CKCursorKindNamespace,
                               CKCursorKindLinkageSpec,
                               CKCursorKindConstructor,
                               CKCursorKindDestructor,
                               CKCursorKindConversionFunction,
                               CKCursorKindTemplateTypeParameter,
                               CKCursorKindNonTypeTemplateParameter,
                               CKCursorKindTemplateTemplateParameter,
                               CKCursorKindFunctionTemplate,
                               CKCursorKindClassTemplate,
                               CKCursorKindClassTemplatePartialSpecialization,
                               CKCursorKindNamespaceAlias,
                               CKCursorKindUsingDirective,
                               CKCursorKindUsingDeclaration,
                               CKCursorKindTypeAliasDecl,
                               CKCursorKindObjCSynthesizeDecl,
                               CKCursorKindObjCDynamicDecl,
                               CKCursorKindCXXAccessSpecifier,
                               CKCursorKindFirstDecl,
                               CKCursorKindLastDecl,
                               CKCursorKindFirstRef,
                               CKCursorKindObjCSuperClassRef,
                               CKCursorKindObjCProtocolRef,
                               CKCursorKindObjCClassRef,
                               CKCursorKindTypeRef,
                               CKCursorKindCXXBaseSpecifier,
                               CKCursorKindTemplateRef,
                               CKCursorKindNamespaceRef,
                               CKCursorKindMemberRef,
                               CKCursorKindLabelRef,
                               CKCursorKindOverloadedDeclRef,
                               CKCursorKindVariableRef,
                               CKCursorKindLastRef,
                               CKCursorKindFirstInvalid,
                               CKCursorKindInvalidFile,
                               CKCursorKindNoDeclFound,
                               CKCursorKindNotImplemented,
                               CKCursorKindInvalidCode,
                               CKCursorKindLastInvalid,
                               CKCursorKindFirstExpr,
                               CKCursorKindUnexposedExpr,
                               CKCursorKindDeclRefExpr,
                               CKCursorKindMemberRefExpr,
                               CKCursorKindCallExpr,
                               CKCursorKindObjCMessageExpr,
                               CKCursorKindBlockExpr,
                               CKCursorKindIntegerLiteral,
                               CKCursorKindFloatingLiteral,
                               CKCursorKindImaginaryLiteral,
                               CKCursorKindStringLiteral,
                               CKCursorKindCharacterLiteral,
                               CKCursorKindParenExpr,
                               CKCursorKindUnaryOperator,
                               CKCursorKindArraySubscriptExpr,
                               CKCursorKindBinaryOperator,
                               CKCursorKindCompoundAssignOperator,
                               CKCursorKindConditionalOperator,
                               CKCursorKindCStyleCastExpr,
                               CKCursorKindCompoundLiteralExpr,
                               CKCursorKindInitListExpr,
                               CKCursorKindAddrLabelExpr,
                               CKCursorKindStmtExpr,
                               CKCursorKindGenericSelectionExpr,
                               CKCursorKindGNUNullExpr,
                               CKCursorKindCXXStaticCastExpr,
                               CKCursorKindCXXDynamicCastExpr,
                               CKCursorKindCXXReinterpretCastExpr,
                               CKCursorKindCXXConstCastExpr,
                               CKCursorKindCXXFunctionalCastExpr,
                               CKCursorKindCXXTypeidExpr,
                               CKCursorKindCXXBoolLiteralExpr,
                               CKCursorKindCXXNullPtrLiteralExpr,
                               CKCursorKindCXXThisExpr,
                               CKCursorKindCXXThrowExpr,
                               CKCursorKindCXXNewExpr,
                               CKCursorKindCXXDeleteExpr,
                               CKCursorKindUnaryExpr,
                               CKCursorKindObjCStringLiteral,
                               CKCursorKindObjCEncodeExpr,
                               CKCursorKindObjCSelectorExpr,
                               CKCursorKindObjCProtocolExpr,
                               CKCursorKindObjCBridgedCastExpr,
                               CKCursorKindPackExpansionExpr,
                               CKCursorKindSizeOfPackExpr,
                               CKCursorKindLambdaExpr,
                               CKCursorKindObjCBoolLiteralExpr,
                               CKCursorKindLastExpr,
                               CKCursorKindFirstStmt,
                               CKCursorKindUnexposedStmt,
                               CKCursorKindLabelStmt,
                               CKCursorKindCompoundStmt,
                               CKCursorKindCaseStmt,
                               CKCursorKindDefaultStmt,
                               CKCursorKindIfStmt,
                               CKCursorKindSwitchStmt,
                               CKCursorKindWhileStmt,
                               CKCursorKindDoStmt,
                               CKCursorKindForStmt,
                               CKCursorKindGotoStmt,
                               CKCursorKindIndirectGotoStmt,
                               CKCursorKindContinueStmt,
                               CKCursorKindBreakStmt,
                               CKCursorKindReturnStmt,
                               CKCursorKindAsmStmt,
                               CKCursorKindObjCAtTryStmt,
                               CKCursorKindObjCAtCatchStmt,
                               CKCursorKindObjCAtFinallyStmt,
                               CKCursorKindObjCAtThrowStmt,
                               CKCursorKindObjCAtSynchronizedStmt,
                               CKCursorKindObjCAutoreleasePoolStmt,
                               CKCursorKindObjCForCollectionStmt,
                               CKCursorKindCXXCatchStmt,
                               CKCursorKindCXXTryStmt,
                               CKCursorKindCXXForRangeStmt,
                               CKCursorKindSEHTryStmt,
                               CKCursorKindSEHExceptStmt,
                               CKCursorKindSEHFinallyStmt,
                               CKCursorKindMSAsmStmt,
                               CKCursorKindNullStmt,
                               CKCursorKindDeclStmt,
                               CKCursorKindLastStmt,
                               CKCursorKindTranslationUnit,
                               CKCursorKindFirstAttr,
                               CKCursorKindUnexposedAttr,
                               CKCursorKindIBActionAttr,
                               CKCursorKindIBOutletAttr,
                               CKCursorKindIBOutletCollectionAttr,
                               CKCursorKindCXXFinalAttr,
                               CKCursorKindCXXOverrideAttr,
                               CKCursorKindAnnotateAttr,
                               CKCursorKindAsmLabelAttr,
                               CKCursorKindLastAttr,
                               CKCursorKindPreprocessingDirective,
                               CKCursorKindMacroDefinition,
                               CKCursorKindMacroExpansion,
                               CKCursorKindMacroInstantiation,
                               CKCursorKindInclusionDirective,
                               CKCursorKindFirstPreprocessing,
                               CKCursorKindLastPreprocessing;

@class CKTranslationUnit;
@class CKSourceLocation;

/*!
 * @class           CKCursor
 * @abstract        Cursor class
 */
@interface CKCursor : NSObject

/*!
 * @property        kind
 * @abstract        The cursor kind
 */
@property (readonly) CKCursorKind kind;

/*!
 * @property        displayName
 * @abstract        The cursor's display name
 */
@property(readonly) NSString * displayName;

/*!
 * @property        kindSpelling
 * @abstract        The cursor kind's spelling
 */
@property (readonly) NSString * kindSpelling;

/*! @abstract        The cursor containing the cursor's definition */

@property (readonly) CKCursor * definition;

/*! @abstract        The cursor containing the cursor's semantic parent */

@property (readonly) CKCursor * semanticParent;

/*! @abstract        The cursor containing the cursor's lexical parent */

@property (readonly) CKCursor * lexicalParent;

@property (readonly) CKCursor * canonical,
                              * referenced;

/*! @abstract        The cursor's source location */

@property (readonly) CKSourceLocation * location;

/*! @abstract        Whether the cursor is a definition of rot */

@property (readonly) BOOL isDefinition;

/*! @abstract        Whether the cursor is a declaration of rot */

@property (readonly) BOOL isDeclaration;

/*! @abstract        Whether the cursor is a reference of rot */

@property (readonly) BOOL isReference;

/*! @abstract        Whether the cursor is preprocessing of rot */

@property (readonly) BOOL isPreprocessing;

/*!
 * @property        isExpression
 * @abstract        Whether the cursor is an expression of rot
 */
@property (readonly) BOOL isExpression;

/*!
 * @property        isAttribute
 * @abstract        Whether the cursor is an attribute of rot
 */
@property (readonly) BOOL isAttribute;

/*!
 * @property        isInvalid
 * @abstract        Whether the cursor is invalid of rot
 */
@property (readonly) BOOL isInvalid;

/*!
 * @property        isStatement
 * @abstract        Whether the cursor is a statement of rot
 */
@property (readonly) BOOL isStatement;

/*!
 * @property        isTranslationUnit
 * @abstract        Whether the cursor is a translation unit of rot
 */
@property (readonly) BOOL isTranslationUnit;

/*!
 * @property        isUnexposed
 * @abstract        Whether the cursor is unexposed of rot
 */
@property (readonly) BOOL isUnexposed;

/*!
 * @method          cursorWithLocation:translationUnit:
 * @abstract        Gets a cursor from a location and a translation unit
 * @param           location        The source location
 * @param           translationUnit The translation unit
 * @return          The cursor object
 * @discussion      The returned object is autoreleased.
 */
+ ( instancetype )cursorWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit;

/*!
 * @method          initWithLocation:translationUnit:
 * @abstract        Initializes a cursor with a location and a translation unit
 * @param           location        The source location
 * @param           translationUnit The translation unit
 * @return          The cursor object
 */
- ( instancetype )initWithLocation: ( CKSourceLocation * )location translationUnit: ( CKTranslationUnit * )translationUnit;

@end
