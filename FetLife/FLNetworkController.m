//
//  FLNetworkController.m
//  FetLife
//
//  Created by Shawn Stricker on 8/26/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import "FLNetworkController.h"

@implementation FLNetworkController

+(BOOL) loggedIn {
    NSError *theError = nil;
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/login"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];

    NSHTTPURLResponse *theResponse =[[NSHTTPURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSString *location = [[theResponse allHeaderFields] objectForKey:@"Location"];
    if ([location isEqualToString:@"https://fetlife.com/home"]) {
        return YES;
    }
    return NO;
}

+(BOOL) loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSError *theError = nil;
    NSArray *keys = [NSArray arrayWithObjects:@"nickname_or_email", @"password", @"commit", nil];
    NSArray *objects = [NSArray arrayWithObjects:username, password, @"Login to FetLife", nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSString *jsonString = nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"http://www.kb1ibt.com/session"]];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    [request setHTTPBody:jsonData];

    
    NSHTTPURLResponse *theResponse =[[NSHTTPURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSString *location = [[theResponse allHeaderFields] objectForKey:@"Location"];
    if ([location isEqualToString:@"https://fetlife.com/home"]) {
        return YES;
    }
    return NO;
}

@end
