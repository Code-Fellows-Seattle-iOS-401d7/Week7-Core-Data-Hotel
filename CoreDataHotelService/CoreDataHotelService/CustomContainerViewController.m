//
//  CustomContainerViewController.m
//  CoreDataHotelService
//
//  Created by Corey Malek on 12/12/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "CustomContainerViewController.h"

CGFloat kBurgerOpenScreenBoundary = 0.33; // represents 33%
CGFloat kBurgerMenuWidth = 0.5; //represents 50%

CGFloat kBurgerImageWidth = 50.0; //represents points, burger button
CGFloat kBurgerImageHeight = 50.0; //represents points, burger button

NSTimeInterval kAnimationSlideMenuOpenTime = 0.25; //represents quarter of a second
NSTimeInterval kAnimationSlideMenuCloseTime = 0.15; //represents 15% of a second

@interface CustomContainerViewController ()<UITableViewDelegate>

@property(strong, nonatomic) NSArray *viewControllers;
@property(strong, nonatomic) UIViewController *topViewController;

@property(strong, nonatomic) UIButton *burgerButton;
@property(strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation CustomContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *firstController = [self.storyboard instantiateViewControllerWithIdentifier:@"HotelVC"];
    UIViewController *secondController = [self.storyboard instantiateViewControllerWithIdentifier:@"BookVC"];
    UIViewController *thirdController = [self.storyboard instantiateViewControllerWithIdentifier:@"LookupVC"];
    
    
    self.viewControllers = @[firstController, secondController, thirdController];
    self.topViewController = self.viewControllers.firstObject;
    
    UITableViewController *menuTableController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTable"];
    
    
    [self setUpChildController:menuTableController];
    [self setUpChildController:firstController];
    
    menuTableController.tableView.delegate = self;
    
    [self setUpBurgerButton];
    [self setUpPanGesture];
    
}


-(void)setUpChildController:(UIViewController *)childViewController{
    
    [self addChildViewController:childViewController];
    childViewController.view.frame = self.view.frame;
    
    
    [self.view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
    
    
}


-(void)setUpBurgerButton{
    CGFloat padding = 20.0;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(padding, padding, kBurgerImageWidth, kBurgerImageHeight )];
    
    [button setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    [self.topViewController.view addSubview: button];
    
    [button addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.burgerButton = button;
    
}


-(void)setUpPanGesture{
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(topViewControllerPanned:)];
    [self.topViewController.view addGestureRecognizer:self.panGesture];
    
}


-(void)topViewControllerPanned:(UIPanGestureRecognizer *)sender{
    CGPoint velocity = [sender velocityInView:self.topViewController.view];
    CGPoint translation = [sender translationInView:self.topViewController.view];
    
    NSLog(@"%f", velocity.x);
    NSLog(@"%f", translation.x);
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        
        if (translation.x >= 0) {
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.view.center.y);
            [sender setTranslation:CGPointZero inView:self.topViewController.view];
            
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        __weak typeof(self) bruce = self;
        
        if (self.topViewController.view.frame.origin.x > self.view.frame.size.width * kBurgerOpenScreenBoundary) {
            
            
            [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
                __strong typeof(bruce) hulk = bruce;
                hulk.topViewController.view.center = CGPointMake(hulk.view.center.x / kBurgerMenuWidth, hulk.view.center.y);
                
            } completion:^(BOOL finished) {
                __strong typeof(bruce) hulk = bruce;
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:hulk action:@selector(tapToCloseMenu:)];
                
                [hulk.topViewController.view addGestureRecognizer:tapGesture];
                hulk.burgerButton.userInteractionEnabled = NO;
                
            }];
            
        } else {
            [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
                __strong typeof(bruce) hulk = bruce;
                
                hulk.topViewController.view.center = hulk.view.center;
                
            }];
        }
        
    }
}

//MARK: button Methods:

-(void)burgerButtonPressed:(UIButton *)sender{
    
    __weak typeof(self) bruceBanner = self;
    
    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
        
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        hulk.topViewController.view.center = CGPointMake(hulk.view.center.x / kBurgerMenuWidth, hulk.view.center.y);
        
    } completion:^(BOOL finished) {
        
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc]initWithTarget:hulk action:@selector(tapToCloseMenu:)];
        
        [hulk.topViewController.view addGestureRecognizer:tapToClose];
        
        sender.userInteractionEnabled = NO;
        
    }];
}


-(void)tapToCloseMenu:(UITapGestureRecognizer *)sender{
    
    [self.topViewController.view removeGestureRecognizer:sender];
    
    __weak typeof(self) bruceBanner = self;
    
    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
        
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        hulk.topViewController.view.center = hulk.view.center;
        
    } completion:^(BOOL finished) {
        
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        hulk.burgerButton.userInteractionEnabled = YES;
        
    }];
}

//MARK: UITableViewDelegate:
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *newTopViewController = self.viewControllers[indexPath.row];
    
    __weak typeof(self) bruceBanner = self;
    
    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        hulk.topViewController.view.frame = CGRectMake(hulk.view.frame.size.width, hulk.view.frame.origin.y, hulk.view.frame.size.width, hulk.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        __strong typeof(bruceBanner) hulk = bruceBanner;
        
        CGRect oldFrame = hulk.topViewController.view.frame;
        
        [hulk.topViewController willMoveToParentViewController:nil];
        [hulk.topViewController.view removeFromSuperview];
        [hulk.topViewController removeFromParentViewController];
        
        [hulk setUpChildController:newTopViewController];
        
        newTopViewController.view.frame = oldFrame;
        
        hulk.topViewController = newTopViewController;
        
        [hulk.burgerButton removeFromSuperview];
        [hulk.topViewController.view addSubview:hulk.burgerButton];
        
        [UIView animateWithDuration:kAnimationSlideMenuCloseTime animations:^{
            hulk.topViewController.view.frame = hulk.view.frame;
            
        } completion:^(BOOL finished) {
            [hulk.topViewController.view addGestureRecognizer:hulk.panGesture];
            hulk.burgerButton.userInteractionEnabled = YES;
            
        }];
    }];
    
}



















@end
