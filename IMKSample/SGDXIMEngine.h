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

-(NSMutableString*) appendComposeString:(NSString*)string;  // 向写作串追加字符
-(void) cleanComposeString;         // 清除写作串
-(NSMutableString*) composeString;  // 获得写作串
@end
