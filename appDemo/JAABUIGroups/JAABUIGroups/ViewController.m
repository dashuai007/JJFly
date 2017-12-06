//
//  ViewController.m
//  JAABUIGroups
//
//  Created by xiazhongchong on 06/12/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CNContactPickerViewController *pVC = [[CNContactPickerViewController alloc] init];
    pVC.delegate = self;
    [self presentViewController:pVC animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@----%@", contact.namePrefix, contact.familyName);
    NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;
    [phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue<CNPhoneNumber*>  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@---%@", obj.label, obj.value.stringValue);
    }];
}



@end
