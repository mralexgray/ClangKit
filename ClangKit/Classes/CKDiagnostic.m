
/* $Id$ */

#import "CKDiagnostic.h"
//#import "CKDiagnostic+Private.h"
#import "CKTranslationUnit.h"

#import "CKFixIt.h" /// private needs

CKDiagnosticSeverity CKDiagnosticSeverityIgnored = CXDiagnostic_Ignored;
CKDiagnosticSeverity CKDiagnosticSeverityNote = CXDiagnostic_Note;
CKDiagnosticSeverity CKDiagnosticSeverityWarning = CXDiagnostic_Warning;
CKDiagnosticSeverity CKDiagnosticSeverityError = CXDiagnostic_Error;
CKDiagnosticSeverity CKDiagnosticSeverityFatal = CXDiagnostic_Fatal;

@implementation CKDiagnostic

@synthesize cxDiagnostic = _cxDiagnostic;
@synthesize spelling = _spelling;
@synthesize severity = _severity;
@synthesize fixIts = _fixIts;
@synthesize line = _line;
@synthesize column = _column;
@synthesize range = _range;

+ (NSArray*)diagnosticsForTranslationUnit:(CKTranslationUnit*)translationUnit {
  unsigned int numDiagnostics;
  unsigned int i;
  NSMutableArray* diagnostics;
  CKDiagnostic* diagnostic;

  numDiagnostics = clang_getNumDiagnostics(translationUnit.cxTranslationUnit);
  diagnostics = [NSMutableArray arrayWithCapacity:(NSUInteger)numDiagnostics];

  for (i = 0; i < numDiagnostics; i++) {
    diagnostic = [CKDiagnostic diagnosticWithTranslationUnit:translationUnit index:i];

    if (diagnostic != nil) {
      [diagnostics addObject:diagnostic];
    }
  }

  return [NSArray arrayWithArray:diagnostics];
}

+ (instancetype)diagnosticWithTranslationUnit:(CKTranslationUnit*)translationUnit index:(NSUInteger)index {
  return [[self.alloc 
         initWithTranslationUnit:(CKTranslationUnit*)translationUnit index:index] autorelease];
}

- (instancetype)initWithTranslationUnit:(CKTranslationUnit*)translationUnit index:(NSUInteger)index {
  if ((self = [self _initWithCXDiagnostic:clang_getDiagnostic(translationUnit.cxTranslationUnit, (unsigned int)index) translationUnit:translationUnit])) {
  }

  return self;
}

- (void)dealloc {
  clang_disposeDiagnostic(_cxDiagnostic);

  [_fixIts release];
  [_spelling release];

  [super dealloc];
}

- (NSString*)description {
  NSString* description;
  NSString* severity;

  if (self.severity == CKDiagnosticSeverityError) {
    severity = @"Error";
  } else if (self.severity == CKDiagnosticSeverityFatal) {
    severity = @"Fatal";
  } else if (self.severity == CKDiagnosticSeverityIgnored) {
    severity = @"Ignored";
  } else if (self.severity == CKDiagnosticSeverityNote) {
    severity = @"Note";
  } else if (self.severity == CKDiagnosticSeverityWarning) {
    severity = @"Warning";
  } else {
    severity = @"Unknown";
  }

  description = [super description];
  description = [description stringByAppendingFormat:@": %@[%lu:%lu] - %@",
                                                     severity,
                                                     (unsigned long)(self.line),
                                                     (unsigned long)(self.column),
                                                     self.spelling];

  return description;
}

- (id)_initWithCXDiagnostic:(CXDiagnostic)diagnostic translationUnit:(CKTranslationUnit*)translationUnit {
  CXString spelling;
  CXSourceLocation location;
  CXSourceRange range;
  unsigned int line;
  unsigned int column;
  unsigned int offset;

  if ((self = [self init])) {
    if (diagnostic == NULL) {
      [self release];

      return nil;
    }

    _cxDiagnostic = diagnostic;
    spelling = clang_getDiagnosticSpelling(_cxDiagnostic);
    _spelling =[NSString.alloc 
         initWithCString:clang_getCString(spelling) encoding:NSUTF8StringEncoding];
    _severity = clang_getDiagnosticSeverity(_cxDiagnostic);

    clang_disposeString(spelling);

    location = clang_getDiagnosticLocation(diagnostic);
    range = clang_getDiagnosticRange(diagnostic, 0);

    clang_getExpansionLocation(location, translationUnit.cxFile, &line, &column, &offset);

    _line = (NSUInteger)line;
    _column = (NSUInteger)column;
    _range = NSMakeRange((NSUInteger)offset, range.end_int_data - range.begin_int_data);

    _fixIts = [[CKFixIt fixItsForDiagnostic:self] retain];
  }

  return self;
}

@end
