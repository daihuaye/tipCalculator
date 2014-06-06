//
//  TipViewController.m
//  tipcalculator
//
//  Created by daihua ye on 6/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property NSArray *tipValues;


- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)initTipValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)initTipValues {
    self.tipValues = @[@(0.1), @(0.15), @(0.2)];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int isInit;
    float tip1, tip2, tip3;
    isInit = [defaults integerForKey:@"Tip"];
    if (isInit) {
        tip1 = [defaults integerForKey:@"Tip.tip1"];
        tip2 = [defaults integerForKey:@"Tip.tip2"];
        tip3 = [defaults integerForKey:@"Tip.tip3"];
        self.tipValues = @[@(tip1), @(tip2), @(tip3)];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tipControl setTitle:[NSString stringWithFormat:@"%@%%", self.tipValues[0]] forSegmentAtIndex:0];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%@%%", self.tipValues[1]] forSegmentAtIndex:1];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%@%%", self.tipValues[2]] forSegmentAtIndex:2];
    [self updateValues];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTipValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];

    float tipAmount = billAmount * [self.tipValues[self.tipControl.selectedSegmentIndex] floatValue] * 0.01;
    
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end
