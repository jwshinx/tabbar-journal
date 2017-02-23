//
//  Album.h
//  tabbar-journal
//
//  Created by Joel Shin on 2/14/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property NSString* title;
@property int year;
@property (readonly) int revenue;

-(instancetype)initWithTitleAndYear:(NSString *)title
                               year:(int)year;

-(instancetype)initWithTitleAndYearAndRevenue:(NSString *)title
                                         year:(int)year
                                      revenue:(int) revenue;

@end
