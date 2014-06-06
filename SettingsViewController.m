//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by daihua ye on 6/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
- (IBAction)onTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tip1;
@property (weak, nonatomic) IBOutlet UITextField *tip2;
@property (weak, nonatomic) IBOutlet UITextField *tip3;

- (void)updateTips;
- (void)initTips;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTips];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tip1, tip2, tip3;
    int isInit = [defaults integerForKey:@"Tip"];
    if (isInit) {
        tip1 = [defaults integerForKey:@"Tip.tip1"];
        tip2 = [defaults integerForKey:@"Tip.tip2"];
        tip3 = [defaults integerForKey:@"Tip.tip3"];
    } else {
        tip1 = 10;
        tip2 = 15;
        tip3 = 20;
    }
    
    self.tip1.text = [NSString stringWithFormat:@"%d", tip1];
    self.tip2.text = [NSString stringWithFormat:@"%d", tip2];
    self.tip3.text = [NSString stringWithFormat:@"%d", tip3];
}

- (void)updateTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"Tip"];
    [defaults setInteger:[self.tip1.text integerValue] forKey:@"Tip.tip1"];
    [defaults setInteger:[self.tip2.text integerValue] forKey:@"Tip.tip2"];
    [defaults setInteger:[self.tip3.text integerValue] forKey:@"Tip.tip3"];
    [defaults synchronize];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateTips];
}
@end
