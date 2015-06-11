//
//  DetailViewController.m
//  KDNTipCalculator
//
//  Created by kaden Chiang on 2015/6/10.
//
//

#import "SettingViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@property(nonatomic, weak) IBOutlet UISegmentedControl *defalutPercentageSegmented;
@end

@implementation SettingViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [appDelegate defaults];

    [self.defalutPercentageSegmented addTarget:self action:@selector(saveDefaultSetting) forControlEvents:UIControlEventValueChanged];
    NSArray *savedPercentageArray = [defaults objectForKey: @"savedPercentageArray"];
    NSInteger savedPreferPercentageIdx = [defaults integerForKey:@"savedPreferPercentageIdx"];

    [self.defalutPercentageSegmented setSelectedSegmentIndex:savedPreferPercentageIdx];
    
    NSLog(@"savedPercentageArray: %@", savedPercentageArray);
    
    for (NSInteger idx = 0; idx < [savedPercentageArray count]; idx++) {
        NSInteger showPercentage = [[savedPercentageArray objectAtIndex:idx] floatValue] * 100;
        NSLog(@"%ld", showPercentage);
        [self.defalutPercentageSegmented setTitle:[NSString stringWithFormat:@"%ld %%", showPercentage] forSegmentAtIndex: idx];
    }
}

- (void)saveDefaultSetting
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [appDelegate defaults];
    [defaults setInteger:self.defalutPercentageSegmented.selectedSegmentIndex forKey:@"savedPreferPercentageIdx"];
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
