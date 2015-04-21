
/* $Id$ */

/*!
	@header       ClangKit.h
	@copyright    (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
	@author       Jean-David Gadina - www.xs-labs.com
	@abstract     ClangKit main header file
	@discussion   Please only use this header file when working with ClangKit.
                It contains all the public interfaces for the ClangKlit classes.
                No other header file should be directly included.
 */


    
@import AppKit;
@import AtoZUniversal;

CLANG_IGNORE(-Wobjc-property-no-attribute)

#import <ClangKit/CKTypes.h>
#import <ClangKit/CKDiagnostic.h>
#import <ClangKit/CKFixIt.h>
#import <ClangKit/CKIndex.h>
#import <ClangKit/CKToken.h>
#import <ClangKit/CKTranslationUnit.h>
#import <ClangKit/CKCursor.h>
#import <ClangKit/CKSourceLocation.h>
#import <ClangKit/CKCompletionResult.h>
#import <ClangKit/CKCompletionChunk.h>

#import <ClangKit/CE+Categories.h>

