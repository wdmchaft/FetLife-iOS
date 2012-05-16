//
//  Conversations.h
//  FetLife
//
//  Created by Shawn Stricker on 9/8/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLMessages;
@class FLUsers;

@interface FLConversations : NSObject


@property (nonatomic, retain) NSString * archive_url;
@property (nonatomic, retain) NSNumber * archived;
@property (nonatomic, retain) NSString * delete_url;
@property (nonatomic, retain) NSString * deletion_token;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * last_message_timestamp;
@property (nonatomic, retain) NSString * mark_as_unread_url;
@property (nonatomic, retain) NSNumber * message_counts;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * unarchive_url;
@property (nonatomic, retain) NSString * update_url;
@property (nonatomic, retain) FLMessages *messages;
@property (nonatomic, retain) FLUsers *with_user;

@end
