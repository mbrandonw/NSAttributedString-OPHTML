//
//  NSString+OPHTML.h
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 7/18/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "NSString+OPHTML.h"
#import "HTMLParser.h"
#import "OPExtensionKit.h"

@interface NSString (OPHTML_Private)
-(NSMutableString*) plainText:(HTMLNode*)node;
@end

@implementation NSString (OPHTML)

-(NSString*) plainText {
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:self error:NULL];
    HTMLNode *bodyNode = [parser body];
    if (! bodyNode) return nil;
    
    return [self plainText:bodyNode];
}

-(NSMutableString*) plainText:(HTMLNode*)node {
    
    NSMutableString *retVal = [NSMutableString new];
    
    if ([[node children] count] == 0)
        [retVal appendString:[[[[node allContents] trim] stringByReplacingOccurrencesOfString:@"\n" withString:@" "] stringByNormalizingConsecutiveWhitespace]];
    
    for (HTMLNode *child in [node children])
    {
        [retVal appendString:[self plainText:child]];
    }
    
    // manually insert paragraph separators for breaking tags
    if ([node nodetype] == HTMLPNode || 
        [node nodetype] == HTMLLiNode || 
        [node nodetype] == HTMLUlNode || 
        [node nodetype] == HTMLOlNode ||
        [[node tagName] isEqualToString:@"h1"] ||
        [[node tagName] isEqualToString:@"div"] ||
        [[node tagName] isEqualToString:@"br"]) {
        [retVal appendString:@" \n"];
    }

    return retVal;
}

@end
