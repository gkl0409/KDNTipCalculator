//
//  MasterViewController.m
//  KDNTipCalculator
//
//  Created by kaden Chiang on 2015/6/10.
//
//

#import "MainViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

@property(nonatomic, weak) IBOutlet UITextField *billField;
@property(nonatomic, weak) IBOutlet UILabel *tipAmount;
@property(nonatomic, weak) IBOutlet UILabel *totalPrice;
@property float percentage;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.billField.delegate = self;
    self.percentage = 0.1f;

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
    float billAmount = [[self.billField.text substringFromIndex:1] floatValue];
    self.tipAmount.text = [[NSString alloc] initWithFormat:@"$%.2f", billAmount * self.percentage ];
    self.totalPrice.text = [[NSString alloc] initWithFormat:@"$%.2f", billAmount * (1+self.percentage) ];
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
