
/*!
 * @file            main.m
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit test / demo project
 */

@import ClangKit;

int main() {
  @autoreleasepool {

  id soSimple = @"int main( void ) { return 0; }";
  id better = //[NSString stringWithContentsOfFile:@"/Volumes/2T/ServiceData/git/gister/gister.m" encoding:
    @"@import AtoZIO; \n int main( void ) { return 0; }\n\n";

//  NSUTF8StringEncoding error:nil];

  id args = @[@"-std=c11", @"-fmodules", @"-framework", @"AtoZIO", @"-F/Users/localadmin/Library/Frameworks", @"-Weverything"];

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

    /* Changes the code, using the 'text' property
    tu.text = @"#import <Foundation/Foundation.h>\n"
      @"\n"
      @"@interface Foo: NSObject\n"
      @"{}\n"
      @"@end\n"
      @"\n"
      @"int main( void )\n"
      @"{\n"
      @"    NSString * x;\n"
      @"    Foo      * f;\n"
      @"    \n"
      @"return 1;\n"
      @"}\n";
    */
    /* Logs each diagnostic and fix-its */
    for (CKDiagnostic *d in tu.diagnostics)
      NSLog(@"Diagnostic: %@\nFixIts: %@", d, d.fixIts);

    /* Logs the available tokens */
    NSLog(@"%@", tu.tokens);

    /* Changes the code, using the 'text' property */
//    tu.text = @"@import AppKit;\n@imp";

//     [tu reparse];
//    for (NSUInteger i = 1; i < 10; i++) {
//      id x = [tu completionResultsForLine:1 column:i];
//      printf("completionResultsForLine2,%lu\n\n%lu\n", i, [[x valueForKey:@"chunks"] count]);//description].UTF8String);
//    }
//    @"/Volumes/2T/ServiceData/git/Codeine.2015/ClangKit/ClangKit/Classes/CKFixIt.m";
#define NSSS @"/System/Library/Frameworks/Foundation.framework/Headers/NSString."
//#define ATOZ  @"/a2z/AtoZ/AtoZ.m".stringByResolvingSymlinksInPath
    tu = [CKTranslationUnit translationUnitWithPath:NSSS

     args:@[@"-fmodules", @"-stc=c11", @"-framework", @"AtoZ", @"-F/Users/localadmin/Library/Frameworks"]];

    NSLog(@"%@", tu.tokens);
  }

  return 0;
}
