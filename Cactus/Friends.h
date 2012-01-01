//
//  Friends.h
//  Cactus
//
//  Created by Chen-Yu Hsu on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friends : NSManagedObject

-(NSString *) birthdayMonth;

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uid;

@end
