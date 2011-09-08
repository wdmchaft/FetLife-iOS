//
//  FLUsers.h
//  FetLife
//
//  Created by Shawn Stricker on 9/8/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLConversations, FLMessages;

@interface FLUsers : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * medium_avatar_url;
@property (nonatomic, retain) NSString * mini_avatar_url;
@property (nonatomic, retain) NSString * new_conversation_url;
@property (nonatomic, retain) NSString * new_wall_post_url;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * pictures_url;
@property (nonatomic, retain) NSString * posts_url;
@property (nonatomic, retain) NSString * profile_url;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * small_avatar_url;
@property (nonatomic, retain) NSNumber * supporter_badge;
@property (nonatomic, retain) NSString * videos_url;
@property (nonatomic, retain) FLConversations *conversations;
@property (nonatomic, retain) FLMessages *messages;

@end
