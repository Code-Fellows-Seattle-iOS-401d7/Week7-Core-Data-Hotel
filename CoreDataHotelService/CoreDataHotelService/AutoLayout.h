//
//  AutoLayout.h
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/28/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)createGenericConstraintFrom: (UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)activateFullViewContstraintsUsingVFLFor:(UIView *)view;
+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView;
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView;

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView;
+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier;

@end
