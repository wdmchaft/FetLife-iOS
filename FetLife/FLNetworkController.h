//
//  FLNetworkController.h
//  FetLife
//
//  Created by Shawn Stricker on 8/26/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLNetworkController : NSObject

+(BOOL) loggedIn;
+(BOOL) loginWithUsername:(NSString *)username withPassword:(NSString *)password; 
@end
