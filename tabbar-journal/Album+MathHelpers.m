//
//  Album+MathHelpers.m
//  tabbar-journal
//
//  Created by Joel Shin on 2/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

#import "Album+MathHelpers.h"

@implementation Album (MathHelpers)

-(int) yearsSincePublished:(int)value;
{
    NSDate *today = [[NSDate alloc] init];
    if(today != nil) {
        NSDateComponents *components = [
            [NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:today];
        // long int day = [components day];
        // long int month = [components month];
        long int year = [components year];
        // NSLog(@"today year: %li month: %li day: %li value: %i", year, month, day, value);
        return (int)year - value;
    } else {
        return value;
    }
}
@end
 /*
 // ====================================================================
 // === string date converted to date object; get year, month, day");
 // ====================================================================
 NSString *birthday = @"06/15/1977";
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 [formatter setDateFormat:@"MM/dd/yyyy"];
 NSDate *date = [formatter dateFromString:birthday];
 NSLog(@"date: %@ ", date);
 if(date!=nil) {
     NSInteger age = [date timeIntervalSinceNow]/31556926;
     NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
     long int day = [components day];
     long int month = [components month];
     long int year = [components year];
 
     NSLog(@"Day:%li Month:%li Year:%li Age:%li",day,month,year,age);
 }
 */
