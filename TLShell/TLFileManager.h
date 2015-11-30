//
//  TLFileManager.h
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TLFileManager : NSFileManager
+ (NSMutableArray *)findShellPath:(NSString *)path resualtArray:(NSMutableArray *)array;

+ (NSString *)titleForPath:(NSString *)path;
@end
