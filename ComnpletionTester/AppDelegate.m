//
//  AppDelegate.m
//  ComnpletionTester
//
//  Created by Alex Gray on 3/30/15.
//  Copyright (c) 2015 XS-Labs. All rights reserved.
//

#import "AppDelegate.h"
@import ClangKit;

@interface AppDelegate ()
@property    CKTranslationUnit * tu;
@property    CKDiagnostic      * d;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

-(void)textDidChange:(NSNotification *)notification {



  NSInteger insertionPoint = [_textView.selectedRanges[0] rangeValue].location;
  NSLog(@"%@", _textView.string);
  _tu.text = _textView.string;
  [_tu reparse];

  /* First create a translation unit for Objective-C, using a string */

//  id x = [_tu completionResultsForLine:1 column:i];
//  printf("completionResultsForLine1,%lu\n\n%s\n", i, [[x valueForKey:@"chunks"] description].UTF8String);

  NSRange paragraphRange = [_textView.textStorage.string paragraphRangeForRange:_textView.selectedRange];

  NSLog(@"%lu %lu", _textView.currentLine, _textView.currentColumn);

  NSMutableArray *chunks = @[].mutableCopy;
  for (CKCompletionResult *r in [_tu completionResultsForLine:_textView.currentLine?:1 column: _textView.currentColumn?:1]) {

    NSDictionary *d = @{@"text": [[r.chunks valueForKey:@"text"]componentsJoinedByString:@" "],
                        @"count" : @(r.chunks.count)};
    [chunks addObject:d];
  }

  [_controller setContent:chunks];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

  _tu = [ CKTranslationUnit    translationUnitWithText:  _textView.string
                              language:                   CKLanguageObjC
                              args:                       @[@"-w"]
       ];


//        /* Logs each diagnostic and fix-its */
//        for( d in tu.diagnostics)
//        {
//            NSLog( @"Diagnostic: %@", d);
//            NSLog( @"FixIts: %@", d.fixIts);
//        }
//        
//        /* Logs the available tokens */
//        NSLog( @"%@", tu.tokens);
//        
//        /* Changes the code, using the 'text' property */
//        tu.text =   @"#import <Foundation/Foundation.h>\n"
//                    @"\n"
//                    @"@interface Foo: NSObject\n"
//                    @"{}\n"
//                    @"@end\n"
//                    @"\n"
//                    @"int main( void)\n"
//                    @"{\n"
//                    @"    NSString * x;\n"
//                    @"    Foo      * f;\n"
//                    @"    \n"
//                    @"return 1;\n"
//                    @"}\n";
//        
//        /* Logs each diagnostic and fix-its */
//        for( d in tu.diagnostics)
//        {
//            NSLog( @"Diagnostic: %@", d);
//            NSLog( @"FixIts: %@", d.fixIts);
//        }
//        
//        /* Logs the available tokens */
//        NSLog( @"%@", tu.tokens);
//
//
//                /* Changes the code, using the 'text' property */
//        tu.text =   @"@imp";
////        [tu reparse];
//        for (NSUInteger i = 1; i < 10; i++) {
//          NSUInteger i = 3;
//          id x = [tu completionResultsForLine:1 column:i];
//          printf("completionResultsForLine1,%lu\n\n%s\n", i, [[x valueForKey:@"chunks"] description].UTF8String);

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
