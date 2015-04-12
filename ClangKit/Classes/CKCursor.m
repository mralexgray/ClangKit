
/* $Id$ */

#import "CKCursor.h"
#import "CKSourceLocation.h"
#import "CKTranslationUnit.h"

CKCursorKind CKCursorKindUnexposedDecl = CXCursor_UnexposedDecl,
             CKCursorKindStructDecl = CXCursor_StructDecl,
             CKCursorKindUnionDecl = CXCursor_UnionDecl,
             CKCursorKindClassDecl = CXCursor_ClassDecl,
             CKCursorKindEnumDecl = CXCursor_EnumDecl,
             CKCursorKindFieldDecl = CXCursor_FieldDecl,
             CKCursorKindEnumConstantDecl = CXCursor_EnumConstantDecl,
             CKCursorKindFunctionDecl = CXCursor_FunctionDecl,
             CKCursorKindVarDecl = CXCursor_VarDecl,
             CKCursorKindParmDecl = CXCursor_ParmDecl,
             CKCursorKindObjCInterfaceDecl = CXCursor_ObjCInterfaceDecl,
             CKCursorKindObjCCategoryDecl = CXCursor_ObjCCategoryDecl,
             CKCursorKindObjCProtocolDecl = CXCursor_ObjCProtocolDecl,
             CKCursorKindObjCPropertyDecl = CXCursor_ObjCPropertyDecl,
             CKCursorKindObjCIvarDecl = CXCursor_ObjCIvarDecl,
             CKCursorKindObjCInstanceMethodDecl = CXCursor_ObjCInstanceMethodDecl,
             CKCursorKindObjCClassMethodDecl = CXCursor_ObjCClassMethodDecl,
             CKCursorKindObjCImplementationDecl = CXCursor_ObjCImplementationDecl,
             CKCursorKindObjCCategoryImplDecl = CXCursor_ObjCCategoryImplDecl,
             CKCursorKindTypedefDecl = CXCursor_TypedefDecl,
             CKCursorKindCXXMethod = CXCursor_CXXMethod,
             CKCursorKindNamespace = CXCursor_Namespace,
             CKCursorKindLinkageSpec = CXCursor_LinkageSpec,
             CKCursorKindConstructor = CXCursor_Constructor,
             CKCursorKindDestructor = CXCursor_Destructor,
             CKCursorKindConversionFunction = CXCursor_ConversionFunction,
             CKCursorKindTemplateTypeParameter = CXCursor_TemplateTypeParameter,
             CKCursorKindNonTypeTemplateParameter = CXCursor_NonTypeTemplateParameter,
             CKCursorKindTemplateTemplateParameter = CXCursor_TemplateTemplateParameter,
             CKCursorKindFunctionTemplate = CXCursor_FunctionTemplate,
             CKCursorKindClassTemplate = CXCursor_ClassTemplate,
             CKCursorKindClassTemplatePartialSpecialization = CXCursor_ClassTemplatePartialSpecialization,
             CKCursorKindNamespaceAlias = CXCursor_NamespaceAlias,
             CKCursorKindUsingDirective = CXCursor_UsingDirective,
             CKCursorKindUsingDeclaration = CXCursor_UsingDeclaration,
             CKCursorKindTypeAliasDecl = CXCursor_TypeAliasDecl,
             CKCursorKindObjCSynthesizeDecl = CXCursor_ObjCSynthesizeDecl,
             CKCursorKindObjCDynamicDecl = CXCursor_ObjCDynamicDecl,
             CKCursorKindCXXAccessSpecifier = CXCursor_CXXAccessSpecifier,
             CKCursorKindFirstDecl = CXCursor_FirstDecl,
             CKCursorKindLastDecl = CXCursor_LastDecl,
             CKCursorKindFirstRef = CXCursor_FirstRef,
             CKCursorKindObjCSuperClassRef = CXCursor_ObjCSuperClassRef,
             CKCursorKindObjCProtocolRef = CXCursor_ObjCProtocolRef,
             CKCursorKindObjCClassRef = CXCursor_ObjCClassRef,
             CKCursorKindTypeRef = CXCursor_TypeRef,
             CKCursorKindCXXBaseSpecifier = CXCursor_CXXBaseSpecifier,
             CKCursorKindTemplateRef = CXCursor_TemplateRef,
             CKCursorKindNamespaceRef = CXCursor_NamespaceRef,
             CKCursorKindMemberRef = CXCursor_MemberRef,
             CKCursorKindLabelRef = CXCursor_LabelRef,
             CKCursorKindOverloadedDeclRef = CXCursor_OverloadedDeclRef,
             CKCursorKindVariableRef = CXCursor_VariableRef,
             CKCursorKindLastRef = CXCursor_LastRef,
             CKCursorKindFirstInvalid = CXCursor_FirstInvalid,
             CKCursorKindInvalidFile = CXCursor_InvalidFile,
             CKCursorKindNoDeclFound = CXCursor_NoDeclFound,
             CKCursorKindNotImplemented = CXCursor_NotImplemented,
             CKCursorKindInvalidCode = CXCursor_InvalidCode,
             CKCursorKindLastInvalid = CXCursor_LastInvalid,
             CKCursorKindFirstExpr = CXCursor_FirstExpr,
             CKCursorKindUnexposedExpr = CXCursor_UnexposedExpr,
             CKCursorKindDeclRefExpr = CXCursor_DeclRefExpr,
             CKCursorKindMemberRefExpr = CXCursor_MemberRefExpr,
             CKCursorKindCallExpr = CXCursor_CallExpr,
             CKCursorKindObjCMessageExpr = CXCursor_ObjCMessageExpr,
             CKCursorKindBlockExpr = CXCursor_BlockExpr,
             CKCursorKindIntegerLiteral = CXCursor_IntegerLiteral,
             CKCursorKindFloatingLiteral = CXCursor_FloatingLiteral,
             CKCursorKindImaginaryLiteral = CXCursor_ImaginaryLiteral,
             CKCursorKindStringLiteral = CXCursor_StringLiteral,
             CKCursorKindCharacterLiteral = CXCursor_CharacterLiteral,
             CKCursorKindParenExpr = CXCursor_ParenExpr,
             CKCursorKindUnaryOperator = CXCursor_UnaryOperator,
             CKCursorKindArraySubscriptExpr = CXCursor_ArraySubscriptExpr,
             CKCursorKindBinaryOperator = CXCursor_BinaryOperator,
             CKCursorKindCompoundAssignOperator = CXCursor_CompoundAssignOperator,
             CKCursorKindConditionalOperator = CXCursor_ConditionalOperator,
             CKCursorKindCStyleCastExpr = CXCursor_CStyleCastExpr,
             CKCursorKindCompoundLiteralExpr = CXCursor_CompoundLiteralExpr,
             CKCursorKindInitListExpr = CXCursor_InitListExpr,
             CKCursorKindAddrLabelExpr = CXCursor_AddrLabelExpr,
             CKCursorKindStmtExpr = CXCursor_StmtExpr,
             CKCursorKindGenericSelectionExpr = CXCursor_GenericSelectionExpr,
             CKCursorKindGNUNullExpr = CXCursor_GNUNullExpr,
             CKCursorKindCXXStaticCastExpr = CXCursor_CXXStaticCastExpr,
             CKCursorKindCXXDynamicCastExpr = CXCursor_CXXDynamicCastExpr,
             CKCursorKindCXXReinterpretCastExpr = CXCursor_CXXReinterpretCastExpr,
             CKCursorKindCXXConstCastExpr = CXCursor_CXXConstCastExpr,
             CKCursorKindCXXFunctionalCastExpr = CXCursor_CXXFunctionalCastExpr,
             CKCursorKindCXXTypeidExpr = CXCursor_CXXTypeidExpr,
             CKCursorKindCXXBoolLiteralExpr = CXCursor_CXXBoolLiteralExpr,
             CKCursorKindCXXNullPtrLiteralExpr = CXCursor_CXXNullPtrLiteralExpr,
             CKCursorKindCXXThisExpr = CXCursor_CXXThisExpr,
             CKCursorKindCXXThrowExpr = CXCursor_CXXThrowExpr,
             CKCursorKindCXXNewExpr = CXCursor_CXXNewExpr,
             CKCursorKindCXXDeleteExpr = CXCursor_CXXDeleteExpr,
             CKCursorKindUnaryExpr = CXCursor_UnaryExpr,
             CKCursorKindObjCStringLiteral = CXCursor_ObjCStringLiteral,
             CKCursorKindObjCEncodeExpr = CXCursor_ObjCEncodeExpr,
             CKCursorKindObjCSelectorExpr = CXCursor_ObjCSelectorExpr,
             CKCursorKindObjCProtocolExpr = CXCursor_ObjCProtocolExpr,
             CKCursorKindObjCBridgedCastExpr = CXCursor_ObjCBridgedCastExpr,
             CKCursorKindPackExpansionExpr = CXCursor_PackExpansionExpr,
             CKCursorKindSizeOfPackExpr = CXCursor_SizeOfPackExpr,
             CKCursorKindLambdaExpr = CXCursor_LambdaExpr,
             CKCursorKindObjCBoolLiteralExpr = CXCursor_ObjCBoolLiteralExpr,
             CKCursorKindLastExpr = CXCursor_LastExpr,
             CKCursorKindFirstStmt = CXCursor_FirstStmt,
             CKCursorKindUnexposedStmt = CXCursor_UnexposedStmt,
             CKCursorKindLabelStmt = CXCursor_LabelStmt,
             CKCursorKindCompoundStmt = CXCursor_CompoundStmt,
             CKCursorKindCaseStmt = CXCursor_CaseStmt,
             CKCursorKindDefaultStmt = CXCursor_DefaultStmt,
             CKCursorKindIfStmt = CXCursor_IfStmt,
             CKCursorKindSwitchStmt = CXCursor_SwitchStmt,
             CKCursorKindWhileStmt = CXCursor_WhileStmt,
             CKCursorKindDoStmt = CXCursor_DoStmt,
             CKCursorKindForStmt = CXCursor_ForStmt,
             CKCursorKindGotoStmt = CXCursor_GotoStmt,
             CKCursorKindIndirectGotoStmt = CXCursor_IndirectGotoStmt,
             CKCursorKindContinueStmt = CXCursor_ContinueStmt,
             CKCursorKindBreakStmt = CXCursor_BreakStmt,
             CKCursorKindReturnStmt = CXCursor_ReturnStmt,
             CKCursorKindAsmStmt = CXCursor_AsmStmt,
             CKCursorKindObjCAtTryStmt = CXCursor_ObjCAtTryStmt,
             CKCursorKindObjCAtCatchStmt = CXCursor_ObjCAtCatchStmt,
             CKCursorKindObjCAtFinallyStmt = CXCursor_ObjCAtFinallyStmt,
             CKCursorKindObjCAtThrowStmt = CXCursor_ObjCAtThrowStmt,
             CKCursorKindObjCAtSynchronizedStmt = CXCursor_ObjCAtSynchronizedStmt,
             CKCursorKindObjCAutoreleasePoolStmt = CXCursor_ObjCAutoreleasePoolStmt,
             CKCursorKindObjCForCollectionStmt = CXCursor_ObjCForCollectionStmt,
             CKCursorKindCXXCatchStmt = CXCursor_CXXCatchStmt,
             CKCursorKindCXXTryStmt = CXCursor_CXXTryStmt,
             CKCursorKindCXXForRangeStmt = CXCursor_CXXForRangeStmt,
             CKCursorKindSEHTryStmt = CXCursor_SEHTryStmt,
             CKCursorKindSEHExceptStmt = CXCursor_SEHExceptStmt,
             CKCursorKindSEHFinallyStmt = CXCursor_SEHFinallyStmt,
             CKCursorKindMSAsmStmt = CXCursor_MSAsmStmt,
             CKCursorKindNullStmt = CXCursor_NullStmt,
             CKCursorKindDeclStmt = CXCursor_DeclStmt,
             CKCursorKindLastStmt = CXCursor_LastStmt,
             CKCursorKindTranslationUnit = CXCursor_TranslationUnit,
             CKCursorKindFirstAttr = CXCursor_FirstAttr,
             CKCursorKindUnexposedAttr = CXCursor_UnexposedAttr,
             CKCursorKindIBActionAttr = CXCursor_IBActionAttr,
             CKCursorKindIBOutletAttr = CXCursor_IBOutletAttr,
             CKCursorKindIBOutletCollectionAttr = CXCursor_IBOutletCollectionAttr,
             CKCursorKindCXXFinalAttr = CXCursor_CXXFinalAttr,
             CKCursorKindCXXOverrideAttr = CXCursor_CXXOverrideAttr,
             CKCursorKindAnnotateAttr = CXCursor_AnnotateAttr,
             CKCursorKindAsmLabelAttr = CXCursor_AsmLabelAttr,
             CKCursorKindLastAttr = CXCursor_LastAttr,
             CKCursorKindPreprocessingDirective = CXCursor_PreprocessingDirective,
             CKCursorKindMacroDefinition = CXCursor_MacroDefinition,
             CKCursorKindMacroExpansion = CXCursor_MacroExpansion,
             CKCursorKindMacroInstantiation = CXCursor_MacroInstantiation,
             CKCursorKindInclusionDirective = CXCursor_InclusionDirective,
             CKCursorKindFirstPreprocessing = CXCursor_FirstPreprocessing,
             CKCursorKindLastPreprocessing = CXCursor_LastPreprocessing;

