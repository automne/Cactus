//
//  DetailViewController.h
//  Cactus
//
//  Created by Automne on 12/31/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBRequestWrapper.h"


@interface DetailViewController : UIViewController <FBRequestWrapperDelegate>
{
    IBOutlet UIImageView *imageView;
    FBRequestWrapper *wrapper;
    UIActivityIndicatorView *activity;
}

- (IBAction) textFieldReturn:(id)sender;

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextField *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextField *birthdayLabel;


@end
