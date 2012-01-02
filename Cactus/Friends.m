//
//  Friends.m
//  Cactus
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import "Friends.h"


@implementation Friends

@dynamic bdYear;
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
