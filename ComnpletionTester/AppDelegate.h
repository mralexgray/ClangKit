//
//  AppDelegate.h
//  ComnpletionTester
//
//  Created by Alex Gray on 3/30/15.
//  Copyright (c) 2015 XS-Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate>

@property IBOutlet NSArrayController *controller;
@property IBOutlet NSTextView * textView;

@end

