//
//  FLMasterViewController.h
//  FetLife
//
//  Created by Shawn Stricker on 8/20/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLDetailViewController;
@class FLMessagesTableViewController;
@protocol RKRequestDelegate;

#import <CoreData/CoreData.h>

@interface FLMasterViewController : UITableViewController <RKRequestDelegate>

@property (strong, nonatomic) FLDetailViewController *detailViewController;
@property (strong, nonatomic) FLMessagesTableViewController *messageViewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong,nonatomic) NSArray *conversations;

@end
