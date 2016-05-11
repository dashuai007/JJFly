//
//  ViewController.m
//  JJFlyViewTransitions
//
//  Created by John on 5/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *frontView;
@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UIBarButtonItem *fadeButton;
@property (nonatomic, strong) UIBarButtonItem *flipButton;
@property (nonatomic, strong) UIBarButtonItem *bounceButton;

@property (nonatomic, strong) NSArray *priorConstraints;

@end
static NSTimeInterval timeInterVal = 0.3;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSMutableArray *toolbarButtons = [NSMutableArray arrayWithObjects: flexItem, self.fadeButton, flexItem,self.flipButton, flexItem,nil];
    if ([[UIView class]  respondsToSelector:@selector(animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)]) {
        [toolbarButtons addObject:self.bounceButton];
    }
    [toolbarButtons addObject:flexItem];
    
    self.toolbarItems = toolbarButtons;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    [self.view addSubview:self.frontView];
    
    _priorConstraints = [self constrainSubview:self.frontView toMatchWithSuperview:self.view];
    
   
    
}





- (void)performTransition:(UIViewAnimationOptions)options {
    UIView *fromView, *toView;
    if (self.frontView.superview != nil) {
        fromView = self.frontView;
        toView = self.backView;
    } else {
        fromView = self.backView;
        toView = self.frontView;
    }
    
    NSArray *priorConstraints = self.priorConstraints;
    [UIView transitionFromView:fromView toView:toView duration:timeInterVal options:options completion:^(BOOL finished) {
        if (priorConstraints != nil) {
            [self.view removeConstraints:priorConstraints];
        }
    }];
    
    _priorConstraints = [self constrainSubview:toView toMatchWithSuperview:self.view];
}


#pragma mark - NSLayoutConstraint
// makes "subview" match the width and height of "superview" by adding the proper auto layout constraints

- (NSArray *)constrainSubview:(UIView *)subview toMatchWithSuperview:(UIView *)superview {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(subview);
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|" options:0 metrics:nil views:viewsDictionary];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:0 metrics:nil views:viewsDictionary]];
    [superview addConstraints:constraints];
    
    return constraints;
}



#pragma mark - button and view

- (UIImageView *)frontView {
    if (!_frontView) {
        self.frontView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _frontView.image = [UIImage imageNamed:@"image1.jpg"];
    }
    return _frontView;
}

- (UIImageView *)backView {
    if (!_backView) {
        self.backView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.image = [UIImage imageNamed:@"image2.jpg"];
    }
    return _backView;
}

- (UIBarButtonItem *)fadeButton {
    if (!_fadeButton) {
        self.fadeButton = [[UIBarButtonItem alloc] initWithTitle:@"fade" style:UIBarButtonItemStylePlain target:self action:@selector(fadeAction:)];
    }
    return _fadeButton;
}

- (UIBarButtonItem *)flipButton {
    if (!_flipButton) {
        self.flipButton = [[UIBarButtonItem alloc] initWithTitle:@"flip" style:UIBarButtonItemStylePlain target:self action:@selector(flipAction:)];
    }
    return _flipButton;
}

- (UIBarButtonItem *)bounceButton {
    if (!_bounceButton) {
        self.bounceButton = [[UIBarButtonItem alloc] initWithTitle:@"bounce" style:UIBarButtonItemStylePlain target:self action:@selector(bounceAction:)];
    }
    return _bounceButton;
}

#pragma mark - action
- (void)fadeAction:(UIButton *)btn {
    [self performTransition:UIViewAnimationOptionTransitionCrossDissolve];
}

- (void)flipAction:(UIButton *)btn {
    UIViewAnimationOptions options = ([self.frontView superview] != nil) ?
    UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [self performTransition:options];
}

- (void)bounceAction:(UIButton *)btn {
    if ([[UIView class] respondsToSelector:
         @selector(animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)]) {
        self.navigationController.toolbar.userInteractionEnabled = NO;
        
        UIView *fromView, *toView;
        if (self.frontView.superview != nil) {
            fromView = self.frontView;
            toView = self.backView;
        } else {
            fromView = self.backView;
            toView = self.frontView;
        }
        
        CGRect startFrame = self.view.frame;
        CGRect endFrame = self.view.frame;
        
        startFrame.origin.y = - startFrame.size.height;
        endFrame.origin.y = 0;
        toView.frame = startFrame;
        
        NSArray *priorConstraints = self.priorConstraints;
        [self.view addSubview:toView];
        
        [UIView animateWithDuration:1.0f
                              delay:0
             usingSpringWithDamping:0.5 initialSpringVelocity:9
                            options:0
                         animations:^{
                             toView.frame = endFrame;
                         } completion:^(BOOL finished) {
                             if (priorConstraints != nil) {
                                 [self.view removeConstraints:priorConstraints];
                                 [fromView removeFromSuperview];
                                 self.navigationController.toolbar.userInteractionEnabled = YES;
                             }
                         }];
        _priorConstraints = [self constrainSubview:toView toMatchWithSuperview:self.view];
        
    }
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
