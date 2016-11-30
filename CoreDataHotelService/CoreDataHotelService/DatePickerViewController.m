//
//  DatePickerViewController.m
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/29/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AutoLayout.h"
#import "AvailabilityViewController.h"

@interface DatePickerViewController ()

@property(strong, nonatomic) UIDatePicker *startPicker;
@property(strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation DatePickerViewController


-(void)loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setUpDatePicker];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDatePicker];
    [self setTitle:@"Pick Leave Date:"];
}


-(void)setUpDatePicker{
    
    //Added start picker
    
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.startPicker];
    [self.view addSubview:self.endPicker];
    
    [self.startPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.endPicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Rearranged constraints
    
    [AutoLayout createTrailingConstraintFrom:self.startPicker toView:self.endPicker];
    [AutoLayout createLeadingConstraintFrom:self.startPicker toView:self.view];
    
    [AutoLayout createTrailingConstraintFrom:self.endPicker toView:self.view];
    [AutoLayout createLeadingConstraintFrom:self.endPicker toView:self.startPicker];
    
    
    
    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:self.endPicker toView:self.view withAttribute:NSLayoutAttributeTop];
    
    topConstraint.constant = [self navBarAndStatusBarHeight];
    
    
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender{
    
    //initialized start date picker
    
    NSDate *endDate = self.endPicker.date;
    NSDate *startDate = self.startPicker.date;
    
    if([[NSDate date]timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Uhh..?" message:@"Please Make Sure The End Date Is In The Future." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.endPicker.date = [NSDate date];
            
        }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    //made sure guest couldn't pick a date from the past as start date
    
    if([[NSDate date]timeIntervalSinceReferenceDate] < [startDate timeIntervalSinceReferenceDate]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Uhh...?" message:@"Please Make Sure The Start Date Is Either Today Or Later." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.startPicker.date = [NSDate date];
        }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc]init];
    
    availabilityVC.endDate = self.endPicker.date;
    
    [self.navigationController pushViewController:availabilityVC animated:YES];
}


-(CGFloat)navBarAndStatusBarHeight{
    return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0;
}





@end












