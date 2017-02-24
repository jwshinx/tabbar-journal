//
//  Band.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/8/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Band.h"

@interface Band ()

@property NSString* hometown;

@end

@implementation Band
- (Band*)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)addAlbum:(Album*)album
{
    // _discography = [NSMutableArray arrayWithObjects: @"Album1", @"Album2", album.title, nil];
    [_discography addObject:album];
}

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithNameAndHomeTown:(NSString *)name homeTown:(NSString *)homeTown
{
    self = [super init];
    if (self) {
        _name = name;
        _hometown = homeTown;
        _discography = [[NSMutableArray alloc] init];
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
        // _discography = [];
        _discography = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)init:(NSString*) nameValue withHometown:(NSString*) hometownValue
{
    _name = nameValue;
    _hometown = hometownValue;
    _discography = [[NSMutableArray alloc] init];
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
-(NSString *)manager
{
    return @"Big Vito";
}
-(NSString *)description
{
    NSString* newString = [NSString stringWithFormat:@"%@ - %@ - %@ - %@",
                           _name, _hometown, _birthdate, self.manager];
    return newString;
}
@end
