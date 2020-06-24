//
//  ViewController.m
//  TipTap
//
//  Created by Andres Barragan on 23/06/20.
//  Copyright © 2020 Andres Barragan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *tipTotalView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfPersonsControl;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.tipControl setSelectedSegmentIndex:[defaults integerForKey:@"default_tip"]];
    [self onEdit:self];
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}
- (IBAction)onEdit:(id)sender {
    double bill = [self.billField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    long numberOfPersons = self.numberOfPersonsControl.selectedSegmentIndex + 2;
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    double totalPersonQuantity = total/numberOfPersons;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    self.totalPerPerson.text = [NSString stringWithFormat:@"$%.2f", totalPersonQuantity];
}

- (IBAction)onEditingBegin:(id)sender {
    CGRect newFrame = self.tipTotalView.frame;
    newFrame.origin.y += 300;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tipTotalView.frame = newFrame;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipLabel.alpha = 0;
    }];
}

- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.tipTotalView.frame;
    newFrame.origin.y -= 300;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tipTotalView.frame = newFrame;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipLabel.alpha = 1;
    }];
}

@end
