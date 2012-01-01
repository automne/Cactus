//
//  ViewController.m
//  Cactus
//
//  Created by Chen-Yu Hsu on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import "FBListViewController.h"
#import "DetailViewController.h"
#import "LocalWeatherViewController.h"

NSDate *birthday;
NSDate *today;
NSDateFormatter *dateFormatter;
NSNumberFormatter *numFormatter;
NSString *birthdayString;
UIImage *img;
id temp;
id temp_2;

@interface FBListViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FBListViewController

@synthesize detailViewController = _detailViewController;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize searchBar;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.title=@"Hello";
    
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItem = loginButton;
    
    [backButton release];
    [loginButton release];
    
    self.title=@"Birthday";
    wrapper=[[FBRequestWrapper alloc] initWithGraphPath:@"me"];
    if(![wrapper.facebook isSessionValid]){
        loginButton.title=@"Login";
    }
    self.searchBar.tintColor=[UIColor darkGrayColor];
    CGPoint offset= {0, 44};
    [self.tableView setContentOffset:offset];
    /*
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [dateFormatter dateFromString:@"1992-04-11 16:01:03"];
    [dateFormatter release];
    NSUInteger componentFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:date2 toDate:date options:0];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSLog(@"%d %d %d", year, month, day);
     */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [wrapper release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


/*******************************************************************************************/

-(IBAction)login:(id)sender
{
    AppDelegate *appDelegate=(AppDelegate *)([[UIApplication sharedApplication] delegate]);
    [appDelegate FBLogin];
    //[self performSelectorInBackground:@selector(getInformation) withObject:self];
    [self getInformation];
}

- (void) getInformation
{
    wrapper=[[FBRequestWrapper alloc] initWithGraphPath:@"me/friends"];
    if([wrapper.facebook isSessionValid]){
        self.navigationItem.rightBarButtonItem.title=@"Refresh";
        [wrapper sendRequestWithDelegate:self];
    
    }else{
        self.navigationItem.rightBarButtonItem.title=@"Connect";
        /*
        CGRect rect=CGRectMake(0, 0, 320, 480);
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:rect];
        UIImage *im=[UIImage imageNamed:@"login.png"];
        imgView.image=im;
        [self.view addSubview:imgView];
         */
    }
}


- (void) getBirthday
{
    for(int i=0; i<[friendList count]; i++){
        wrapper.graphUrl=[[friendList objectAtIndex:i] valueForKey:@"id"];
        [wrapper sendRequestWithDelegate:self];
    }
    
}


-(NSString *) numberToMonth:(int) monthNumber
{
    NSString *result;
    switch (monthNumber) {
        case 1:
            result=@"January";
            break;
            
        case 2:
            result=@"Febuary";
            break;
            
        case 3:
            result=@"March";
            break;
            
        case 4:
            result=@"April";
            break;
            
        case 5:
            result=@"May";
            break;
            
        case 6:
            result=@"June";
            break;
            
        case 7:
            result=@"July";
            break;
            
        case 8:
            result=@"August";
            break;
            
        case 9:
            result=@"September";
            break;
            
        case 10:
            result=@"October";
            break;
            
        case 11:
            result=@"November";
            break;
            
        case 12:
            result=@"December";
            break;
            
        default:
            result=@"No Information";
            break;
    }
    return result;

}

- (void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

/****************************************************************************/


- (void) finishedPublishingPost:(FBRequestWrapper *)_request
{
    id result=wrapper.parsedResult;
    BOOL isData=[NSStringFromClass([result class]) isEqualToString:@"__NSCFDictionary"];
    if(isData){
        if([result valueForKey:@"id"]!=NULL){ //birthday
        
            //uid
            NSString *uid=[result valueForKey:@"id"];
        
            //bd
            NSString *bd=[result valueForKey:@"birthday"]; 
            int year;
            if(bd==nil){
                bd=@"13/00";
                year=-2;
            }
            
            if([bd length]>=6){
                year=[[bd substringFromIndex:6] intValue];
                bd=[bd substringToIndex:5];
            }else{
                year=-1;
            }
        
            //name
            NSString *name=[result valueForKey:@"name"];
        
            [self saveInfoWithUid:uid andName: name andBd: bd andYear:year];
        
        }else{ //friendlist
            friendList=[result valueForKey:@"data"];
            
            [self getBirthday];
        }
    }else{

        //img=[UIImage imageWithData:result];
    }
} 

- (void) failedToPublishPost:(FBRequestWrapper *)_request
{
    NSLog(@"Error");
    
}

/*******************************************************************************************/

/*****************************************************************************************/
//Table View Controller .. Override

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Friends" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"birthday" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"birthdayMonth" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}  

-(void) saveInfoWithUid:(NSString *)uid andName:(NSString *)name andBd:(NSString *)birthday andYear:(int) year
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    NSError *nError=nil;
    Friends *friend=nil;
        
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Friends" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"uid == %@", uid]];
        
    //Query Object using `uid` 
    friend = [[context executeFetchRequest:request error:&nError] lastObject];

    
    if(nError){
        NSLog(@"Error @ saveInfoWithUid:");
        abort();
    }
    
    NSInteger bdYear=year;
    NSNumber *myBDYear=[[NSNumber alloc] initWithInt:bdYear];
    
    if(!friend){
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        // If appropriate, configure the new managed object.
        [newManagedObject setValue:uid forKey:@"uid"];
        [newManagedObject setValue:name forKey:@"name"];
        [newManagedObject setValue:birthday forKey:@"birthday"];
        [newManagedObject setValue:myBDYear forKey:@"bdYear"];
    }else{
        // Otherwise, update information for the specific object.
        [friend setValue:name forKey:@"name"];
        [friend setValue:birthday forKey:@"birthday"];
        [friend setValue:myBDYear forKey:@"bdYear"];
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [myBDYear release];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
    //return 13;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [[managedObject valueForKey:@"name"] description];
    
    temp=[managedObject valueForKey:@"birthday"];
    NSString *temp2=[temp substringToIndex:2];
    if([temp2 intValue]!=13){
        cell.detailTextLabel.text=(NSString *)temp;
        temp_2=[managedObject valueForKey:@"bdYear"];
        if([temp_2 integerValue]!=-1){

            today = [NSDate date];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            temp2=[[temp_2 stringValue] stringByAppendingFormat:@"/%@",temp];
            birthday = [dateFormatter dateFromString:temp2];
            [dateFormatter release];
            NSUInteger componentFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
            NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:birthday toDate:today options:0];
            NSInteger bdYear = [components year];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%i • %@", bdYear, cell.detailTextLabel.text];
        
        }else;
    }else{
        cell.detailTextLabel.text=@" ";
    }
    //cell.imageView.image=img;
}




- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}



- (void)insertNewObject
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{   
    NSString *result;
    if([self numberOfSectionsInTableView:self.tableView]<=12){
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        NSString *date;
        int month;
        for(id iter in [sectionInfo objects]){
            date=[iter valueForKey:@"birthday"];
            month=[[date substringToIndex:2] intValue];
        }
        result=[self numberToMonth:month];
        //[date release];
        //[components release];
    }else{
        result=[self numberToMonth:section+1];
    }
    return result;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
    }
    NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    self.detailViewController.detailItem = selectedObject;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}


/******************************************************************************************/
/*Search Bar*/

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    
    if(searchText.length>0){
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    }else{
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"1 == 1"];
        [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    }
    
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
        
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar 
{
    theSearchBar.showsCancelButton=YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar
{
    theSearchBar.showsCancelButton=NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.35];
    CGPoint offset= {0, 44};
    [self.tableView setContentOffset:offset];
    [UIView commitAnimations];
}

@end











