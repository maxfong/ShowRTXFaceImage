//
//  AppDelegate.m
//  ShowRTXFaceImage
//
//  Created by maxfong on 14-10-9.
//  Copyright (c) 2014年 maxfong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *txtField;
@property (weak) IBOutlet NSTextField *txtResult;
@property (weak) IBOutlet NSImageView *imageView;

@property (weak) IBOutlet NSWindow *imageWindow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)didPressedShow:(id)sender
{
    NSString *name = [self.txtField stringValue];
    if ([name length] > 0) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [NSString stringWithFormat:@"/Users/%@/Library/Application Support/RTXC/accounts", NSUserName()];
        NSArray *directorys = [fileManager contentsOfDirectoryAtPath:path error:nil];
        [directorys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if (![obj isEqualToString:@".DS_Store"]) {
                 NSString *faceImagePath = [NSString stringWithFormat:@"%@/%@/userPhotos", path, obj];
                 NSArray *faceImageFiles = [fileManager contentsOfDirectoryAtPath:faceImagePath error:nil];
                 NSString *imageName = [NSString stringWithFormat:@"%@.bmp", name];
                 if ([faceImageFiles containsObject:imageName])
                 {
                     NSString *imagePath = [NSString stringWithFormat:@"%@/%@", faceImagePath, imageName];
                     NSImage *image = [[NSImage alloc] initWithContentsOfFile:imagePath];
                     self.imageView.image = image;
                     
                     float width = image.size.width;
                     float height = image.size.height;
                     [self.imageWindow setFrame:CGRectMake(CGRectGetMinX(self.imageWindow.frame), CGRectGetMinY(self.imageWindow.frame), width, height) display:YES];
                     [[self imageWindow] makeKeyAndOrderFront:nil];
                     
                     self.txtResult.stringValue = @"success";
                 }
                 else
                 {
                     self.txtResult.stringValue = @"未查询到相关图片";
                 }
                 *stop = YES;
             }
         }];
        return;
    }
    self.txtResult.stringValue = @"输入：姓名+工号，如：王小明01234";
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
