//
//  Form.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Report;

@interface Form : NSObject

@property(nonatomic,strong)NSMutableArray *arrFields;
@property(nonatomic,assign)NSInteger identifier;

+ (Form *)formWithRecord:(Report *)record;
- (void)loadReportFormForm:(Report *)report;

@end
