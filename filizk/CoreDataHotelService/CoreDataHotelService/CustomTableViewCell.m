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
            self.titleLabel = [[UILabel alloc]init];
            [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            [self.titleLabel setNumberOfLines:1];
            [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [self.titleLabel setTextColor:[UIColor blackColor]];
            [self.titleLabel setFont:[UIFont systemFontOfSize:14]];


            self.bodyLabel = [[UILabel alloc]init];
            [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            [self.bodyLabel setNumberOfLines:0];
            [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
            [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
            [self.bodyLabel setFont:[UIFont systemFontOfSize:14]];

            self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;

            [self.contentView addSubview:self.titleLabel];
            [self.contentView addSubview:self.bodyLabel];


             NSDictionary *views = @{@"titleLabel": self.titleLabel, @"bodyLabel": self.bodyLabel};
            NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[titleLabel]|"
                                                                           options: 0
                                                                           metrics:nil
                                                                             views:views];
            [self.contentView addConstraints:constraints];
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[bodyLabel]|"
                                                                           options: 0
                                                                           metrics:nil
                                                                             views:views];
            [self.contentView addConstraints:constraints];
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bodyLabel]|"
                                                                  options: 0
                                                                  metrics:nil
                                                                    views:views];
            [self.contentView addConstraints:constraints];



            [self update];
        }

    }

    return self;
}

-(void)update {

    //self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
