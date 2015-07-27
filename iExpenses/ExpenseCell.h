//
//  ExpenseCell.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Field.h"

@interface ExpenseCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier fieldType:(FieldType)type;
- (void)setFieldValue:(Field *)field;

@end
