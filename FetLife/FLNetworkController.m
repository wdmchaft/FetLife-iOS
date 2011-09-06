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
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    
    return NO;
}

+(BOOL) loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSError *theError = nil;
    NSArray *keys = [NSArray arrayWithObjects:@"nickname_or_email", @"password", @"commit", nil];
    NSArray *objects = [NSArray arrayWithObjects:username, password, @"Login to FetLife", nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSString *jsonString = [jsonDictionary JSONRepresentation];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"http://www.kb1ibt.com/session"]];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    [request setHTTPBody:jsonData];

    
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    
    return YES;
}

@end
