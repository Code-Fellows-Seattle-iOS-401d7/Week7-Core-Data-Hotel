//
//  BookViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/29/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//


#import "BookViewController.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "AutoLayout.h"
#import "ReservationService.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface BookViewController ()
@property(strong, nonatomic) UITextField *firstName;
@property(strong, nonatomic) UITextField *lastName;
@property(strong, nonatomic) UITextField *email;

@property(strong, nonatomic)ReservationService *reservationService;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.reservationService = [ReservationService shared];

//    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(20, 50, 100, 30);
//    [button setTitle:@"Crash" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

}

//- (IBAction)crashButtonTapped:(id)sender {
//    [[Crashlytics sharedInstance] crash];
//}


-(void)loadView {
    [super loadView];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setupMessageLabel];
    [self setupTextFields];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];


}

-(void)setupMessageLabel{
    UILabel *messageLabel = [[UILabel alloc]init];

    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;

    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:messageLabel];

    CGFloat myMargin = kstatusBarHeight;
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:messageLabel toView:self.view];
    leading.constant = myMargin;

    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:messageLabel toView:self.view];
    trailing.constant = -myMargin;

    [AutoLayout createGenericConstraintFrom:messageLabel toView:self.view withAttribute:NSLayoutAttributeCenterY];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];

    messageLabel.text = [NSString stringWithFormat:@"Reservation At:%@\nRoom:%i\nFrom: %@ - %@",
                         self.room.hotel.name,
                         self.room.number,
                         [formatter stringFromDate:self.startDate],
                         [formatter stringFromDate:self.endDate]];

}

-(void)setupTextFields {
    //create text fields
    self.firstName = [[UITextField alloc]init];
    self.firstName.placeholder = @"Please enter your first name";
    self.lastName = [[UITextField alloc]init];
    self.lastName.placeholder = @"Please enter your last name";
    self.email = [[UITextField alloc]init];
    self.email.placeholder = @"Please enter your email address";

    //I'll give the constraint flag
    [self.firstName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lastName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.email setTranslatesAutoresizingMaskIntoConstraints:NO];

    //add textfields to view
    [self.view addSubview:self.firstName];
    [self.view addSubview:self.lastName];
    [self.view addSubview:self.email];

    //Layout textfields - firstName
    CGFloat myMargin = kstatusBarHeight;
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + myMargin;

    NSLayoutConstraint *top =[AutoLayout createGenericConstraintFrom:self.firstName toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;

    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.firstName toView:self.view];
    leading.constant = myMargin;

    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.firstName toView:self.view];
    trailing.constant = -myMargin;

    //Layout textfields - lastName
    top =[AutoLayout createGenericConstraintFrom:self.lastName toView:self.firstName withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin + kstatusBarHeight;

    leading = [AutoLayout createLeadingConstraintFrom:self.lastName toView:self.view];
    leading.constant = myMargin;

    trailing = [AutoLayout createTrailingConstraintFrom:self.lastName toView:self.view];
    trailing.constant = -myMargin;

    //Layout textfields - email
    top =[AutoLayout createGenericConstraintFrom:self.email toView:self.lastName withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin + kstatusBarHeight;

    leading = [AutoLayout createLeadingConstraintFrom:self.email toView:self.view];
    leading.constant = myMargin;

    trailing = [AutoLayout createTrailingConstraintFrom:self.email toView:self.view];
    trailing.constant = -myMargin;

    [self.firstName becomeFirstResponder];

}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {

    if ([self.reservationService completeReservation:self.startDate andEndDate:self.endDate room:self.room guestFirstName:self.firstName.text guestLastName:self.lastName.text guestEmail:self.email.text]){
        [Answers logCustomEventWithName:@"Room booked" customAttributes:@{}];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //if we come here we're uncessfull creating reservation. Show a message.
    }
}

@end
