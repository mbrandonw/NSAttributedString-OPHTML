//
//  OPHTMLStyle.m
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 4/8/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "OPHTMLStyle.h"

@implementation OPHTMLStyle

@synthesize tagName = _tagName;
@synthesize attributeValues = _attributeValues;

-(id) initWithTagName:(NSString*)tagName attributeValues:(NSDictionary*)attributeValues {
    if (! (self = [self init]))
        return nil;
    
    self.tagName = tagName;
    self.attributeValues = attributeValues;
    
    return self;
}

@end
