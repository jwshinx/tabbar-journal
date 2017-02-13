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

-(void)init:(NSString*) nameValue withHometown:(NSString*) hometownValue;

-(instancetype)initWithName:(NSString*)name;

-(instancetype)initWithNameAndHomeTown:(NSString *)name
                               homeTown:(NSString *)homeTown;

-(instancetype)initWithNameAndHomeTownAndBirthDate:(NSString *)name
                                           homeTown:(NSString *)homeTown
                                          birthDate:(NSDate *) birthDate;

@end
