//
//  Band.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/8/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Band.h"

@implementation Band
- (Band*)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithNameAndHomeTown:(NSString *)name homeTown:(NSString *)homeTown;
{
    self = [super init];
    if (self) {
        _name = name;
        _hometown = homeTown;
    }
    return self;
}

- (instancetype)initWithNameAndHomeTownAndBirthDate:(NSString *)name homeTown:(NSString *)homeTown birthDate:(NSDate *)birthDate
{
    self = [super init];
    if (self) {
        _name = name;
        _hometown = homeTown;
        _birthdate = birthDate;
    }
    return self;
}

-(void)init:(NSString*) nameValue withHometown:(NSString*) hometownValue
{
    _name = nameValue;
    _hometown = hometownValue;
    // _birthdate = NSDate();
    // return self;
}

+ (void)initialize
{
    if (self == [Band class]) {
        NSLog(@"xxx> Band initialize <xxx");
    }
}

- (id)initWithString:(NSString *) name
{
    self = [super init];
    if (self) {
        _name = name;
        NSLog(@"Band initialized with name: %@.", name);
    }
    return self;
}

-(NSString *)description
{
    NSString* newString = [NSString stringWithFormat:@"%@ - %@ - %@",
                           _name, _hometown, _birthdate];
    return newString;
}
@end
