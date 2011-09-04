//
//  FLLoginController.m
//  FetLife
//
//  Created by Shawn Stricker on 8/23/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import "FLLoginViewController.h"
#import "FLNetworkController.h"

@implementation FLLoginViewController
@synthesize password, username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(IBAction)login:(id)sender{
    [FLNetworkController loginWithUsername:[self.username text] withPassword:[self.password text]];
}

@end
