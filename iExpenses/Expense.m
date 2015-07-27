//
//  Expense.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "Expense.h"
#import "Form.h"
#import "Report.h"
#import <CoreData/CoreData.h>

#define DATA_COUNT @"dataCount"

@interface Expense ()
@property(nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic) NSUserDefaults *userDefaults;

@end
@implementation Expense
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

+ (instancetype)sharedExpense
{
    static Expense *expense;
    if (!expense)
    {
        expense = [[self alloc] init];
    }
    return expense;
}

- (void)addEnteredForm:(Form *)form
{
    form.identifier = [self.userDefaults integerForKey:DATA_COUNT] + 1;
    [[self arrReports] addObject:form];
    Report *report = [NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:[self managedObjectContext]];
    [form loadReportFormForm:report];
    NSError *error;
    if (![[self managedObjectContext] save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    else
    {
        [self dataAdded:form.identifier];
    }
}

- (void)deleteForm:(Form *)form
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Report" inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"identifier = %d",form.identifier]];
    [request setPredicate:pred];
    
    NSArray *empArray=[self.managedObjectContext executeFetchRequest:request error:nil];
    if ([empArray count])
    {
        Report *report = [empArray objectAtIndex:0];
        [self.managedObjectContext deleteObject:report];
        [self.managedObjectContext save:nil];
        [[self arrReports] removeObject:form];
    }
}

- (void)updateForm:(Form *)form
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Report" inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"identifier = %d",form.identifier]];
    [request setPredicate:pred];
    
    NSArray *empArray=[self.managedObjectContext executeFetchRequest:request error:nil];
    if ([empArray count])
    {
        Report *report = [empArray objectAtIndex:0];
        [form loadReportFormForm:report];
        [self.managedObjectContext save:nil];
    }
}

- (NSMutableArray *)arrReports
{
    if (!_arrReports)
    {
        _arrReports = [NSMutableArray new];
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Report"];
        
        NSError *error = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        if (error)
        {
            NSLog(@"Error occured %@",error);
        }
        else {
            for (Report *report in results)
            {
                [_arrReports addObject:[Form formWithRecord:report]];
            }
        }
}
    return _arrReports;
}




- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}


- (NSUserDefaults *)userDefaults
{
    if (!_userDefaults)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

- (void)dataAdded:(NSInteger)identifier
{
    [self.userDefaults setInteger:identifier forKey:DATA_COUNT];
    [self.userDefaults synchronize];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataModel.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}






+ (void)presentDatePickerWithDelegate:(id<DatePickerDelegate>)delegate andDateSelected:(NSDate *)date
{
    DatePickerController *datePickerController = [[DatePickerController alloc] init];
    [datePickerController setDelegate:delegate];
    [datePickerController setDateSelected:date];
    [datePickerController setIsModal:YES];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:datePickerController];
    [[self topMostController] presentViewController:navigationController animated:YES completion:nil];
}

DatePickerController *datePickerController;
+ (void)showDatePickerWithDelegate:(id<DatePickerDelegate>)delegate andDateSelected:(NSDate *)date
{
    datePickerController = [[DatePickerController alloc] init];
    [datePickerController setDelegate:delegate];
    [datePickerController setDateSelected:date];
    CGRect rect = datePickerController.view.frame;
    rect.origin.y = 256;
    [datePickerController.view setFrame:rect];
    [[self topMostController].view addSubview:datePickerController.view];
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = datePickerController.view.frame;
        rect.origin.y = 0;
        [datePickerController.view setFrame:rect];
    } completion:^(BOOL finished) {
        [datePickerController completionAction];
    }];
    
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    return topController;
}



@end