@implementation CKCursor
{
@protected
//
//    CKCursorKind       _kind;
//    NSString         * _displayName;
//    NSString         * _kindSpelling;
    CKCursor         * _definition;
    CKCursor         * _semanticParent;
    CKCursor         * _lexicalParent;
    CKCursor         * _canonical;
    CKCursor         * _referenced;
//    CKSourceLocation * _location;
//    BOOL               _isDefinition;
//    BOOL               _isDeclaration;
//    BOOL               _isReference;
//    BOOL               _isPreprocessing;
//    BOOL               _isExpression;
//    BOOL               _isAttribute;
//    BOOL               _isInvalid;
//    BOOL               _isStatement;
//    BOOL               _isTranslationUnit;
//    BOOL               _isUnexposed;
    void             * _cxCursorPointer;
}


@synthesize kind = _kind, displayName = _displayName, kindSpelling = _kindSpelling, location = _location, isDefinition = _isDefinition, isDeclaration = _isDeclaration, isReference = _isReference, isPreprocessing = _isPreprocessing, isExpression = _isExpression, isAttribute = _isAttribute, isInvalid = _isInvalid, isStatement = _isStatement, isTranslationUnit = _isTranslationUnit, isUnexposed = _isUnexposed;

+ (instancetype)cursorWithLocation:(CKSourceLocation*)location translationUnit:(CKTranslationUnit*)translationUnit {
  return [self.alloc
    initWithLocation:location
     translationUnit:translationUnit];
}

