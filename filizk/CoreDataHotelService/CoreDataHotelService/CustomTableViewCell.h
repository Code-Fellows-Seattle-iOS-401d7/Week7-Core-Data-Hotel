//
//  CustomTableViewCell.h
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 12/2/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

- (void)update;
@end
