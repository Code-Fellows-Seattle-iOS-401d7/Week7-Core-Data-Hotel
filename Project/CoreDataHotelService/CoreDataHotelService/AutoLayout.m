//
//  AutoLayout.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/28/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "AutoLayout.h"

@implementation AutoLayout

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier {
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:superView
                                                                  attribute:attribute
                                                                 multiplier:multiplier
                                                                   constant:0.0];
    
    constraint.active = YES;
    
    return constraint;
}

+(NSLayoutConstraint *)createGenericConstraintFrom:(UIView *)view toView:(UIView *)superView withAttribute:(NSLayoutAttribute)attribute {
    
    return [AutoLayout createGenericConstraintFrom:view
                                            toView:superView
                                     withAttribute:attribute
                                     andMultiplier:1.0];
}

+(NSArray *)activateFullViewConstraintsUsingVFLFor:(UIView *)view {
    NSArray *constraints = [[NSArray alloc] init];
    
    NSDictionary *viewDict = @{@"view": view};
    
    // VFL //
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDict];
    //only difference here is horizontal and vertical (H: , V:)
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:viewDict];
    
    constraints = [constraints arrayByAddingObjectsFromArray:horizontalConstraints]; //now has horizontal constraints
    constraints = [constraints arrayByAddingObjectsFromArray:verticalConstraints]; //now has vertical constraints
    
    [NSLayoutConstraint activateConstraints:constraints]; // activate all constraints
    
    return constraints;
}

+(NSArray *)activateFullViewConstraintsFrom:(UIView *)view toView:(UIView *)superView {
    
    NSMutableArray *constraints = [[NSMutableArray alloc]init];
    
    NSLayoutConstraint *leadingConstraint = [AutoLayout createGenericConstraintFrom:view
                                                                             toView:superView
                                                                      withAttribute:NSLayoutAttributeLeading];
    
    NSLayoutConstraint *trailingConstraint = [AutoLayout createGenericConstraintFrom:view
                                                                              toView:superView
                                                                       withAttribute:NSLayoutAttributeTrailing];
    
    NSLayoutConstraint *topConstraint = [AutoLayout createGenericConstraintFrom:view
                                                                         toView:superView
                                                                  withAttribute:NSLayoutAttributeTop];
    
    NSLayoutConstraint *bottomConstraint = [AutoLayout createGenericConstraintFrom:view
                                                                            toView:superView
                                                                     withAttribute:NSLayoutAttributeBottom];
    
    [constraints addObject:leadingConstraint];
    [constraints addObject:trailingConstraint];
    [constraints addObject:topConstraint];
    [constraints addObject:bottomConstraint];
    
    return constraints.copy;
}

+(NSLayoutConstraint *)createLeadingConstraintFrom:(UIView *)view toView:(UIView *)superView { //leading constraint
    return [AutoLayout createGenericConstraintFrom:view
                                            toView:superView
                                     withAttribute:NSLayoutAttributeLeading];
}
+(NSLayoutConstraint *)createTrailingConstraintFrom:(UIView *)view toView:(UIView *)superView { //trailing constraint
    return [AutoLayout createGenericConstraintFrom:view
                                            toView:superView
                                     withAttribute:NSLayoutAttributeTrailing];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView { //equal height constraint
    return [AutoLayout createGenericConstraintFrom:view
                                            toView:otherView
                                     withAttribute:NSLayoutAttributeHeight];
}

+(NSLayoutConstraint *)createEqualHeightConstraintFrom:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier {
    return [AutoLayout createGenericConstraintFrom:view
                                            toView:otherView
                                     withAttribute:NSLayoutAttributeHeight
                                     andMultiplier:multiplier];
}

@end
