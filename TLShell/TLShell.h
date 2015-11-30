//
//  TLShell.h
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import <AppKit/AppKit.h>

@class TLShell;
static Class IDEWorkspaceWindowControllerClass;

@interface TLShell : NSObject

- (id)initWithBundle:(NSBundle *)plugin;
- (NSURL *)activeDocument;
+(instancetype)share;
@property (nonatomic, strong, readonly) NSBundle* bundle;
@property (strong,nonatomic) id ideWorkspaceWindow;
@property (strong,nonatomic) id mainWindow;
@end