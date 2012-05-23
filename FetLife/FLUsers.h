//
//  FLUsers.h
//  FetLife
//
//  Created by Shawn Stricker on 5/22/12.
//  Copyright (c) 2012 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLMessages, FLConversations;

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
@property (nonatomic, retain) NSSet *conversations;
@property (nonatomic, retain) NSSet *messages;
@end

@interface FLUsers (CoreDataGeneratedAccessors)

- (void)addConversationsObject:(FLConversations *)value;
- (void)removeConversationsObject:(FLConversations *)value;
- (void)addConversations:(NSSet *)values;
- (void)removeConversations:(NSSet *)values;

- (void)addMessagesObject:(FLMessages *)value;
- (void)removeMessagesObject:(FLMessages *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
