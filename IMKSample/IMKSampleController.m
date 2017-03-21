//
//  IMKSampleController.m
//  IMKSample
//
//  Created by palance on 17/3/22.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSampleController.h"

@implementation IMKSampleController
-(BOOL)inputText:(NSString*)string client:(id)sender
{
  //Return YES to indicate the the key input was received and dealt with.  Key processing will not continue in that case.  In
  //other words the system will not deliver a key down event to the application.
  //Returning NO means the original key down will be passed on to the client.
  NSLog(@"%@", string);
  return NO;
}
@end
