//
//  ViewController.h
//  Minesweep
//
//  Created by Prasen Revenkar on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtX;
@property (weak, nonatomic) IBOutlet UITextField *txtY;
- (IBAction)btnSubmitClick:(id)sender;


@end
