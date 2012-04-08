//
//  OPHTMLStyle.h
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 4/8/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPHTMLStyle : NSObject

/**
 Name of the tag to apply this style to.
 */
@property (nonatomic, strong) NSString *tagName;

/**
 A dictionary mapping string attribute constants (see "Core Text String Attributes Reference") to
 their respective CF types (remember to use __bridge_transfer with CF types). For example:
 
     CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"HelveticaNeue", 14.0f, NULL);
     [attributeValues setObject:(__bridge_transfer id)fontRef forKey:(NSString*)kCTFontAttributeName];
 */
@property (nonatomic, strong) NSDictionary *attributeValues;

-(id) initWithTagName:(NSString*)tagName attributeValues:(NSDictionary*)attributeValues;

@end
