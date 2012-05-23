//
//  FLConversations.h
//  FetLife
//
//  Created by Shawn Stricker on 5/22/12.
//  Copyright (c) 2012 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLMessages, FLUsers;

@interface FLConversations : NSManagedObject

@property (nonatomic, retain) NSString * archive_url;
@property (nonatomic, retain) NSNumber * archived;
@property (nonatomic, retain) NSString * delete_url;
@property (nonatomic, retain) NSString * deletion_token;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * last_message_timestamp;
@property (nonatomic, retain) NSString * mark_as_unread_url;
@property (nonatomic, retain) NSNumber * new_message_count;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * unarchive_url;
@property (nonatomic, retain) NSString * update_url;
@property (nonatomic, retain) NSOrderedSet *messages;
@property (nonatomic, retain) FLUsers *with_user;
@end

@interface FLConversations (CoreDataGeneratedAccessors)

- (void)insertObject:(FLMessages *)value inMessagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMessagesAtIndex:(NSUInteger)idx;
- (void)insertMessages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMessagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMessagesAtIndex:(NSUInteger)idx withObject:(FLMessages *)value;
- (void)replaceMessagesAtIndexes:(NSIndexSet *)indexes withMessages:(NSArray *)values;
- (void)addMessagesObject:(FLMessages *)value;
- (void)removeMessagesObject:(FLMessages *)value;
- (void)addMessages:(NSOrderedSet *)values;
- (void)removeMessages:(NSOrderedSet *)values;
@end
