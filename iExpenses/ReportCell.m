//
//  ReportCell.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "ReportCell.h"
#import "Field.h"

@implementation ReportCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReportValues:(Form *)form
{
    for (Field *field in form.arrFields)
    {
        switch (field.fieldType)
        {
            case kDateField:
                [self.lblDate setText:field.strFieldValue];
                break;
            case kItemField:
                [self.lblItems setText:field.strFieldValue];
                break;
            case kAmountField:
                [self.lblAmount setText:[NSString stringWithFormat:@"RS %@",field.strFieldValue]];
                break;
            case kModeField:
                 if (field.bIsCreditCard)
                 {
                     [self.lblMode setText:@"Credit card payment"];
                 }
                else
                {
                    [self.lblMode setText:@"Cash payment"];
                }
                break;
            default:
                break;
        }
    }
}

@end
