//
//  ReportCell.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"

@interface ReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblItems;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMode;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;

- (void)setReportValues:(Form *)form;

@end
