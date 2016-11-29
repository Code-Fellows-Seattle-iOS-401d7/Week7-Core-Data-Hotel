//
//  DatePickerViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/29/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AutoLayout.h"
#import "AvailabilityViewController.h"

@interface DatePickerViewController ()

@property(strong, nonatomic)UIDatePicker *endPicker;
@property(strong, nonatomic)UIDatePicker *startPicker;

@end

@implementation DatePickerViewController

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupDatePicker];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)];

    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupDatePicker {
    self.endPicker = [[UIDatePicker alloc]init];
    //set up the mode to show the date
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;

    //add picker to subview
    [self.view addSubview:self.endPicker];
    [self.view addSubview:self.startPicker];

    //don't take the autoresizing masks and constraints, I'm going to give it constrainst
    [self.endPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.startPicker setTranslatesAutoresizingMaskIntoConstraints:NO];

    //Date Picker - startDate(TO-DO make 20 a constant value - need static?)
    CGFloat topSpaceForPicker = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0 ;// 20 is the status bar height.
    [AutoLayout createTrailingConstraintFrom:self.startPicker toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.startPicker toView:self.view];

    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:self.startPicker toView:self.view withAttribute:NSLayoutAttributeTop];
    topConstraint.constant = topSpaceForPicker;

    //Date Picker - end date
    [AutoLayout createTrailingConstraintFrom:self.endPicker toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.endPicker toView:self.view];

    topConstraint = [AutoLayout createGenericConstraintFrom:self.endPicker toView:self.startPicker withAttribute:NSLayoutAttributeTop];

    topConstraint.constant = self.startPicker.frame.size.height + topSpaceForPicker + 20;

}

-(void)doneButtonSelected:(UIBarButtonItem *)sender {
    NSDate *endDate = self.endPicker.date;
    NSDate *startDate = self.startPicker.date;

    //this is how we do date comparisons
    //if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
    if (([startDate timeIntervalSinceReferenceDate] < [[NSDate date] timeIntervalSinceReferenceDate]) ||
    ([startDate timeIntervalSinceReferenceDate] >= [endDate timeIntervalSinceReferenceDate])) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Huh..."
                                                                                 message: @"Please make sure end date is in the future."
                                                                          preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            self.endPicker.date = [NSDate date];
        }];

        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }

    AvailabilityViewController *availVC = [[AvailabilityViewController alloc]init];
    availVC.endDate = self.endPicker.date;
    availVC.startDate = self.startPicker.date;
    [self.navigationController pushViewController:availVC animated:YES];


}

@end
