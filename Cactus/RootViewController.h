//
//  RootViewController.h
//  Cactus
//
//  Created by Automne on 12/1/1.
//  Copyright (c) 2012 Automne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootOptionViewController.h"

@interface RootViewController : UIViewController{
    IBOutlet UIButton *cactusbutton;
    RootOptionViewController *optionController;
}

@property (nonatomic,retain) RootOptionViewController *optionController; 

-(IBAction)buttonClicked:(id)sender;

@end

