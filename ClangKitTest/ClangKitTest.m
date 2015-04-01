
/*!
 * @file            main.m
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit test / demo project
 */

int main( void )
{
    CKTranslationUnit * tu;
    CKDiagnostic      * d;
    
    @autoreleasepool
    {
        /* First create a translation unit for Objective-C, using a string */
        tu = [ CKTranslationUnit    translationUnitWithText:    @"int main( void ) { return 0; }"
                                    language:                   CKLanguageObjC
                                    args:                       @[@"-Weverything"]
             ];
        
        /* Logs each diagnostic and fix-its */
        for( d in tu.diagnostics )
        {
            NSLog( @"Diagnostic: %@", d );
            NSLog( @"FixIts: %@", d.fixIts );
        }
        
        /* Logs the available tokens */
        NSLog( @"%@", tu.tokens );
        
        /* Changes the code, using the 'text' property */
        tu.text =   @"#import <Foundation/Foundation.h>\n"
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
        
        /* Logs each diagnostic and fix-its */
        for( d in tu.diagnostics )
        {
            NSLog( @"Diagnostic: %@", d );
            NSLog( @"FixIts: %@", d.fixIts );
        }
        
        /* Logs the available tokens */
        NSLog( @"%@", tu.tokens );


                /* Changes the code, using the 'text' property */
        tu.text =   @"@imp";
//        [tu reparse];
        for (NSUInteger i = 1; i < 10; i++) {
//          NSUInteger i = 3;
          id x = [tu completionResultsForLine:1 column:i];
          printf("completionResultsForLine1,%lu\n\n%s\n", i, [[x valueForKey:@"chunks"] description].UTF8String);
        }

    }
    
    return 0;
}

