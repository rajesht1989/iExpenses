//
//  Field.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "Field.h"

@implementation Field

- (void)setFieldType:(FieldType)fieldType
{
    _fieldType = fieldType;
    [self setFHeight:80];
    switch (fieldType)
    {
        case kDateField:
            [self setStrIdentifier:@"kDateField"];
            break;
        case kSalaryField:
            [self setStrIdentifier:@"kSalaryField"];
            break;
        case kItemField:
            [self setStrIdentifier:@"kItemField"];
            break;
        case kAmountField:
            [self setStrIdentifier:@"kAmountField"];
            break;
        case kModeField:
            [self setStrIdentifier:@"kModeField"];
            break;
        default:
            break;
    }
}

@end
