//
//  FLLoginController.h
//  FetLife
//
//  Created by Shawn Stricker on 8/23/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;

@end
