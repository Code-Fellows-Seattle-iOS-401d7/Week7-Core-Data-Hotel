//
//  NSString+Common.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 12/4/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

-(NSString *)formatDateToString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];

    return [formatter stringFromDate:date];
}
@end
