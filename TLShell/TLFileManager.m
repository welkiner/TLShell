//
//  TLFileManager.m
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import "TLFileManager.h"

static TLFileManager *mgr = nil;

@implementation TLFileManager

#pragma mark - 递归遍历有没有.sh文件
+ (NSMutableArray *)findShellPath:(NSString *)path resualtArray:(NSMutableArray *)array{
    if (!mgr) {
        mgr = (TLFileManager *)[TLFileManager defaultManager];
    }
    if (!array) {
        array = [NSMutableArray array];
    }
    if ([path isEqualToString:@"/"]){
        return nil;
    }
    
    NSArray *contents = [mgr contentsOfDirectoryAtURL:[NSURL URLWithString:path]
                                   includingPropertiesForKeys:nil
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'xcodeproj' || pathExtension == 'xcworkspace'"];
    if ([contents filteredArrayUsingPredicate:predicate].count == 0) {
        NSString *descPath = [path stringByDeletingLastPathComponent];
        return [TLFileManager findShellPath:descPath resualtArray:array];
    }else{
        predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'sh'"];
        if ([contents filteredArrayUsingPredicate:predicate].count > 0) {
            [array addObjectsFromArray:[contents filteredArrayUsingPredicate:predicate]];
        }
    }
    return array;
}

/**
 *    取标题
 */
+ (NSString *)titleForPath:(NSURL *)path{
    NSString *str = [path absoluteString];
    
    NSArray *array = [str.stringByRemovingPercentEncoding componentsSeparatedByString:@"/"];
    return array.lastObject;
}
@end
