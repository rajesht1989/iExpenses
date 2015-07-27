//
//  Report.h
//  iExpenses
//
//  Created by Rajesh on 7/13/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Report : NSManagedObject

@property (nonatomic, retain) NSString * dateOfEntry;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSString * itemsPurchased;
@property (nonatomic, retain) NSNumber * amountPaid;
@property (nonatomic, retain) NSNumber * isCreditCard;
@property (nonatomic, retain) NSNumber * identifier;

@end
