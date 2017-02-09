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
- (instancetype)initWithName:(NSString *)aFoo;
// - (instancetype)initWithNameAndHometown:(NSString *) aaa;

// - (void)first:(NSString *)fname second:(NSString *)mname third:(NSString *)lname;
// -(void)init:(NSString*)WithName :(NSString*)AndHometown;
-(void)init:(NSString*) nameValue withHometown:(NSString*) hometownValue;

@end
