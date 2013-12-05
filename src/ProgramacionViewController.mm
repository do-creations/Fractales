//
//  ProgramacionViewController.m
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import "ProgramacionViewController.h"
#import "AddActionViewController.h"
#import "ConfigViewController.h"
#import "testApp.h"

@interface ProgramacionViewController ()

@end

@implementation ProgramacionViewController
{
    NSMutableArray *tableData;
    NSMutableArray *tableTimeData;

}
@synthesize mainInstance;

- (NSString *) valor:(int) numero{
        NSString * temp;
        switch (numero) {
            case 1:
                temp = @"Traslada";
                break;
            case 0:
                temp = @"Rota";
                break;
            case 2:
                temp = @"Escala";
                break;
            default:
                temp = @"error";
                break;
        }
        return temp;
}
- (void)getData
{
    [tableData removeAllObjects];
    [tableTimeData removeAllObjects];

    deque<ops> operaciones = mainInstance->get_toDo();
    NSString *workingTemp;
    NSString *workingTemp2;
    for(int i = 1; i < operaciones.size(); i++){
        workingTemp = [[self valor:operaciones.at(i).operation]
                       stringByAppendingFormat:@"\t X: %.2f Y: %.2f",
                                                operaciones.at(i).pars[0],
                                                operaciones.at(i).pars[1]];
        workingTemp2 = [NSString stringWithFormat:@"time take: %.6f ms", operaciones.at(i).time];
        [tableData addObject: workingTemp];
        [tableTimeData addObject: workingTemp2];

    }
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Initialize table data
    tableData = [[NSMutableArray alloc] init];
    tableTimeData = [[NSMutableArray alloc] init];

    ConfigViewController *tempConf = [[[self tabBarController] viewControllers] objectAtIndex:0];
    mainInstance = tempConf.exampleOFApp;
    //tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    [self getData];
}


- (void)viewWillAppear:(BOOL)animated{
    [self getData];
    printf("view will appear\n");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    cell.detailTextLabel.text = [tableTimeData objectAtIndex:indexPath.row];

    //NSLog(@" valor tiempo %@\n", [tableTimeData objectAtIndex:indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableData removeObjectAtIndex:indexPath.row];
        [tableTimeData removeObjectAtIndex:indexPath.row];
        mainInstance->delete_toDo(indexPath.row);
    }

    // Request table view to reload
    [tableView reloadData];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    if([segue.sourceViewController isKindOfClass:[AddActionViewController class]])
        printf("add info \n");
    AddActionViewController *returning = segue.sourceViewController;
    mainInstance->set_toDo(returning.actual);
    NSString *workingTemp = [[self valor:returning.actual.operation]
                   stringByAppendingFormat:@"\t X: %.2f Y: %.2f",
                   returning.actual.pars[0],
                   returning.actual.pars[1]];
    NSString *workingTemp2 = [NSString stringWithFormat:@"time take: %.6f ms", returning.actual.time];
    [tableData addObject: workingTemp];
    [tableTimeData addObject: workingTemp2];
    [self.tableView reloadData];
}
- (IBAction)unwindToListCancel:(UIStoryboardSegue *)segue
{
    
    
}

@end

