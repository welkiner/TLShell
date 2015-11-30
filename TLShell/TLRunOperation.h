//
//  CCPRunOperation.h
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
@interface TLRunOperation : NSOperation
- (id)initWithTask:(NSTask*)task;
@end
