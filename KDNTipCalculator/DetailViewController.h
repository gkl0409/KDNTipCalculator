//
//  DetailViewController.h
//  KDNTipCalculator
//
//  Created by kaden Chiang on 2015/6/10.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

