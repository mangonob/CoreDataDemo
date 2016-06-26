//
//  AddSingerViewController.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/27.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "AddSingerViewController.h"
#import "CoreDataDemo-Swift.h"

@interface AddSingerViewController ()
@property (weak, nonatomic) IBOutlet DWView *inputView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet DWTextField *detail;
@property (weak, nonatomic) IBOutlet DWTextField *birthday;
@property (weak, nonatomic) IBOutlet DWTextField *name;
@property (nonatomic) BOOL datePickerShown;
@property (nonatomic) BOOL keyboardShown;
@end

@implementation AddSingerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.inputView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHidden:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.detail.delegate =
    self.birthday.delegate =
    self.name.delegate = self;
    
    self.datePickerShown =
    self.keyboardShown = NO;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self animateInputView];
}

#pragma mark - Animation

-(void) animateInputView {
    CASpringAnimation *ani = [CASpringAnimation animationWithKeyPath:@"transform"];
    CASpringAnimation *ani2 = [CASpringAnimation animationWithKeyPath:@"position"];
    
    CATransform3D t = CATransform3DMakeScale(0.01, 0.01, 1.0);
    t = CATransform3DRotate(t, (M_PI / 180 * -180), 0, 0, 1);
    
    ani.fromValue = [NSValue valueWithCATransform3D:t];
    ani2.fromValue = [NSValue valueWithCGPoint:
                      CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0, 0.0)];
    
    ani.mass = ani2.mass = 0.4;
    ani.damping = ani2.damping = 10;
    ani.stiffness = ani2.stiffness = 100;
    
    ani.duration = ani2.duration = MAX(ani.settlingDuration, ani2.settlingDuration);
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.animations = @[ani, ani2];
    group.duration = ani.duration;
    
    [self.inputView.layer addAnimation:group forKey:@"ShowInputView"];
    self.inputView.hidden = NO;
    
}

-(void) animateDatePicker
{
    CASpringAnimation *ani = [CASpringAnimation animationWithKeyPath:@"position"];
    CGPoint p = self.datePicker.layer.position;
    p.y += self.datePicker.bounds.size.height;
    ani.fromValue = [NSValue valueWithCGPoint:p];
    
    ani.mass = 0.4;
    ani.damping = 10;
    ani.stiffness = 100;
    ani.duration = ani.settlingDuration;
    
    [self.datePicker.layer addAnimation:ani forKey:@"ShowDatePicker"];
    self.datePicker.hidden = NO;
}

-(void) animateHiddenDatePicker
{
    CASpringAnimation *ani = [CASpringAnimation animationWithKeyPath:@"position"];
    CGPoint p = self.datePicker.layer.position;
    p.y += self.datePicker.bounds.size.height;
    ani.toValue = [NSValue valueWithCGPoint:p];
    
    ani.mass = 0.4;
    ani.damping = 10;
    ani.stiffness = 100;
    ani.duration = ani.settlingDuration;
    
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    [self.datePicker.layer addAnimation:ani forKey:@"HiddenDatePicker"];
}

#pragma mark - Animation Delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@".");
    if(anim == [self.datePicker.layer animationForKey:@"HiddenDatePicker"]) {
        self.datePicker.hidden = YES;
        [self.datePicker.layer removeAnimationForKey:@"HiddenDatePicker"];
    }
}

#pragma mark - IBAction

- (IBAction)showDatePicker:(id)sender {
    if(self.keyboardShown && !self.datePickerShown) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    
    [self.datePicker.layer removeAllAnimations];
    if(!self.datePickerShown) {
        [self animateDatePicker];
    } else {
        [self animateHiddenDatePicker];
    }
    self.datePickerShown = !self.datePickerShown;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.name) {
        [self.birthday becomeFirstResponder];
    } else if (textField == self.birthday) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - KeyBoardAbout
-(void) keyboardDidHidden:(NSNotification *) notification
{
    NSLog(@"keyboard did hidden");
    self.keyboardShown = NO;
    NSDictionary *info = [notification userInfo];
}

-(void) keyboardWillShow:(NSNotification *) notification
{
    NSLog(@"keyboard will show");
    self.keyboardShown = YES;
    if (self.datePickerShown) {
        [self showDatePicker:nil];
    }
    NSDictionary *info = [notification userInfo];
}
#pragma mark - Other


@end




















































































