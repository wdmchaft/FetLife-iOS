//
//  FLDetailViewController.h
//  FetLife
//
//  Created by Shawn Stricker on 8/20/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextView *bodyLabel;
@property (strong,nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong,nonatomic) IBOutlet UILabel *dateLabel;

@end
