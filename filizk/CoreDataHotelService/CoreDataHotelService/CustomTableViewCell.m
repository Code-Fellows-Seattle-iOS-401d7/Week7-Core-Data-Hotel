//
//  CustomTableViewCell.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 12/2/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "AutoLayout.h"

@implementation CustomTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        if (self) {
            self.hotelDetails = [[UILabel alloc]init];
            [self.hotelDetails setLineBreakMode:NSLineBreakByTruncatingTail];
            [self.hotelDetails setNumberOfLines:1];
            [self.hotelDetails setTextAlignment:NSTextAlignmentLeft];
            [self.hotelDetails setTextColor:[UIColor blackColor]];
            [self.hotelDetails setFont:[UIFont systemFontOfSize:14]];

         

            self.stayDetails = [[UILabel alloc]init];
            [self.stayDetails setLineBreakMode:NSLineBreakByTruncatingTail];
            [self.stayDetails setNumberOfLines:0];
            [self.stayDetails setTextAlignment:NSTextAlignmentLeft];
            [self.stayDetails setTextColor:[UIColor darkGrayColor]];
            [self.stayDetails setFont:[UIFont systemFontOfSize:14]];

            self.hotelDetails.translatesAutoresizingMaskIntoConstraints = NO;
            self.stayDetails.translatesAutoresizingMaskIntoConstraints = NO;

            [self.contentView addSubview:self.hotelDetails];
            [self.contentView addSubview:self.stayDetails];


            NSDictionary *views = @{@"hotelDetails": self.hotelDetails, @"stayDetails": self.stayDetails};
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[hotelDetails]|"
                                                                           options: 0
                                                                           metrics:nil
                                                                             views:views];
            [self.contentView addConstraints:constraints];
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[stayDetails]|"
                                                                           options: 0
                                                                           metrics:nil
                                                                             views:views];
            [self.contentView addConstraints:constraints];
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[stayDetails]|"
                                                                  options: 0
                                                                  metrics:nil
                                                                    views:views];
            [self.contentView addConstraints:constraints];



        }

    }

    return self;
}

//-(void)updateConstraints {
//
//    //this doesn't work ask why/
//}



@end
