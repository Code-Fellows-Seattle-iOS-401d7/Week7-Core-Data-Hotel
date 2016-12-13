//
//  BookViewController.m
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/29/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "BookViewController.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "AutoLayout.h"


@interface BookViewController ()

@property(strong, nonatomic) UITextField *nameField;
@property(strong, nonatomic) UITextField *numberField;
@property(strong, nonatomic) UITextField *emailField;


@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpMessageLabel];
    [self setUpNameTextField];
    [self setUpPhoneNumberTextField];
    [self setUpEmailTextField];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                             target:self
                                                                                             action:@selector(saveButtonSelected:)]];
    
    
}


-(void)setUpMessageLabel{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:messageLabel];
    
    CGFloat myMargin = 20.0;
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:messageLabel toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:messageLabel toView:self.view];
    trailing.constant = -myMargin;
    
    [AutoLayout createGenericConstraintFrom:messageLabel toView:self.view withAttribute:NSLayoutAttributeCenterY];
    
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation At: %@\nRoom:%i\nFrom:Today - %@", self.room.hotel.name, self.room.number, self.endDate];
    
}

-(void)setUpNameTextField{
    self.nameField = [[UITextField alloc]init];
    
    self.nameField.placeholder =@"Please Enter Your Name..";
    
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.nameField];
    
    CGFloat myMargin = 20.0;
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20.0; //20 points for status bar
    
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.nameField toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.nameField toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.nameField toView:self.view];
    trailing.constant = -myMargin;
    
    [self.nameField becomeFirstResponder];
}


-(void)setUpPhoneNumberTextField{
    self.numberField = [[UITextField alloc]init];
    self.numberField.placeholder = @"Please Enter Your Telephone Number..";
    
    [self.numberField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.numberField];
    
    CGFloat myMargin = 20.0;
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.numberField toView:self.nameField];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.numberField toView:self.emailField];
    trailing.constant = -myMargin;
    
    
}


-(void)setUpEmailTextField{
    self.emailField = [[UITextField alloc]init];
    self.emailField.placeholder = @"Please Enter Your Email Address..";
    
    [self.emailField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emailField];
    
    CGFloat myMargin = 20.0;
    
    NSLayoutConstraint *leading = [AutoLayout createTrailingConstraintFrom:self.emailField toView:self.numberField];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.emailField toView:self.view];
    trailing.constant = -myMargin;
    
}


-(void)saveButtonSelected:(UIBarButtonItem *)sender{
    
    //edge case of empty text field.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
    reservation.startDate = [NSDate date];
    reservation.endDate = self.endDate;
    reservation.room = self.room;
    
    self.room.reservations = [self.room.reservations setByAddingObject:reservation];
    
    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.name = self.nameField.text;
    
    
    NSError *saveError;
    [context save:&saveError];
    
    if(saveError){
        NSLog(@"There was an error saving new reservation");
    } else {
        NSLog(@"Saved Reservation Successfully!");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}



@end
















