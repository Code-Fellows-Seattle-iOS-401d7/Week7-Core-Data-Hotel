//
//  AutoLayout.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/28/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "AutoLayout.h"

int gGlobalVar = 0;
@implementation AutoLayout

//constant can't be changed, but the multiplier can be so we're taking the multiplier.
+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute: (NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier{

    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:view
                                      attribute:attribute
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                      attribute:attribute
                                      multiplier:multiplier
                                      constant:0.0];

    constraint.active = YES;


    return constraint;

}

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute: (NSLayoutAttribute)attribute{

    NSLayoutConstraint *constraint = [AutoLayout createGenericConstraintFrom:view
                                                                      toView:superView
                                                               withAttribute:attribute
                                                               andMultiplier:1.0];
   
    return constraint;
}

//autolayout constraint initializers
//VFL is more error prone.
//You can't do center X and y using VFL
//If you have a good idea what the cosntraints are and same number for leading/trailing constraint then use VFL(like you have 6 buttons with top space being 10pt).
+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view{
    NSArray *constraints = [[NSArray alloc]init];

    NSDictionary *viewDictionary = @{@"view": view };

    NSArray *horizantalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewDictionary];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewDictionary];

    //constaints were NSMutableArray but the return value from below is a NSArray (meaning that a new array is created not mutated the original array) so we change constraints to NSArray. NSMutableArray is subclass of NSarray with added functionality of add and remove (and append, etc) meaning "mutating" of the array.
    constraints = [constraints arrayByAddingObjectsFromArray:horizantalConstraints];
    constraints = [constraints arrayByAddingObjectsFromArray:verticalConstraints];

    //this method call activates the constraints
    [NSLayoutConstraint activateConstraints:constraints];

    return constraints;

}
//This is not using VFL, it's using some other mechanism.
+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView{
    NSMutableArray *constraints = [[NSMutableArray alloc]init];

    NSLayoutConstraint *leadingConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeLeading];

    NSLayoutConstraint *trailingConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTrailing];

    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTop];
    NSLayoutConstraint *bottomConstraint = [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeBottom];

    [constraints addObject:leadingConstraint];
    [constraints addObject:trailingConstraint];
    [constraints addObject:topConstraint];
    [constraints addObject:bottomConstraint];

    return constraints.copy;

}

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView{
    return [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeLeading];

}
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView{
    return [AutoLayout createGenericConstraintFrom:view toView:superView withAttribute:NSLayoutAttributeTrailing];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView{
    return [AutoLayout createGenericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier{
    return [AutoLayout createGenericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight andMultiplier: multiplier];
}

//+(NSString *)bar{
//    if (!_bar){
//        _bar = @"Test";
//    } else {
//
//    }
//
//    return _bar;
//}



@end
