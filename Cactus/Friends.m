//
//  Friends.m
//  Cactus
//
//  Created by Chen-Yu Hsu on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Friends.h"


@implementation Friends

@dynamic birthday;
@dynamic name;
@dynamic uid;

-(NSString *) birthdayMonth
{
    [self willAccessValueForKey:@"birthday"];
    
    if(![self birthday]){
        //NSLog(@"%i",month);
        return @"13";
    }else{
        //NSLog(@"OK:%@",[NSString stringWithFormat:@"%i", month]);
        return [[self birthday] substringToIndex:2];
    }
    [self didAccessValueForKey:@"birthday"];

}

@end
