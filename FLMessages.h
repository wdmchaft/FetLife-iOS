//
//  Messages.h
//  FetLife
//
//  Created by Shawn Stricker on 9/8/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLConversations;

@interface FLMessages : NSObject 

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * stripped_body;
@property (nonatomic, retain) NSNumber * unread;
@property (nonatomic, retain) FLConversations *conversation;
@property (nonatomic, retain) NSManagedObject *sender;

@end
