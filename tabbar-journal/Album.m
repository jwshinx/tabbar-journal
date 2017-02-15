//
//  Album.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/14/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Album.h"

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

-(NSString *)description
{
    NSString* newString = [NSString stringWithFormat:@"%@ - %i - %i",
                           _title, _year, _revenue];
    return newString;
    
}

@end