- (instancetype)initWithLocation:(CKSourceLocation*)location translationUnit:(CKTranslationUnit*)translationUnit {
  CXSourceLocation sourceLocation;
  CXCursor cursor;

  sourceLocation.ptr_data[0] = location.ptrData1;
  sourceLocation.ptr_data[1] = location.ptrData2;
  sourceLocation.int_data = location.intData;

  cursor = clang_getCursor(translationUnit.cxTranslationUnit, sourceLocation);

  return [self initWithCXCursor:cursor];
}

- (void)dealloc {

  free(_cxCursorPointer);
}

- (NSString*)description {
  NSString* description;

  description = [super description];
  description = [description stringByAppendingFormat:@": %@ - %@", self.kindSpelling, self.displayName];

  return description;
}

- (CKCursor*)referenced {
  CXCursor cursor;
  CXCursor referenced;

  if (_referenced == nil && _cxCursorPointer != NULL && _isDefinition == NO) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    referenced = clang_getCursorReferenced(cursor);

    if (clang_equalCursors(cursor, referenced) == 0) {
      _referenced = [[[self class] alloc] initWithCXCursor:referenced];
    }
  }

  return _referenced;
}

- (CKCursor*)definition {
  CXCursor cursor;
  CXCursor definition;

  if (_definition == nil && _cxCursorPointer != NULL && _isDefinition == NO) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    definition = clang_getCursorDefinition(cursor);

    if (clang_Cursor_isNull(definition) == 0)
      _definition = [[[self class] alloc] initWithCXCursor:definition];
  }

  return _definition;
}

