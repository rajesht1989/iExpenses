//
//  Expense.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerController.h"
#import "Form.h"

@interface Expense : NSObject
+ (instancetype)sharedExpense;
- (void)addEnteredForm:(Form *)form;
- (void)deleteForm:(Form *)form;
- (void)updateForm:(Form *)form;

+ (void)showDatePickerWithDelegate:(id<DatePickerDelegate>)delegate andDateSelected:(NSDate *)date;
+ (void)presentDatePickerWithDelegate:(id<DatePickerDelegate>)delegate andDateSelected:(NSDate *)date;

@property(nonatomic,strong)NSMutableArray *arrReports;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
