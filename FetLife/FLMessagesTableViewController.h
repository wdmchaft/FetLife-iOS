//
//  FLMessagesTableViewController.h
//  FetLife
//
//  Created by Shawn Stricker on 5/17/12.
//  Copyright (c) 2012 KB1IBT.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLConversations.h"

@class FLDetailViewController;

@protocol RKObjectLoaderDelegate;

@interface FLMessagesTableViewController : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) FLDetailViewController *detailViewController;
@property (strong,nonatomic) NSArray *messages;
@property (strong,nonatomic) FLConversations *conversation;

@end
