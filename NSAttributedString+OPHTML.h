//
//  NSAttributedString+OPHTML.h
//  NSAttributedString+OPHTML
//
//  Created by Brandon Williams on 4/8/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (OPHTML)

-(id) initWithHTML:(NSString*)html;
-(id) initWithHTML:(NSString*)html styles:(NSArray*)styles;

@end
