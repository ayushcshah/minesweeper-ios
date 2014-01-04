//
//  ViewController.m
//  Minesweep
//
//  Created by Prasen Revenkar on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SecondViewController.m"
@interface ViewController ()

@end

@implementation ViewController
@synthesize txtName;
@synthesize txtX;
@synthesize txtY;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTxtName:nil];
    [self setTxtX:nil];
    [self setTxtY:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)btnSubmitClick:(id)sender {
    if (!([txtX.text isEqualToString:@""] || [txtY.text isEqualToString:@""])) {
        SecondViewController *SecondVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:Nil];
        
        [SecondVC createGridWithRows:[txtX.text intValue] Columns:[txtY.text intValue]];
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        UIView *view1 = [[UIView alloc]init];
        view1 = [self view];
        
//        [UIView setAnimationTransition:(YES)?[UIViewAnimationTransitionCurlUp:UIViewAnimationTransitionCurlDown forView:view1 cache:YES];
        	[UIView setAnimationTransition:(YES)?UIViewAnimationTransitionFlipFromLeft:UIViewAnimationTransitionFlipFromRight  forView:view1 cache:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.50];
        [UIView commitAnimations];
        [self.navigationController pushViewController:SecondVC animated:YES];
//        [self presentModalViewController:SecondVC animated:YES];
        
        
    }
}
@end
