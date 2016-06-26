//
//  AddSingerViewController.h
//  CoreDataDemo
//
//  Created by Trinity on 16/6/27.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddSingerViewControllerCloseState) {
    AddSingerViewControllerCloseStateCancel,
    AddSingerViewControllerCloseStateOK
};

@interface AddSingerViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic) AddSingerViewControllerCloseState closeState;
@end
