//
//  Form.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "Form.h"
#import "Field.h"
#import "Report.h"

@implementation Form
- (instancetype)init
{
    if (self = [super init])
    {
        [self configureFields];
    }
    return self;
}

- (void)configureFields
{
    NSMutableArray *arrFields = [NSMutableArray new];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMM yy HH:mm:ss";
    
    Field *dateField = [Field new];
    [dateField setStrFieldName:@"Date of purchases"];
    [dateField setStrFieldValue:[dateFormatter stringFromDate:[NSDate date]]];
    [dateField setFieldType:kDateField];
    [arrFields addObject:dateField];
    
    Field *salaryField = [Field new];
    [salaryField setStrFieldName:@"Salary credited"];
    [salaryField setFieldType:kSalaryField];
    [arrFields addObject:salaryField];
    
    Field *itemField = [Field new];
    [itemField setStrFieldName:@"Items purchased"];
    [itemField setFieldType:kItemField];
    [arrFields addObject:itemField];
    
    Field *amountField = [Field new];
    [amountField setStrFieldName:@"Amount"];
    [amountField setFieldType:kAmountField];
    [arrFields addObject:amountField];
    
    Field *modeField = [Field new];
    [modeField setFieldType:kModeField];
    [arrFields addObject:modeField];
    
    _arrFields = arrFields;
}

+ (Form *)formWithRecord:(Report *)record
{
    Form *form = [[self alloc] init];
    [form setIdentifier:[record.identifier integerValue]];
    for (Field *aField in [form arrFields])
    {
        switch (aField.fieldType)
        {
            case kDateField:
                [aField setStrFieldValue:record.dateOfEntry];
                [aField setBIsDisabled:YES];
                break;

            case kSalaryField:
                [aField setStrFieldValue:[NSString stringWithFormat:@"%@",record.salary]];
                [aField setBIsDisabled:YES];
                break;
            case kItemField:
                [aField setStrFieldValue:record.itemsPurchased];
                break;
            case kAmountField:
                [aField setStrFieldValue:[NSString stringWithFormat:@"%@",record.amountPaid]];
                break;
            case kModeField:
                [aField setBIsCreditCard:[record.isCreditCard boolValue]];
                break;

            default:
                break;
        }
    }
    return form;
}

- (void)loadReportFormForm:(Report *)report;
{
    [report setIdentifier:@(self.identifier)];
    for (Field *aField in [self arrFields])
    {
        switch (aField.fieldType)
        {
            case kDateField:
                [report setDateOfEntry:aField.strFieldValue];
                break;
                
            case kSalaryField:
                [report setSalary:@([aField.strFieldValue integerValue])];
                break;
            case kItemField:
                [report setItemsPurchased:aField.strFieldValue];
                break;
            case kAmountField:
                [report setAmountPaid:@([aField.strFieldValue integerValue])];
                break;
            case kModeField:
                [report setIsCreditCard:@(aField.bIsCreditCard)];
                break;
                
            default:
                break;
        }
    }
}

@end
