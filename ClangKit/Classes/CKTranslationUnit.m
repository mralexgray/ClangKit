
/* $Id$ */

#import "CKTranslationUnit.h"
#import "CKIndex.h"
#import "CKDiagnostic.h"
#import "CKToken.h"
#import "CKCompletionResult.h"

@implementation CKTranslationUnit
{
@protected

//  NSString//* _path, * _text; struct CXTranslationUnitImpl * _cxTranslationUnit; CKIndex* _index; char** _args;
  const char **_args;
        int    _numArgs;
        
  _List    _diagnostics,     _tokens;
  _Void  * _tokensPointer, * _unsavedFile;
  NSLock * _lock;
}

@synthesize path = _path, cxTranslationUnit = _cxTranslationUnit, index = _index;

+ (instancetype)translationUnitWithPath:(NSString*)path {
  return [self.alloc initWithPath:path];
}

+ (instancetype)translationUnitWithPath:(NSString*)path index:(CKIndex*)index {
  return [self.alloc initWithPath:path index:index];
}

+ (instancetype)translationUnitWithPath:(NSString*)path args:(NSArray*)args {
  return [self.alloc initWithPath:path args:args];
}

+ (instancetype)translationUnitWithPath:(NSString*)path index:(CKIndex*)index args:(NSArray*)args {
  return [self.alloc initWithPath:path index:index args:args];
}

+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language {
  return [self.alloc initWithText:text language:language];
}

+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index {
  return [self.alloc initWithText:text language:language index:index];
}

+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language args:(NSArray*)args {
  return [self.alloc initWithText:text language:language args:args];
}

+ (instancetype)translationUnitWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index args:(NSArray*)args {
  return [self.alloc initWithText:text language:language index:index args:args];
}

- (instancetype)initWithPath:(NSString*)path {
  return [self initWithPath:path index:nil args:nil];
}

- (instancetype)initWithPath:(NSString*)path index:(CKIndex*)index {
  return [self initWithPath:path index:index args:nil];
}

- (instancetype)initWithPath:(NSString*)path args:(NSArray*)args {
  return [self initWithPath:path index:nil args:args];
}

- (instancetype)initWithPath:(NSString*)path index:(CKIndex*)index args:(NSArray*)args {
  return [self initWithPath:path text:nil index:index args:args];
}

- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language {
  return [self initWithText:text language:language index:nil args:nil];
}

- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index {
  return [self initWithText:text language:language index:index args:nil];
}

- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language args:(NSArray*)args {
  return [self initWithText:text language:language index:nil args:args];
}

- (instancetype)initWithText:(NSString*)text language:(CKLanguage)language index:(CKIndex*)index args:(NSArray*)args {
  CFUUIDRef uuid;
  CFStringRef uuidString;
  char buffer[40];

  uuid = CFUUIDCreate(kCFAllocatorDefault);
  uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid);

  memset(buffer, 0, 40);
  CFStringGetCString(uuidString, buffer, 40, kCFStringEncodingUTF8);

  NSString* extension =
  language == CKLanguageC ? @".c" :
  language == CKLanguageCPP ? @".cpp" :
  language == CKLanguageObjC ? @".m" :
  language == CKLanguageObjCPP ? @".mm" :
  language == CKLanguageNone ? @"" : @"";


  _Text tempFile = [NSTemporaryDirectory() withPath:$(@"ClangKit-%s%@", buffer, extension)];

  CFRelease(uuid);
  CFRelease(uuidString);

  return  mkstemp((char*)(tempFile.fileSystemRepresentation)) == -1 ? nil :

              [self initWithPath:tempFile text:text index:index args:args];
}

- (void)dealloc {

  int i;

  if (_tokens.count > 0) clang_disposeTokens(_cxTranslationUnit, _tokensPointer, (unsigned int)_tokens.count);

  clang_disposeTranslationUnit(_cxTranslationUnit);

//  for (i = 0; i < _numArgs; i++) free((void*)_args[i]);

  free((void*)_args);

  if (_unsavedFile != NULL) {

//    [FM removeItemAtPath:_path error:NULL];
    free(_unsavedFile);
  }
}

- (void)reparse {

  @synchronized(self) {
    [_lock lock];

    if (_tokens.count > 0) {
      clang_disposeTokens(_cxTranslationUnit, _tokensPointer, (unsigned int)_tokens.count);

      _tokensPointer = NULL;
    }

    _tokens = nil;
    _diagnostics = nil;

    clang_reparseTranslationUnit(
      _cxTranslationUnit,
      (_unsavedFile == NULL) ? 0 : 1,
      _unsavedFile,
      clang_defaultReparseOptions(_cxTranslationUnit) | CXTranslationUnit_DetailedPreprocessingRecord | CXTranslationUnit_PrecompiledPreamble | CXTranslationUnit_CacheCompletionResults | CXTranslationUnit_Incomplete);

    [_lock unlock];

//    [self tokens];
//    [self diagnostics];
  }
}

- (NSArray*)diagnostics { return _diagnostics = _diagnostics ?: [CKDiagnostic diagnosticsForTranslationUnit:self]; }

