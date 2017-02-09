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
        NSLog(@"xxx> Band init <xxx");
        NSLog(@"xxx> Band init <xxx");
        NSLog(@"xxx> Band init <xxx");
    }
    return self;
}
// - (instancetype)initWithName:(NSString *) nameValue AndHometown: (NSString *) hometownValue
// -(void)init:(NSString*)WithName :(NSString*)AndHometown;
// -(void)init:(NSString *)message withTitle:(NSString *)title;
-(void)init:(NSString*) nameValue withHometown:(NSString*) hometownValue
{
    NSLog(@"ooo> Band initWithName <ooo");
    _name = nameValue;
    _hometown = hometownValue;
    // _birthdate = NSDate();
    // return self;
}

+ (void)initialize
{
    if (self == [Band class]) {
        NSLog(@"xxx> Band initialize <xxx");
        NSLog(@"xxx> Band initialize <xxx");
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
    NSString* newString = [NSString stringWithFormat:@"\n\nBand: %@ \nHometown: %@ \nBirthdate: %@ \n\n",
                           _name, _hometown, _birthdate];
    return newString;
}
@end
