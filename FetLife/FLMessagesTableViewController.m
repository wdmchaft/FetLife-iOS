//
//  FLMessagesTableViewController.m
//  FetLife
//
//  Created by Shawn Stricker on 5/17/12.
//  Copyright (c) 2012 KB1IBT.com. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "FLMessagesTableViewController.h"
#import "FLMessages.h"
#import "FLUsers.h"
#import "FLDetailViewController.h"

@interface FLMessagesTableViewController ()

@end

@implementation FLMessagesTableViewController

@synthesize messages = _messages;
@synthesize conversation = _conversation;
@synthesize detailViewController = _detailViewController;

-(void)setConversation:(FLConversations *)newConversation
{
    if (_conversation != newConversation) {
        _conversation = newConversation;
        
    }
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error);
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object{
//    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created_at" ascending:YES]];
    self.messages = [[(FLConversations*)object messages] array];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[RKObjectManager sharedManager] getObject:_conversation delegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessagesViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"EdMMM h:mm a" options:0 locale:[NSLocale currentLocale]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatString];
    cell.textLabel.text = [formatter stringFromDate:[[self.messages objectAtIndex:indexPath.row] created_at]];
    cell.detailTextLabel.text = [(FLMessages*)[self.messages objectAtIndex:indexPath.row] stripped_body];
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLConversations *selectedMessage = [self.messages objectAtIndex:indexPath.row];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (!self.detailViewController) {
            self.detailViewController = [[FLDetailViewController alloc] initWithNibName:@"FLDetailViewController_iPhone" bundle:nil];
        }
        self.detailViewController.detailItem = selectedMessage;    
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailItem = selectedMessage;    
    }
}

@end
