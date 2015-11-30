//
//  TLShell.m
//  TLShell
//
//  Created by tl on 15/11/30.
//  Copyright © 2015年 TL. All rights reserved.
//

#import "TLShell.h"
#import "TLChooseController.h"
#import "TLFileManager.h"
@interface TLShell()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) TLChooseController *controller;
@end

static TLShell *__shell;
@implementation TLShell
+(instancetype)share{
    return __shell;
}
- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        IDEWorkspaceWindowControllerClass = NSClassFromString(@"IDEWorkspaceWindowController");
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWindownUpdate:) name:NSWindowDidUpdateNotification object:nil];
        
        
    }
    __shell = self;
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"File"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Find shell" action:@selector(doMenuAction) keyEquivalent:@"s"];
        [actionMenuItem setKeyEquivalentModifierMask: NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    if (![self activeDocument]) {
        return;
    }
    self.controller= [[TLChooseController alloc] initWithWindowNibName:NSStringFromClass([TLChooseController class])];
    self.controller.path = [[self activeDocument] path];
    [self.controller showWindow:self.controller];
}


#pragma mark - 获取到当前项目的URL
- (NSURL *)activeDocument
{
    NSArray *windows = [IDEWorkspaceWindowControllerClass valueForKey:@"workspaceWindowControllers"];
    for (id workspaceWindowController in windows)
    {
        if ([workspaceWindowController valueForKey:@"workspaceWindow"] == self.ideWorkspaceWindow || windows.count == 1)
        {
            id document = [[workspaceWindowController valueForKey:@"editorArea"] valueForKey:@"primaryEditorDocument"];
            self.mainWindow = [workspaceWindowController valueForKey:@"workspaceWindow"];
            return [document fileURL];
        }
    }
    
    return nil;
}




#pragma mark - 获取到当前项目的Window
- (void)applicationWindownUpdate:(NSNotification *)noti{
    id window = [noti object];
    if ([window isKindOfClass:[NSWindow class]] && [window isMainWindow])
    {
        self.ideWorkspaceWindow = window;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
