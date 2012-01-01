//
//  AppDelegate.h
//  Cactus
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class FBListViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate, FBRequestDelegate>
{
    Facebook *facebook;
}

-(void) FBLogin;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UIWindow *window;



@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, retain) Facebook *facebook;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end