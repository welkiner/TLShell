//
//  TLTableRowView.m
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import "TLTableRowView.h"

@interface TLTableRowView ()
@property (weak,nonatomic) NSButton *btn;
@end

@implementation TLTableRowView

- (void)drawBackgroundInRect:(NSRect)dirtyRect{
    NSTableRowView *cellView = [self viewAtColumn:0];
    cellView.backgroundColor = [NSColor redColor];
    
    if (!self.btn) {
        NSButton *btn = [[NSButton alloc] init];
        btn.target = self;
        btn.action = @selector(btnShouldClick);
        [self addSubview:_btn = btn];
        btn.frame = cellView.frame;
    }
    [self.btn setTitle:self.title];
    NSRectFill([cellView bounds]);
}
-(void)btnShouldClick{
    !self.btnClick?:self.btnClick();
}

@end
