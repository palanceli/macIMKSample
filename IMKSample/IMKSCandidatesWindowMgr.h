//
//  IMKSCandidatesWindowMgr.h
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <InputMethodKit/InputMethodKit.h>

@interface IMKSCandidatesWindowMgr : NSObject
+(IMKSCandidatesWindowMgr*)sharedObject;
-(void)updateCandidateWindow:(id<IMKTextInput, NSObject>) sender;
@end
