//
//  FLMasterViewController.m
//  FetLife
//
//  Created by Shawn Stricker on 8/20/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "FLMasterViewController.h"
#import "FLMessagesTableViewController.h"

#import "FLNetworkController.h"

#import "FLDetailViewController.h"
#import "FLLoginViewController.h"
#import "FLConversations.h"
#import "FLUsers.h"

@interface FLMasterViewController ()
@property BOOL loggedIn;
@end

@implementation FLMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize messageViewController = _messageViewController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize conversations;
@synthesize loggedIn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Conversations", @"Conversations");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
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
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    self.conversations = objects;
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![FLNetworkController loggedIn]) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            FLLoginViewController *loginView = [[FLLoginViewController alloc] initWithNibName:@"FLLoginViewController_iPhone" bundle:nil];
            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:loginView animated:YES];
        }else{
            FLLoginViewController *loginView = [[FLLoginViewController alloc] initWithNibName:@"FLLoginViewController_iPad" bundle:nil];
            loginView.modalPresentationStyle = UIModalPresentationFormSheet;
            loginView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:loginView animated:YES];
        }
    }else {
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/conversations" delegate:self];
    }
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.conversations count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConversationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    cell.textLabel.text = [(FLConversations*)[self.conversations objectAtIndex:indexPath.row] subject];
    cell.detailTextLabel.text = [(FLUsers*)[(FLConversations*)[self.conversations objectAtIndex:indexPath.row]with_user]nickname];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[(FLUsers*)[(FLConversations*)[self.conversations objectAtIndex:indexPath.row]with_user]small_avatar_url]]]];
//    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLConversations *selectedConversation = [self.conversations objectAtIndex:indexPath.row];
    if (!self.messageViewController) {
        self.messageViewController = [[FLMessagesTableViewController alloc] init];
    }
    self.messageViewController.conversation = selectedConversation;
    [self.navigationController pushViewController:self.messageViewController animated:YES];
}

@end
