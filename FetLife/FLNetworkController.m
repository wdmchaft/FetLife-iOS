//
//  FLNetworkController.m
//  FetLife
//
//  Created by Shawn Stricker on 8/26/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import "FLNetworkController.h"
#import "SBJson.h"

@implementation FLNetworkController

+(BOOL) loggedIn {
    NSError *theError = nil;
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    return NO;
}

+(BOOL) loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    NSError *theError = nil;
    NSArray *keys = [NSArray arrayWithObjects:@"nickname_or_email", @"password", nil];
    NSArray *objects = [NSArray arrayWithObjects:username, password, nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSString *jsonString = [jsonDictionary JSONRepresentation];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];

    
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];      
    NSMutableString *string = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionaryResponse = [string JSONValue];
    
    
    return YES;
}

@end
