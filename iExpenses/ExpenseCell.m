//
//  ExpenseCell.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "ExpenseCell.h"
#import "Expense.h"

const NSInteger iCashTag = 1;
const NSInteger iCreditCardTag = 2;

@interface ExpenseCell()<DatePickerDelegate,UITextFieldDelegate>
{
    Field *field;
    UILabel *lblName;
    UIButton *btnDate;
    UITextField *txtValue;
    UIButton *btnCash;
    UILabel *lblCash;
    UIButton *btnCreditCard;
    UILabel *lblCreditCard;
}
@end
@implementation ExpenseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier fieldType:(FieldType)type
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

        lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 30)];
        [self.contentView addSubview:lblName];
        switch (type)
        {
            case kDateField:
                btnDate = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblName.frame) + 5 , self.bounds.size.width - 20, 30)];
                [btnDate setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin];
                [btnDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [self.contentView addSubview:btnDate];
                [btnDate.titleLabel setFont:[UIFont systemFontOfSize:13]];
                [btnDate addTarget:self action:@selector(dateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case kModeField:
                [lblName setHidden:YES];
                
                btnCash = [[UIButton alloc] initWithFrame:CGRectMake(10, 18, 24, 24)];
                [btnCash setImage:[UIImage imageNamed:@"check-empty"] forState:UIControlStateNormal];
                [btnCash addTarget:self action:@selector(cashChckBoxTapped:) forControlEvents:UIControlEventTouchUpInside];
                [btnCash setTag:iCashTag];
                [self.contentView addSubview:btnCash];
                
                lblCash = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnCash.frame) + 5, 15, 120, 30)];
                [lblCash setText:@"Cash"];
                [self.contentView addSubview:lblCash];
                
                btnCreditCard = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblCash.frame) + 10, 18, 24, 24)];
                [btnCreditCard setImage:[UIImage imageNamed:@"check-empty"] forState:UIControlStateNormal];
                [btnCreditCard addTarget:self action:@selector(cashChckBoxTapped:) forControlEvents:UIControlEventTouchUpInside];
                [btnCreditCard setTag:iCreditCardTag];
                [self.contentView addSubview:btnCreditCard];
                
                lblCreditCard = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnCreditCard.frame) + 5, 15, 120, 30)];
                [lblCreditCard setText:@"Credit card"];
                [self.contentView addSubview:lblCreditCard];
                
                break;
            case kAmountField:
            case kSalaryField:
                txtValue = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblName.frame) + 5 , self.bounds.size.width - 20, 30)];
                [txtValue setDelegate:self];
                [txtValue setFont:[UIFont systemFontOfSize:13]];
                [txtValue setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin];
                [txtValue setKeyboardType:UIKeyboardTypeNumberPad];
                [self.contentView addSubview:txtValue];
                break;
                
            case kItemField:
                txtValue = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblName.frame) + 5 , self.bounds.size.width - 20, 30)];
                [txtValue setDelegate:self];
                [txtValue setFont:[UIFont systemFontOfSize:13]];
                [txtValue setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin];
                [self.contentView addSubview:txtValue];
                break;
            default:
                break;
        }
        [self configureField:txtValue];
        [self configureField:btnDate];
    }
    return self;
}

- (void)setFieldValue:(Field *)fieldParam
{
    field = fieldParam;
    [lblName setText:field.strFieldName];
    
    switch (field.fieldType)
    {
        case kDateField:
            [btnDate setTitle:field.strFieldValue forState:UIControlStateNormal];
            break;
            
        case kAmountField:
        case kSalaryField:
        case kItemField:
            [txtValue setText:field.strFieldValue];
            break;
        case kModeField:
            if (field.bIsCreditCard)
            {
                [btnCash setImage:[UIImage imageNamed:@"check-empty"] forState:UIControlStateNormal];
                [btnCreditCard setImage:[UIImage imageNamed:@"check-checked"] forState:UIControlStateNormal];
            }
            else
            {
                [btnCash setImage:[UIImage imageNamed:@"check-checked"] forState:UIControlStateNormal];
                [btnCreditCard setImage:[UIImage imageNamed:@"check-empty"] forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)configureField:(UIView *)view
{
    [view.layer setCornerRadius:2.];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setBorderWidth:.5];
}

- (void)cashChckBoxTapped:(UIButton *)button
{
    [field setBIsCreditCard:button.tag == iCreditCardTag];
    [self setFieldValue:field];
}
- (void)dateButtonTapped:(UIButton *)button
{
    [Expense showDatePickerWithDelegate:self andDateSelected:nil];
}

- (void)dateSelected:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMM yy HH:mm:ss";
    [field setStrFieldValue:[dateFormatter stringFromDate:date]];
    [btnDate setTitle:field.strFieldValue forState:UIControlStateNormal];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [field setStrFieldValue:textField.text];
}
@end