- (CKCursor*)canonical {
  CXCursor cursor;
  CXCursor canonical;

  if (_canonical == nil && _cxCursorPointer != NULL) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    canonical = clang_getCanonicalCursor(cursor);
    _canonical = [[[self class] alloc] initWithCXCursor:canonical];
  }

  return _canonical;
}

- (CKCursor*)lexicalParent {
  CXCursor cursor;
  CXCursor lexicalParent;

  if (_referenced == nil && _cxCursorPointer != NULL) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    lexicalParent = clang_getCursorReferenced(cursor);
    _lexicalParent = [[[self class] alloc] initWithCXCursor:lexicalParent];
  }

  return _referenced;
}

- (CKCursor*)semanticParent {
  CXCursor cursor;
  CXCursor semanticParent;

  if (_semanticParent == nil && _cxCursorPointer != NULL) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    semanticParent = clang_getCursorReferenced(cursor);
    _semanticParent = [[[self class] alloc] initWithCXCursor:semanticParent];
  }

  return _semanticParent;
}

#define AMI(X) - (BOOL) X { static dispatch_once_t o; dispatch_once(&o, ^{ _##X = clang_##X ((enum CXCursorKind)_kind); }); return _##X; }

AMI(isDeclaration)
AMI(isReference)

AMI(isPreprocessing)
AMI(isExpression)
AMI(isAttribute)
AMI(isInvalid)
AMI(isStatement)
AMI(isTranslationUnit)
AMI(isUnexposed)

