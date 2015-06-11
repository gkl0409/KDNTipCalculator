//
//  MasterViewController.m
//  KDNTipCalculator
//
//  Created by kaden Chiang on 2015/6/10.
//
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@property(nonatomic, weak) IBOutlet UITextField *billField;
@property(nonatomic, weak) IBOutlet UILabel *tipAmount;
@property(nonatomic, weak) IBOutlet UILabel *totalPrice;
@property(nonatomic, weak) IBOutlet UISegmentedControl *percentageSegmented;
@property NSMutableArray *percentageArray;
@property NSInteger preferPercentageIdx;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.billField.delegate = self;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [appDelegate defaults];
    NSArray *savedPercentageArray = [defaults objectForKey:@"savedPercentageArray"];
    NSInteger savedPreferPercentageIdx = [defaults integerForKey:@"savedPreferPercentageIdx"];
    
    if (savedPercentageArray == nil) {
        savedPercentageArray = @[@0.1, @0.15, @0.2];
        [defaults setObject:savedPercentageArray forKey: @"savedPercentageArray"];
        [defaults synchronize];
    }
    
    self.percentageArray = [NSMutableArray arrayWithArray:savedPercentageArray];
    [self.percentageSegmented setSelectedSegmentIndex:savedPreferPercentageIdx];
    
    for (NSInteger idx = 0; idx < [self.percentageArray count]; idx++) {
        NSInteger showPercentage = [[self.percentageArray objectAtIndex:idx] floatValue] * 100;
        NSLog(@"%ld", showPercentage);
        [self.percentageSegmented setTitle:[NSString stringWithFormat:@"%ld %%", showPercentage] forSegmentAtIndex: idx];
    }
    
    [self.percentageSegmented addTarget:self action:@selector(updateShowPrice) forControlEvents: UIControlEventValueChanged];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    UIBarButtonItem *fexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(billFieldDoneAction)];
    [toolBar setItems:@[fexibleSpace, doItem]];
    
    self.billField.inputAccessoryView = toolBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)billFieldDoneAction
{
    [self.billField resignFirstResponder];
    return YES;
}
    
- (IBAction)changeBillAction:(UITextField *)sender {
    [self updateShowPrice];
}

- (void) updateShowPrice
{
    float billAmount = [[self.billField.text substringFromIndex:1] floatValue];
    if (billAmount <= 0) return;
    float percentage = [[self.percentageArray objectAtIndex:[self.percentageSegmented selectedSegmentIndex]] floatValue];
    self.tipAmount.text = [[NSString alloc] initWithFormat:@"$%.2f", billAmount * percentage ];
    self.totalPrice.text = [[NSString alloc] initWithFormat:@"$%.2f", billAmount * (1+percentage)];
}

# pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setText:@"$"];
}

@end
