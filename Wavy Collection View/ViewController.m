//
//  ViewController.m
//  Wavy Collection View
//
//  Created by Yilei Huang on 2019-01-23.
//  Copyright © 2019 Joshua Fanng. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "WavyFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = [WavyFlowLayout new];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;  // We have 5 sections
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:           // For section 0...
            return 10;     // ...we have 5 items
        case 1:
            return 13;
        case 2:
            return 24;
        default:
            return 7;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *cellId = @"myCell";  // Reuse identifier
    switch (indexPath.section) {
        case 0:  // Section 0....
            cellId = @"blueCell";  // ...use "myCell"
            break;
       
        default:
            cellId = @"myWhiteCell";
            break;
    }
    
    // Ask collection view to give us a cell that we can use to populate our data
    MyCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    
    // Cell will display the section and row number
    NSString *labelText = [NSString stringWithFormat:@"cell %ld", (long)indexPath.row];
    cell.blueLabel.text = labelText;
    
    return cell;
}

@end
