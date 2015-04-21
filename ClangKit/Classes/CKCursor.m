
/* $Id$ */

#import "CKCursor.h"
#import "CKSourceLocation.h"
#import "CKTranslationUnit.h"

JREnumDefine(CKCursorKind);

@implementation CKCursor
{
@protected
  CKCursor         * _definition, * _semanticParent, * _lexicalParent,* _canonical,* _referenced;
  void             * _cxCursorPointer;

//    CKCursorKind       _kind; NSString         * _displayName, * _kindSpelling; CKSourceLocation * _location;
//    BOOL               _isDefinition,_isDeclaration,_isReference,_isPreprocessing,_isExpression,_isAttribute,_isInvalid,_isStatement,_isTranslationUnit;, _isUnexposed;
}

@synthesize kind = _kind, displayName = _displayName, kindSpelling = _kindSpelling, location = _location, isDefinition = _isDefinition, isDeclaration = _isDeclaration, isReference = _isReference, isPreprocessing = _isPreprocessing, isExpression = _isExpression, isAttribute = _isAttribute, isInvalid = _isInvalid, isStatement = _isStatement, isTranslationUnit = _isTranslationUnit, isUnexposed = _isUnexposed;

+ (instancetype)cursorWithLocation:(CKSourceLocation*)location translationUnit:(CKTranslationUnit*)translationUnit {
  return [self.alloc initWithLocation:location translationUnit:translationUnit];
}

- (instancetype)initWithLocation:(CKSourceLocation*)location translationUnit:(CKTranslationUnit*)translationUnit {
  CXSourceLocation sourceLocation;

  sourceLocation.ptr_data[0] = location.ptrData1;
  sourceLocation.ptr_data[1] = location.ptrData2;
  sourceLocation.int_data = location.intData;

  CXCursor cursor = clang_getCursor(translationUnit.cxTranslationUnit, sourceLocation);

  return [self initWithCXCursor:cursor];
}

- (void)dealloc {

  free(_cxCursorPointer);
}

- (NSString*)description {

  return [super.description withFormat:@": %@ - %@", self.kindSpelling, self.displayName];
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

- (CKCursor*)canonical { CXCursor cursor,canonical;

  if (!_canonical && _cxCursorPointer) { memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    canonical = clang_getCanonicalCursor(cursor);
    _canonical = [self.class.alloc initWithCXCursor:canonical];
  }

  return _canonical;
}

- (CKCursor*)lexicalParent { CXCursor cursor, lexicalParent;

  if (!_referenced && _cxCursorPointer) { memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    lexicalParent = clang_getCursorReferenced(cursor);
    _lexicalParent = [self.class.alloc initWithCXCursor:lexicalParent];
  }

  return _referenced;
}

- (CKCursor*)semanticParent { CXCursor cursor,semanticParent;

  if (_semanticParent == nil && _cxCursorPointer != NULL) {
    memcpy(&cursor, _cxCursorPointer, sizeof(CXCursor));

    semanticParent = clang_getCursorReferenced(cursor);
    _semanticParent = [[[self class] alloc] initWithCXCursor:semanticParent];
  }

  return _semanticParent;
}

#define AMI(X) - (BOOL) X { static dispatch_once_t o; dispatch_once(&o, ^{ _##X = clang_##X ((enum CXCursorKind)_kind); }); return _##X; }

AMI(isDeclaration)  AMI(isReference)  AMI(isPreprocessing)
AMI(isExpression)   AMI(isAttribute)  AMI(isInvalid)
AMI(isStatement)    AMI(isUnexposed)  AMI(isTranslationUnit)

// Private

- initWithCXCursor:(CXCursor)cursor { SUPERINIT;

  CXString displayName, kindSpelling;  CXSourceLocation location;

  if (clang_Cursor_isNull(cursor)) return nil;

  _cxCursorPointer = calloc(sizeof(CXCursor), 1);

  memcpy(_cxCursorPointer, &cursor, sizeof(CXCursor));

  _kind         = clang_getCursorKind(cursor);
  displayName   = clang_getCursorDisplayName(cursor);
  kindSpelling  = clang_getCursorKindSpelling((enum CXCursorKind)_kind);
  _displayName  = $UTF8(clang_getCString(displayName));
  _kindSpelling = $UTF8(clang_getCString(kindSpelling));
  location      = clang_getCursorLocation(cursor);
  _location     = [CKSourceLocation.alloc initWithPointerData1:(void*)location.ptr_data[0]
                                                  pointerData2:(void*)location.ptr_data[1]
                                                       intData:location.int_data];

  if (clang_isCursorDefinition(cursor)) _isDefinition = YES;

  [self definition];
  [self referenced];

  return self;
}

@end

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


