//
//  Band.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/8/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Band.h"

@implementation Band
+ (void)initialize
{
    if (self == [Band class]) {
        NSLog(@"xxx> Band init <xxx");
        NSLog(@"xxx> Band init <xxx");
        NSLog(@"xxx> Band init <xxx");
        NSLog(@"xxx> Band init <xxx");
    }
}
-(NSString *)description
{
    NSString* newString = [NSString stringWithFormat:@"\n\nBand: %@ \nHometown: %@ \nBirthdate: %@ \n\n",
                           _name, _hometown, _birthdate];
    return newString;
}
@end
