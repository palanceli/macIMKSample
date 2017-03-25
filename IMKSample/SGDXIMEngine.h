//
//  SGDXIMEngine.h
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGDXIMEngine : NSObject
+(SGDXIMEngine*) sharedObject;
-(NSMutableString*) appendComposeString:(NSString*)string;
-(NSMutableString*) composeString;
-(NSArray*) candidates;
-(void) cleanComposeString;
@end
