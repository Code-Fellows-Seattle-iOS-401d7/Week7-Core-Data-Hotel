//
//  AutoLayout.h
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/28/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import UIKit; this is optimized to include modules

//static const int kstatusBarHeight = 20;
static NSString *const MyThingNotificationKey = @"MyThingNotificationKey";

@interface AutoLayout : NSObject
//constant can't be changed, but the multiplier can be so we're taking the multiplier.
+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute: (NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute: (NSLayoutAttribute)attribute;

//autolayout constraint initializers
+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view;
+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView;
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView;
+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier;




@end
