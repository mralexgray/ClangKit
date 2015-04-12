
/* $Id$ */

#import "CKTranslationUnit.h"
#import "CKIndex.h"
#import "CKDiagnostic.h"
#import "CKToken.h"
#import "CKCompletionResult.h"

@implementation CKTranslationUnit
{
@protected

//  NSString//* _path,
//  * _text;
//  struct CXTranslationUnitImpl * _cxTranslationUnit;
//  CKIndex* _index;
//  char** _args;
  const char **_args;

  int _numArgs;
  NSArray* _diagnostics;
  NSArray* _tokens;
  void* _tokensPointer;
  void* _unsavedFile;
  NSLock* _lock;
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
  NSString* extension;
  NSString* tempFileName;
  NSString* tempFile;
  char buffer[40];

  uuid = CFUUIDCreate(kCFAllocatorDefault);
  uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid);

  memset(buffer, 0, 40);
  CFStringGetCString(uuidString, buffer, 40, kCFStringEncodingUTF8);

  switch (language) {
    case CKLanguageC:
      extension = @".c";
      break;
    case CKLanguageCPP:
      extension = @".cpp";
      break;
    case CKLanguageObjC:
      extension = @".m";
      break;
    case CKLanguageObjCPP:
      extension = @".mm";
      break;
    case CKLanguageNone:
      extension = @"";
      break;
    default:
      extension = @"";
      break;
  }

  tempFileName = [NSString stringWithFormat:@"ClangKit-%s%@", buffer, extension];
  tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:tempFileName];

  CFRelease(uuid);
  CFRelease(uuidString);

  return  mkstemp((char*)(tempFile.fileSystemRepresentation)) == -1 ? nil :

              [self initWithPath:tempFile text:text index:index args:args];
}

- (void)dealloc {
  int i;

  if (_tokens.count > 0)
    clang_disposeTokens(_cxTranslationUnit, _tokensPointer, (unsigned int)_tokens.count);

  clang_disposeTranslationUnit(_cxTranslationUnit);

//  for (i = 0; i < _numArgs; i++) free((void*)_args[i]);

  free((void*)_args);

  if (_unsavedFile != NULL) {
//    [[NSFileManager defaultManager] removeItemAtPath:_path error:NULL];

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

- (NSArray*)diagnostics {


//  @synchronized(self) {

    return _diagnostics = // ?: ({
//      [_lock lock];

      _diagnostics ?: !self ? nil : [CKDiagnostic diagnosticsForTranslationUnit:self];

//      [_lock unlock];

//    }), _diagnostics;
//  }
}

- (NSArray*)tokens {
//  @synchronized(self) {
//    return _tokens ?: ({
//      [_lock lock];

      return _tokens = _tokens ?: !self ? nil : [CKToken tokensForTranslationUnit:self tokens:&_tokensPointer];
//
//      [_lock unlock];

//    }), _tokens;
//  }
}

//- (NSString*)text {
//  @synchronized(self) {
//    return _text;
//  }
//}

- (void)setText:(NSString*)text {

  @synchronized(self) {

    _unsavedFile = _unsavedFile ?: calloc(sizeof(struct CXUnsavedFile), 1);

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
  @synchronized(self) {
    return clang_getFile(_cxTranslationUnit, _path.fileSystemRepresentation);
  }
}

- (NSString*)description {
  NSString* description;

  description = [super description];
  description = [description stringByAppendingFormat:@"%@", self.path];

  return description;
}

- (NSArray*)completionResultsForLine:(NSUInteger)line column:(NSUInteger)column {
  NSMutableArray* array;
  CXCodeCompleteResults* results;
  unsigned i;
  CXCompletionResult result;
  CKCompletionResult* completionResult;

  [_lock lock];

  if (_unsavedFile != NULL) {
    ((struct CXUnsavedFile*)_unsavedFile)->Filename = _path.fileSystemRepresentation;
    ((struct CXUnsavedFile*)_unsavedFile)->Contents = _text.UTF8String;
    ((struct CXUnsavedFile*)_unsavedFile)->Length = _text.length;
  }

  results = clang_codeCompleteAt(
    _cxTranslationUnit,
    _path.fileSystemRepresentation,
    (unsigned int)line,
    (unsigned int)column,
    _unsavedFile,
    (_unsavedFile == NULL) ? 0 : 1,
    clang_defaultCodeCompleteOptions());

  if (results == NULL) {
    [_lock unlock];

    return nil;
  }

  array = [NSMutableArray arrayWithCapacity:(NSUInteger)(results->NumResults)];

  for (i = 0; i < results->NumResults; i++) {
    result = results->Results[i];
    completionResult = [CKCompletionResult completionResultWithCXCompletionString:result.CompletionString cursorKind:(CKCursorKind)result.CursorKind];

    if (completionResult != nil) {
      [array addObject:completionResult];
    }
  }

  clang_disposeCodeCompleteResults(results);

  [_lock unlock];

  return [NSArray arrayWithArray:array];
}

// PRIVATE

- (id)initWithPath:(NSString*)path text:(NSString*)text index:(CKIndex*)index args:(NSArray*)args {
  NSUInteger i;
  id arg;

  if ((self = [self init])) {
    _lock = [NSLock new];
    _path = [path copy];
    _index = (index == nil) ? [CKIndex new] : index;

    if (text == nil) {
      _text = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:NULL];

      if (!_text.length) return nil;

    } else {
      _text = text;
      if ((_unsavedFile = calloc(sizeof(struct CXUnsavedFile), 1)) == NULL) return nil;

      [_text writeToFile:_path atomically:YES encoding:NSUTF8StringEncoding  error:nil];

      ((struct CXUnsavedFile*)_unsavedFile)->Filename = _path.fileSystemRepresentation;
      ((struct CXUnsavedFile*)_unsavedFile)->Contents = _text.UTF8String;
      ((struct CXUnsavedFile*)_unsavedFile)->Length = _text.length;
    }

    if (args.count) {

      if ((_args =  (const char**)calloc(sizeof(const char*), args.count)) == NULL) return nil;

      i = 0;

      printf("args: %s\n", [args description].UTF8String);
      
      for (arg in args) {

        if (![arg isKindOfClass:NSString.class]) continue;

        _args[i] = [arg UTF8String];

        // calloc(sizeof(char), strlen(((NSString*)arg).UTF8String) + 1);

        if (_args[i] == NULL) return nil;

//        strlcpy((char*)_args[i], ((NSString*)arg).UTF8String, strlen(((NSString*)arg).UTF8String) + 1);

        i++;

        _numArgs = (int)i;
      }
    }

    _cxTranslationUnit = clang_parseTranslationUnit(
      _index.cxIndex,
      _path.fileSystemRepresentation,
      (const char* const*)_args,
      _numArgs,
      _unsavedFile,
      _unsavedFile != NULL,
      clang_defaultEditingTranslationUnitOptions() |
      CXTranslationUnit_DetailedPreprocessingRecord |
      CXTranslationUnit_PrecompiledPreamble |
      CXTranslationUnit_CacheCompletionResults |
      CXTranslationUnit_Incomplete);

    if (_cxTranslationUnit == NULL) return nil;

//    [self tokens];
//    [self diagnostics];
  }

  return self;
}

@end
