//
//  TLTableRowView.h
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TLTableRowView : NSTableRowView
@property (strong,nonatomic) NSString *title;
@property (nonatomic,copy)void (^btnClick)();
@end
