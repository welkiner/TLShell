//
//  CCPXCodeConsole.h
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface TLXCodeConsole : NSObject
+ (instancetype)consoleForKeyWindow;

- (void)appendText:(NSString*)text;
- (void)appendText:(NSString*)text color:(NSColor*)color;

- (void)log:(id)obj;
- (void)error:(id)obj;

@end
