//
//  ViewController.h
//  Cactus
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "FBRequestWrapper.h"

#import "Friends.h"



@interface FBListViewController : UITableViewController <NSFetchedResultsControllerDelegate, FBRequestWrapperDelegate>
{
    FBRequestWrapper *wrapper;
    NSArray *friendList;
    NSFetchedResultsController *fetchedResultsController;
    IBOutlet UISearchBar *searchBar;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UISearchBar *searchBar;

- (void) getInformation;
-(void) saveInfoWithUid:(NSString *)uid andName:(NSString *)name andBd:(NSString *)birthday;
- (IBAction) login: (id) sender;

@end