//  @synchronized(self) { if (_diagnostics == nil) { [_lock lock]; [_lock unlock]; } return _diagnostics; } }

- (NSArray*)tokens { return _tokens = _tokens ?: [CKToken tokensForTranslationUnit:self tokens:&_tokensPointer]; }

//  @synchronized(self) { if (_tokens == nil) { [_lock lock]; _tokens = ; [_lock unlock]; } return _tokens; } }

//- (NSString*)text { @synchronized(self) { return _text; } }

- (void)setText:(NSString*)text {
  @synchronized(self) {
    if (_unsavedFile == NULL) {
      _unsavedFile = calloc(sizeof(struct CXUnsavedFile), 1);
    }

    if (_unsavedFile != NULL) {
      if (_text != text) {

        _text = text;
      }
      @try {
        ((struct CXUnsavedFile*)_unsavedFile)->Filename = _path.fileSystemRepresentation;
        ((struct CXUnsavedFile*)_unsavedFile)->Contents = _text.UTF8String;
        ((struct CXUnsavedFile*)_unsavedFile)->Length = _text.length;

        [self reparse];
      }
      @catch (NSException* e) {
        (void)e;
      }
    }
  }
}

- (CXFile)cxFile {

  @synchronized(self) { return clang_getFile(_cxTranslationUnit, _path.fileSystemRepresentation); }
}

- (NSString*)description { return [super.description withString:self.path]; }

- (NSArray*)completionResultsForLine:(NSUInteger)line column:(NSUInteger)column {

  CXCodeCompleteResults* results;
  unsigned i;

  [_lock lock];

  if (_unsavedFile != NULL) {
    ((struct CXUnsavedFile*)_unsavedFile)->Filename = _path.fileSystemRepresentation;
    ((struct CXUnsavedFile*)_unsavedFile)->Contents = _text.UTF8String;
    ((struct CXUnsavedFile*)_unsavedFile)->Length = _text.length;
  }

  results = clang_codeCompleteAt( _cxTranslationUnit, _path.fileSystemRepresentation,
                                (unsigned int)line,
                                (unsigned int)column,
                                _unsavedFile,
                                _unsavedFile == NULL ? 0 : 1, clang_defaultCodeCompleteOptions());

  if (results == NULL) return [_lock unlock], nil;

  NSMutableArray* array = @[].mC; // [NSMutableArray arrayWithCapacity:(NSUInteger)(results->NumResults)];

  for (i = 0; i < results->NumResults; i++) {

    CXCompletionResult result = results->Results[i];

    CKCompletionResult* completionResult = [CKCompletionResult completionResultWithCXCompletionString:result.CompletionString cursorKind:(CKCursorKind)result.CursorKind];

    if (!!completionResult) [array addObject:completionResult];
  }

  clang_disposeCodeCompleteResults(results);

  [_lock unlock];

  return array.copy;
}

// PRIVATE

- initWithPath:(NSString*)path text:(NSString*)text index:(CKIndex*)index args:(NSArray*)args { SUPERINIT;

  NSUInteger i; id arg;


  _lock = [NSLock new];
  _path = path.copy;
  _index = index ?: CKIndex.new;

  if (!text &&
    !(_text = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:NULL]).length)
      return nil;

  else {

    _text = text;
    if ((_unsavedFile = calloc(sizeof(struct CXUnsavedFile), 1)) == NULL) return nil;

    ((struct CXUnsavedFile*)_unsavedFile)->Filename = _path.fileSystemRepresentation;
    ((struct CXUnsavedFile*)_unsavedFile)->Contents = _text.UTF8String;
    ((struct CXUnsavedFile*)_unsavedFile)->Length = _text.length;
  }

  if (args.count > 0) {

    if ((_args = (const char**)calloc(sizeof(char*), args.count)) == NULL) return nil;

    i = 0;

    for (arg in args) {

      if (![arg isKindOfClass:NSString.class]) continue;

      if ((_args[i] = calloc(sizeof(char), strlen(((NSString*)arg).UTF8String) + 1)) == NULL) return nil;

      strlcpy((char*)_args[i], ((NSString*)arg).UTF8String, strlen(((NSString*)arg).UTF8String) + 1);

      i++;

      _numArgs = (int)i;
    }
  }
  _cxTranslationUnit = clang_parseTranslationUnit( _index.cxIndex, _path.fileSystemRepresentation,
                                                 (const char* const*)_args, _numArgs,
                                                  _unsavedFile,
                                                  _unsavedFile == NULL ? 0 : 1,
                                                  clang_defaultEditingTranslationUnitOptions()  |
                                                  CXTranslationUnit_DetailedPreprocessingRecord |
                                                  CXTranslationUnit_PrecompiledPreamble         |
                                                  CXTranslationUnit_CacheCompletionResults      |
                                                  CXTranslationUnit_Incomplete);

  if (_cxTranslationUnit == NULL) return nil;

//  [self tokens];
//  [self diagnostics];
  return self;
}

@end
