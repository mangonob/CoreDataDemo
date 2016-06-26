//
//  SongCoreDataTableViewController.m
//  CoreDataDemo
//
//  Created by Trinity on 16/6/27.
//  Copyright © 2016年 Trinity. All rights reserved.
//

#import "SongCoreDataTableViewController.h"
#import "CoreDataDemo-Swift.h"
#import "SingerCoreDataViewController.h"
#import "DatabaseAvailability.h"
#import "Song+Create.h"
#import "Singer.h"

@interface SongCoreDataTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet DWTextField *name;
@property (weak, nonatomic) IBOutlet DWTextField *number;
@property (weak, nonatomic) IBOutlet DWTextField *singer;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) Singer *singer_;
@end

@implementation SongCoreDataTableViewController
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UIScrollView *s = (UIScrollView *)self.view;
    if (velocity.y < -0.5) {
        s.contentInset = UIEdgeInsetsZero;
        [self openTopView];
    } else if (velocity.y > 0.5) {
        [self closeTopView];
        s.contentInset = UIEdgeInsetsMake(-self.topView.bounds.size.height, 0, 0, 0);
    }
}

-(void)awakeFromNib
{
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    [[NSNotificationCenter defaultCenter] addObserverForName:DatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      NSLog(@"Receive Notification");
                                                      NSDictionary *info = [note userInfo];
                                                      self.context = info[DatabaseAvailabilityContext];
                                                  }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *s = (UIScrollView *)self.view;
    s.contentInset = UIEdgeInsetsMake(-self.topView.bounds.size.height, 0, 0, 0);
    
    self.number.enabled = NO;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    [self.picker selectRow:3 inComponent:0 animated:NO];
    [self.picker selectRow:30 inComponent:1 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableView DateSource
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SongCell"];
    Song *s = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = s.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%02zu:%02zu", [s.time longValue] / 60, [s.time longValue] % 60];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Song *s = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.context deleteObject:s];
    }
}

#pragma mark - UIPickerDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 30;
    } else if (component == 1) {
        return 60;
    }
    return 0;
}

#pragma mark - UIPickerDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%zu", (long)row];
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.number.text = [NSString stringWithFormat:@"%02zu:%02zu",
                        (long)[self.picker selectedRowInComponent:0],
                        (long)[self.picker selectedRowInComponent:1]];
}

#pragma mark - Setter & Getter

-(void)setContext:(NSManagedObjectContext *)context
{
    _context = context;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:@"name"
                                 ascending:YES
                                 selector:@selector(localizedStandardCompare:)]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:request
                                     managedObjectContext:self.context
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
}

#pragma mark - Action
- (IBAction)addSongAction:(id)sender {
    NSInteger m = [self.picker selectedRowInComponent:0];
    NSInteger s = [self.picker selectedRowInComponent:1];
    
    NSNumber *time = @(m * 60 + s);
    
    NSString *name = nil;
    if([self.name.text isEqualToString:@""]) name = @"UNNAMED";
    else name = self.name.text;
    
    [Song songInContext:self.context withName:name time:time];
}


#pragma mark - Others

-(void) openTopView
{
    CABasicAnimation *ani = [CABasicAnimation
                             animationWithKeyPath:
                             @"transform.scale.y"];
    ani.fromValue = @(0.0);
    ani.duration = 0.5;
    ani.timingFunction = [CAMediaTimingFunction
                          functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.delegate = self;
    [self.topView.layer addAnimation:ani forKey:@"OpenAnimation"];
}

-(void) closeTopView
{
    CABasicAnimation *ani = [CABasicAnimation
                             animationWithKeyPath:
                             @"transform.scale.y"];
    ani.toValue = @(0.0);
    ani.duration = 0.5;
    ani.timingFunction = [CAMediaTimingFunction
                          functionWithName:kCAMediaTimingFunctionEaseOut];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    [self.topView.layer addAnimation:ani forKey:@"OpenAnimation"];
}

-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%lf", self.topView.bounds.size.height);
}

#pragma mark - About Segue

-(IBAction)songCoreDataViewControllerUnwind:(UIStoryboardSegue *) segue {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Only one segue to SingerCoreDataViewController */
    SingerCoreDataViewController *s = (SingerCoreDataViewController *)segue.destinationViewController;
    
}

-(BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    SingerCoreDataViewController *c = (SingerCoreDataViewController*)fromViewController;
    return YES;
}
@end









































