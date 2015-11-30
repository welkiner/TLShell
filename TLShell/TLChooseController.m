//
//  TLChooseController.m
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import "TLChooseController.h"
#import "TLTableRowView.h"
#import "TLFileManager.h"
#import "TLShellRunner.h"
#import "TLWorkspaceManager.h"
#import "TLShell.h"
@interface TLChooseController ()<NSTableViewDataSource,NSTableViewDelegate>{
    NSArray *_listArray;
}
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation TLChooseController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _listArray =[[TLFileManager findShellPath:self.path resualtArray:nil] copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _listArray.count;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)rowIndex {
    TLTableRowView *rowView = [[TLTableRowView alloc] init];
    rowView.title = [TLFileManager titleForPath:_listArray[rowIndex]];
    typeof(self) weakSelf = self;
    rowView.btnClick = ^{
        [weakSelf task:_listArray[rowIndex]];
    };
    return rowView;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 50;
}
- (void )task:(NSURL *)path{
//
    NSMutableString *str =[path.absoluteString.stringByRemovingPercentEncoding mutableCopy];
    [str replaceCharactersInRange:NSMakeRange(0, 6) withString:@""];

    
    [TLShellRunner runShellCommand:@"/bin/sh"
                           withArgs:@[str]
                          directory:nil
                         completion:nil];

}

@end
