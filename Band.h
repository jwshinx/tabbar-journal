//
//  Band.h
//  tabbar-journal
//
//  Created by Joel Shin on 2/8/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Band : NSObject

@property NSString* name;
@property NSDate* birthdate;
@property NSString* hometown;

-(NSString*) description;

@end
