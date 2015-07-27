//
//  Field.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    kDateField = 0,
    kSalaryField,
    kItemField,
    kAmountField,
    kModeField,
}FieldType;

@interface Field : NSObject

@property (nonatomic,assign) FieldType fieldType;
@property (nonatomic,assign) BOOL bIsCreditCard;
@property (nonatomic,assign) BOOL bIsHidden;
@property (nonatomic,assign) BOOL bIsDisabled;
@property (nonatomic,assign) float fHeight;
@property (nonatomic,strong) NSString *strIdentifier;
@property (nonatomic,strong) NSString *strFieldName;
@property (nonatomic,strong) NSString *strFieldValue;

@end
