
/*!
	@file            main.m
	@copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author          Jean-David Gadina - www.xs-labs.com
	@abstract        ClangKit test / demo project
 */

@import ClangKit;
@import ToolKit;

#define TEST @"@implementation CKFixIt\
\
@synthesize string = _string, range  = _range;\
\
+ (NSArray *)fixItsForDiagnostic: (CKDiagnostic *)diagnostic\
{\
    unsigned int     i;\
    unsigned int     n;\
    NSMutableArray * fixIts;\
    CKFixIt        * fixIt;\
    \
    n      = clang_getDiagnosticNumFixIts(diagnostic.cxDiagnostic);\
    fixIts = [ NSMutableArray arrayWithCapacity: n ];\
    \
    for(i = 0; i < n; i++)\
    {\
        fixIt = [ self fixItWithDiagnostic: diagnostic index: i ];\
        \
        if(fixIt != nil)\
        {\
            [ fixIts addObject: fixIt ];\
        }\
    }\
    \
    return [ NSArray arrayWithArray: fixIts ];\
}\
@end"


int main() {

  @autoreleasepool {


  [IO getOpt:@"Output tokens from source file.", @"tokenize", @"t", nil];
  [IO.getOpts echo];

  id tokenize = IO.getOpts[@"tokenize"];
  if (tokenize) {
      for (id x in tokenize)
      {
//        CKTranslationUnit* tu = [CKTranslationUnit translationUnitWithText:TEST language:CKLanguageObjC];
        CKTranslationUnit* tu = [CKTranslationUnit translationUnitWithPath:@"/tmp/testfile.m"];

        [tu.tokens echo];
      }
    return 0;
  }
  
  id soSimple = @"int main( void) { return 0; }";
  id better = //[NSString stringWithContentsOfFile:@"/Volumes/2T/ServiceData/git/gister/gister.m" encoding:
    @"@import ToolKit;";

//  NSUTF8StringEncoding error:nil];

  id args = @[@"-std=c11", @"-fmodules", @"-framework", @"ToolKit", @"-F/Users/localadmin/Library/Frameworks", @"-Weverything"];

//  @"-E", @"-x", @"objective-c",
    /* First create a translation unit for Objective-C, using a string */
    CKTranslationUnit* tu = [CKTranslationUnit translationUnitWithText:better
                                                              language:CKLanguageObjC
                                                                  args:args];
    //@[@"-fmodules", @"-@"-Weverything"]];

    /* Logs each diagnostic and fix-its */
    for (CKDiagnostic* d in tu.diagnostics) {
      NSLog(@"Diagnostic: %@", d);
      NSLog(@"FixIts: %@", d.fixIts);
    }

    /* Logs the available tokens */
    NSLog(@"%@", tu.tokens);

    /* Changes the code, using the 'text' property */
    tu.text = TEST;

    /* Logs each diagnostic and fix-its */
    for (CKDiagnostic *d in tu.diagnostics)
      NSLog(@"Diagnostic: %@\nFixIts: %@", d, d.fixIts);

    /* Logs the available tokens */
    NSLog(@"%@", tu.tokens);

    /* Changes the code, using the 'text' property */
    tu.text = @"@import AppKit;\n@imp";

     [tu reparse];
    for (NSUInteger i = 1; i < 10; i++) {
      id x = [tu completionResultsForLine:1 column:i];
      printf("completionResultsForLine2,%lu\n\n%lu\n", i, [[x valueForKey:@"chunks"] count]);//description].UTF8String);
    }
//    @"/Volumes/2T/ServiceData/git/Codeine.2015/ClangKit/ClangKit/Classes/CKFixIt.m";
#define NSSS @"/System/Library/Frameworks/Foundation.framework/Headers/NSString."
//#define ATOZ  @"/a2z/AtoZ/AtoZ.m".stringByResolvingSymlinksInPath
    tu = [CKTranslationUnit translationUnitWithPath:NSSS

     args:@[@"-fmodules", @"-stc=c11", @"-framework", @"AtoZ", @"-F/Users/localadmin/Library/Frameworks"]];

    NSLog(@"%@", tu.tokens);
  }

  return 0;
}
