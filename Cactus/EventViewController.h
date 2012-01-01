//
//  EventViewController.h
//  Cactus
//
//  Created by Chen-Yu Hsu on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface EventViewController : UITableViewController <UINavigationBarDelegate, UITableViewDelegate, 
EKEventEditViewDelegate, UINavigationControllerDelegate, UIActionSheetDelegate> {
    
	EKEventViewController *detailViewController;
	EKEventStore *eventStore;
	EKCalendar *defaultCalendar;
	NSMutableArray *eventsList;
}

- (NSArray *) fetchEventsForToday;
- (void) backEvent;
- (void) addEvent;

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;




@end
