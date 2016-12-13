//
//  ViewController.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/28/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "AutoLayout.h"

#import "ViewController.h"
#import "HotelsVC.h"

#import "Hotel+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Hotel Manager"];
    
    [self setupCustomLayout];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setupCustomLayout{
    
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat buttonHeight = (self.view.frame.size.height - navigationBarHeight) / 3;
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse" andBackgroundColor:[UIColor colorWithRed:1.0
                                                                                                      green:1.0
                                                                                                       blue:0.76
                                                                                                      alpha:1.0]];
    
    UIButton *bookButton = [self createButtonWithTitle:@"Book" andBackgroundColor:[UIColor colorWithRed:1.0
                                                                                                  green:0.91
                                                                                                   blue:0.76
                                                                                                  alpha:1.0]];
    
    UIButton *lookupButton = [self createButtonWithTitle:@"Lookup" andBackgroundColor:[UIColor colorWithRed:0.85
                                                                                                      green:1.0
                                                                                                       blue:0.76
                                                                                                      alpha:1.0]];
    
    [AutoLayout createLeadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:browseButton toView:self.view];
    
    NSLayoutConstraint *browseButtonTopConstraint = [AutoLayout createGenericConstraintFrom:browseButton
                                                                                     toView:self.view
                                                                              withAttribute:NSLayoutAttributeTop];
    browseButtonTopConstraint.constant = navigationBarHeight;
    
    [AutoLayout createLeadingConstraintFrom:bookButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:bookButton toView:self.view];
    
    NSLayoutConstraint *bookButtonCenterY = [AutoLayout createGenericConstraintFrom:bookButton
                                                                             toView:self.view
                                                                      withAttribute:NSLayoutAttributeCenterY];
    
    bookButtonCenterY.constant = navigationBarHeight * 0.50; //Center Y Offset
    
    [AutoLayout createLeadingConstraintFrom:lookupButton toView:self.view];
    [AutoLayout createTrailingConstraintFrom:lookupButton toView:self.view];
    
    [AutoLayout createGenericConstraintFrom:lookupButton
                                     toView:self.view
                              withAttribute:NSLayoutAttributeBottom];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:browseButton
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutRelationEqual
                                                                       multiplier:1.0
                                                                         constant:buttonHeight];
    
    
    heightConstraint.active = YES;
    [browseButton addConstraint:heightConstraint];
    
    [AutoLayout createEqualHeightConstraintFrom:browseButton toView:bookButton];
    [AutoLayout createEqualHeightConstraintFrom:lookupButton toView:bookButton];
    
    
    [browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)browseButtonSelected:(UIButton *)sender{
    
    HotelsVC *hotelsVC = [[HotelsVC alloc]init];
    
    [self.navigationController pushViewController:hotelsVC animated:YES];
}


-(UIButton *)createButtonWithTitle:(NSString *)title andBackgroundColor:(UIColor *)color {
    
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    
    return button;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
