//
//  RootViewController.h
//  Cactus
//
//  Created by nthu on 12/1/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
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

