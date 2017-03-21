//
//  main.m
//  IMKSample
//
//  Created by palance on 17/3/21.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h> // 添加包含

const NSString* kConnectionName = @"IMKSampleConnection";
IMKServer*       server;

int main(int argc, const char * argv[]) {
  @autoreleasepool{
    NSString*       identifier;

    //find the bundle identifier and then initialize the input method server
    identifier = [[NSBundle mainBundle] bundleIdentifier];
    server = [[IMKServer alloc] initWithName:(NSString*)kConnectionName bundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]];
    
    //load the bundle explicitly because in this case the input method is a background only application
//    [NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
    
    //finally run everything
    [[NSApplication sharedApplication] run];
  }
  return 0;
}
