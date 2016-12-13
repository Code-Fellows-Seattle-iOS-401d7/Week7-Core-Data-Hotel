//
//  DatePickerVC.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/29/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//
#import "BookVC.h"
#import "DatePickerVC.h"
#import "AvailabilityVC.h"
#import "AutoLayout.h"

@interface DatePickerVC ()

@property(strong, nonatomic) UIDatePicker *startPicker;
@property(strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation DatePickerVC

-(void)loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]]; //setting background color to enable fluidity b/w pushing controllers
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(doneButtonSelected:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self setupStartDatePicker];
    [self setupEndDatePicker];
    [self startDateLabel];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"Dates"];
}

-(void)startDateLabel {
    UILabel *startDateLabel = [[UILabel alloc]init];
    [startDateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:startDateLabel];
    
    startDateLabel.textAlignment = NSTextAlignmentCenter; //give text alignment of center by assigning from enum
    startDateLabel.numberOfLines = 1;
    startDateLabel.text = @"Select start date";
    startDateLabel.backgroundColor = [UIColor magentaColor];
    
    [AutoLayout createLeadingConstraintFrom:startDateLabel
                                     toView:self.view];
    [AutoLayout createTrailingConstraintFrom:startDateLabel
                                      toView:self.view];
    
    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:startDateLabel toView:self.view withAttribute:NSLayoutAttributeTop];
    topConstraint.constant = [self navBarAndStatusBarHeight];
}

-(void)setupStartDatePicker {
    self.startPicker = [[UIDatePicker alloc]init];
    
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.startPicker]; //adding subview must come before the constraints
    
    [self.startPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [AutoLayout createTrailingConstraintFrom:self.startPicker
                                      toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.startPicker
                                     toView:self.view];
    
    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:self.startPicker
                                                                         toView:self.view
                                                                  withAttribute:NSLayoutAttributeTop];
    
    topConstraint.constant = [self navBarAndStatusBarHeight];
}

-(void)setupEndDatePicker {
    self.endPicker = [[UIDatePicker alloc]init];
    
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.endPicker]; //adding subview must come before the constraints
    
    [self.endPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [AutoLayout createTrailingConstraintFrom:self.endPicker
                                      toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.endPicker
                                     toView:self.view];
    
    NSLayoutConstraint *bottomConstraint = [AutoLayout createGenericConstraintFrom:self.endPicker
                                                                            toView:self.view
                                                                     withAttribute:NSLayoutAttributeBottom];
    
    bottomConstraint.constant = 0;
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender {
    NSDate *startDate = self.startPicker.date;
    NSDate *endDate = self.endPicker.date;
    
    if ([[NSDate date]timeIntervalSinceReferenceDate] > [startDate timeIntervalSinceReferenceDate] || [endDate timeIntervalSinceReferenceDate] < [startDate timeIntervalSinceReferenceDate]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Huh..."
                                                                                 message:@"Please make sure the start date is in the future and the end date is at least 1 day after your start date."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             self.startPicker.date = [NSDate date];
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    AvailabilityVC *availabilityVC = [[AvailabilityVC alloc]init];
    availabilityVC.startDate = self.startPicker.date;
    availabilityVC.endDate = self.endPicker.date;
    [self.navigationController pushViewController:availabilityVC animated:YES];
}

-(CGFloat)navBarAndStatusBarHeight {
    return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
}

@end
