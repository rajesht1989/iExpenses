//
//  NewEntryController.h
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"

@interface NewEntryController : UITableViewController
@property (nonatomic,strong)Form *form; //If form param is nil default Form is automatically created
@property (nonatomic)BOOL isEditMode;
@end
