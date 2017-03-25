//
//  IMKSCandidatesWindow.h
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

@interface IMKSCandidatesWindow : NSWindow
-(void)update:(id<IMKTextInput, NSObject>)sender;
@end
