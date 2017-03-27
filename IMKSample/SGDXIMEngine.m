//
//  SGDXIMEngine.m
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "SGDXIMEngine.h"

@implementation SGDXIMEngine
{
  NSMutableString* _composeString;
}

+(SGDXIMEngine*)sharedObject
{
  static SGDXIMEngine* sObject = nil;
  @synchronized (self) {
    if(sObject == nil){
      sObject = [[self alloc]init];
    }
  }
  return sObject;
}

-(NSMutableString*) composeString
{
  if(_composeString == nil){
    _composeString = [[NSMutableString alloc]init];
  }
  return _composeString;
}

-(void) setComposeString:(NSString*) value
{
  [[self composeString] setString:value];
}

-(NSString*)appendComposeString:(NSString *)string
{
  [[self composeString] appendString:string];
  return [self composeString];
}

-(void)cleanComposeString
{
  [[self composeString] setString:@""];
}

@end
