//
//  NewEntryController.m
//  iExpenses
//
//  Created by Rajesh on 7/12/15.
//  Copyright (c) 2015 Org. All rights reserved.
//

#import "NewEntryController.h"
#import "ExpenseCell.h"
#import "Expense.h"

@interface NewEntryController ()
@end

@implementation NewEntryController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.presentingViewController)
    {
        [self.navigationItem setLeftBarButtonItem:nil];
    }
    
    if (_isEditMode)
    {
        [self setTitle:@"Update data"];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(submitTapped:)]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


- (Form *)form
{
    if (!_form)
    {
        _form = [Form new];
    }
    return _form;
}
- (IBAction)submitTapped:(id)sender
{
    [self.view endEditing:YES];
    NSString *strMessage;
    if (_isEditMode)
    {
        strMessage = @"Data updated successfully";
        [[Expense sharedExpense] updateForm:self.form];
    }
    else
    {
        strMessage = @"Data added successfully";
        [[Expense sharedExpense] addEnteredForm:self.form];
    }
    
    UIAlertController *alertCntlr = [UIAlertController alertControllerWithTitle:nil message:strMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertCntlr addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (_isEditMode)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            self.form = nil;
            [self.tableView reloadData];
            if (self.presentingViewController)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }]];
    [self presentViewController:alertCntlr animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Field *field = [self.form.arrFields objectAtIndex:indexPath.row];
    return field.fHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.form.arrFields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Field *field = [self.form.arrFields objectAtIndex:indexPath.row];
    ExpenseCell *cell = [tableView dequeueReusableCellWithIdentifier:field.strIdentifier];
    if (!cell)
    {
        cell = [[ExpenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:field.strIdentifier fieldType:field.fieldType];
    }
    [cell setFieldValue:field];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