// Private

- initWithCXCursor:(CXCursor)cursor {

  CXString displayName;
  CXString kindSpelling;
  CXSourceLocation location;

  if ((self = [self init])) {
    if (clang_Cursor_isNull(cursor)) {

      return nil;
    }

    _cxCursorPointer = calloc(sizeof(CXCursor), 1);

    memcpy(_cxCursorPointer, &cursor, sizeof(CXCursor));

    _kind = clang_getCursorKind(cursor);
    displayName = clang_getCursorDisplayName(cursor);
    kindSpelling = clang_getCursorKindSpelling((enum CXCursorKind)_kind);
    _displayName = [NSString.alloc initWithCString:clang_getCString(displayName) encoding:NSUTF8StringEncoding];
    _kindSpelling = [NSString.alloc initWithCString:clang_getCString(kindSpelling) encoding:NSUTF8StringEncoding];
    location = clang_getCursorLocation(cursor);
    _location = [CKSourceLocation.alloc initWithPointerData1:(void*)location.ptr_data[0] pointerData2:(void*)location.ptr_data[1] intData:location.int_data];

    if (clang_isCursorDefinition(cursor)) _isDefinition = YES;

    [self definition];
    [self referenced];

//    _isDeclaration    = clang_isDeclaration((enum CXCursorKind)_kind);
//    _isReference      = clang_isReference((enum CXCursorKind)_kind);
//    _isPreprocessing  = clang_isPreprocessing((enum CXCursorKind)_kind);
//    _isExpression     = clang_isExpression((enum CXCursorKind)_kind);
//
//    if (clang_isAttribute((enum CXCursorKind)_kind)) {
//      _isAttribute = YES;
//    }
//    if (clang_isInvalid((enum CXCursorKind)_kind)) {
//      _isInvalid = YES;
//    }
//    if (clang_isStatement((enum CXCursorKind)_kind)) {
//      _isStatement = YES;
//    }
//    if (clang_isTranslationUnit((enum CXCursorKind)_kind)) {
//      _isTranslationUnit = YES;
//    }
//    if (clang_isUnexposed((enum CXCursorKind)_kind)) {
//      _isUnexposed = YES;
//    }
  }

  return self;
}



@end
