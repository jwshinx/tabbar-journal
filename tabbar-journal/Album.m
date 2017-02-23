//
//  Album.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/14/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Album.h"
#import "Album_PrivateProperties.h"

@implementation Album

-(instancetype)initWithTitleAndYear:(NSString *)title
                               year:(int)year
{
    self = [super init];
    if (self) {
        _title = title;
        _year = year;
    }
    return self;
}

-(instancetype)initWithTitleAndYearAndRevenue:(NSString *)title
                                         year:(int)year
                                      revenue:(int) revenue
{
    self = [super init];
    if (self) {
        _title = title;
        _year = year;
        _revenue = revenue;
    }
    return self;
}

// not in header file. private method.
-(NSString *)greeting
{
    return @"Hello";
}

-(NSString *)description
{
    NSString* hello = self.greeting;
    NSString* newString = [NSString stringWithFormat:@"%@, %@ (%i) $%iM",
                            self.greeting, _title, _year, _revenue];
    return newString;
    
}

@end
