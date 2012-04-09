//
//  NSAttributedString+OPHTML.m
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 4/8/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "NSAttributedString+OPHTML.h"
#import "OPHTMLStyle.h"
#import "HTMLParser.h"
#import "OPExtensionKit.h"

#define kParagraphSeparatorUnicode  @"\u2029"

@interface NSMutableAttributedString (OPHTML_Private)
-(void) applyStyles:(NSArray*)styles currentNode:(HTMLNode*)currentNode currentLocation:(NSUInteger*)currentLocation;
@end

@implementation NSAttributedString (OPHTML)

-(id) initWithHTML:(NSString*)html {
    return [self initWithHTML:html styles:nil];
}

-(id) initWithHTML:(NSString*)html styles:(NSArray*)styles {
    
    // massage the html a little because NSAttributedStrings don't behave like html, e.g. consecutive spaces are preserved,
    // newlines create paragraphs, etc...
    html = [[html stringByNormalizingNewlines] stringByNormalizingConsecutiveWhitespace];
    
    // parse the html and create a basic attributed string with no stylings
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:NULL];
    HTMLNode *bodyNode = [parser body];
    if (! bodyNode) return nil;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[bodyNode allContents]];
    
    // walk the html dom tree recursively and apply styles
    NSUInteger currentLocation = 0;
    [string applyStyles:styles currentNode:bodyNode currentLocation:&currentLocation];
    
    return [self initWithAttributedString:string];
}

@end

@implementation NSMutableAttributedString (OPHTML)

-(void) applyStyles:(NSArray*)styles currentNode:(HTMLNode*)currentNode currentLocation:(NSUInteger*)currentLocation {
    
    NSString *contents = [currentNode allContents];
    NSRange contentsRange = NSMakeRange(*currentLocation, [contents length]);
    
    // manually insert line breaks for BR tags
    if ([[currentNode tagName] isEqualToString:@"br"]) {
        [self insertAttributedString:[[NSAttributedString alloc] initWithString:@"\u2028"] atIndex:*currentLocation];
        *currentLocation += 1;
    }
    
    // loop through all of the styles that we can apply to this node
    NSArray *applicableStyles = [styles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"tagName", [currentNode tagName]]];
    for (OPHTMLStyle *style in applicableStyles)
    {
        [style.attributeValues enumerateKeysAndObjectsUsingBlock:^(NSString *attribute, id value, BOOL *stop) {
            [self addAttribute:attribute value:value range:contentsRange];
        }];
    }
    
    // apply styles to children nodes
    for (HTMLNode *node in [currentNode children])
        [self applyStyles:styles currentNode:node currentLocation:currentLocation];
    
    // manually insert paragraph separators for breaking tags
    if ([currentNode nodetype] == HTMLPNode || 
        [currentNode nodetype] == HTMLLiNode || 
        [currentNode nodetype] == HTMLUlNode || 
        [currentNode nodetype] == HTMLOlNode ||
        [[currentNode tagName] isEqualToString:@"h1"] ||
        [[currentNode tagName] isEqualToString:@"div"]) {
        [self insertAttributedString:[[NSAttributedString alloc] initWithString:@"\u2029"] atIndex:*currentLocation];
        *currentLocation += 1;
    }
    
    // advance the location everytime we hit the bottom most text node
    if ([currentNode nodetype] == HTMLTextNode)
        *currentLocation += [contents length];
}

@end
