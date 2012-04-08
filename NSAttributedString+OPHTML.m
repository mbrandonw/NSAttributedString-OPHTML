//
//  NSAttributedString+OPHTML.m
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 4/8/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "NSAttributedString+OPHTML.h"
#import "HTMLParser.h"

@interface NSAttributedString (OPHTML_Private)
@end

@implementation NSAttributedString (OPHTML)

+(id) attributedStringWithHTML:(NSString*)html {
    return [[self class] attributedStringWithHTML:html styles:nil];
}

+(id) attributedStringWithHTML:(NSString*)html styles:(NSArray*)styles {
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:NULL];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[[parser doc] allContents]];
    
    return string;
}

@end
