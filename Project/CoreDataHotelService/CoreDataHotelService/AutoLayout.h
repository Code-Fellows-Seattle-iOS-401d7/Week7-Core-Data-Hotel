//
//  AutoLayout.h
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/28/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

@import UIKit;

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view;
+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView; //would be used if not using VFL

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView; //leading constraint
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView; //trailing constraint

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView; //equal height constraint
+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier;

@end
