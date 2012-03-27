//
//  FLNetworkController.m
//  FetLife
//
//  Created by Shawn Stricker on 8/26/11.
//  Copyright (c) 2011 KB1IBT.com. All rights reserved.
//

#import "FLNetworkController.h"
#import "HTMLParser.h"
#import <RestKit/RKJSONParserJSONKit.h>


@implementation FLNetworkController

+(BOOL) loggedIn {
    NSError *theError = nil;
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"GET"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSHTTPURLResponse *theResponse =[[NSHTTPURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSString *encoding = [theResponse textEncodingName];
    NSStringEncoding nsEncoding = NSUTF8StringEncoding; // default to UTF-8
    if (encoding) {
        CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)encoding);
        if (cfEncoding != kCFStringEncodingInvalidId) {
            nsEncoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
        }
    }
    NSString *displayString = [[NSString alloc] initWithData:data encoding:nsEncoding];
    NSDictionary *result = [[RKJSONParserJSONKit alloc] objectFromString:displayString error:&theError];
    if([result objectForKey:@"nickname"]){
        return true;
    }
    return NO;
}
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    if ([request isGET]) {
        // Handling GET /foo.xml
        
        if ([response isOK]) {
            // Success! Let's take a look at the data
            NSLog(@"Retrieved XML: %@", [response bodyAsString]);
        }
    }
}
+(BOOL) loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *ua = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    NSError *theError = nil;
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/login"]];
    [request setHTTPMethod:@"GET"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    NSHTTPURLResponse *theResponse =[[NSHTTPURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    HTMLParser *htmlParse = [[HTMLParser alloc] initWithData:data error:theError];
    if (theError) {
        NSLog(@"Error: %@", theError);
        return FALSE;
    }
    NSString *authKey = nil;
    NSString *utf8Value = nil;
    HTMLNode *bodyNode = [htmlParse body];
    NSArray *inputNodes = [bodyNode findChildTags:@"input"];
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"authenticity_token"]) {
            authKey = [inputNode getAttributeNamed:@"value"];
        }
        if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"utf8"]) {
            utf8Value = [inputNode getAttributeNamed:@"value"];
        }
    }
    NSArray *keys = [NSArray arrayWithObjects:@"nickname_or_email", @"password", @"commit",@"authenticity_token",@"utf8", nil];
    NSArray *objects = [NSArray arrayWithObjects:username, password, @"Login to FetLife",authKey,utf8Value, nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSString *jsonString = [jsonDictionary stringWithURLEncodedEntries];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setURL:[NSURL URLWithString:@"https://fetlife.com/session"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue: ua forHTTPHeaderField: @"User-Agent"];
    [request setHTTPBody:jsonData];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSString *encoding = [theResponse textEncodingName];
    NSStringEncoding nsEncoding = NSUTF8StringEncoding; // default to UTF-8
    if (encoding) {
        CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)encoding);
        if (cfEncoding != kCFStringEncodingInvalidId) {
            nsEncoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
        }
    }
    return true;
}

@end
