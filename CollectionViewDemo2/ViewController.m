//
//  ViewController.m
//  CollectionViewDemo2
//
//  Created by user on 16/3/8.
//  Copyright © 2016年 user. All rights reserved.
//

// http://www.it165.net/pro/html/201312/8575.html

// http://objccn.io/issue-3-3/


#import "ViewController.h"
#import "BookCollectionViewCell.h"
#import "BookCollectionViewLayout.h"

#define SECTION_COUNT           30
#define SECTION_ITEM_COUNT      4

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BookCollectionViewLayout *bookLayout = [[BookCollectionViewLayout alloc] init];
    
    bookLayout.itemSize = CGSizeMake(80, 100);
    
    bookLayout.itemSpacing = 10.f;
    bookLayout.itemPadding = 20.f;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setCollectionViewLayout:bookLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BOOK"];
    
    NSLog(@"self.view.frame : %@",NSStringFromCGRect(self.view.frame));
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return SECTION_COUNT;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return SECTION_ITEM_COUNT;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BOOK" forIndexPath:indexPath];
    NSLog(@"cell->:%@",NSStringFromCGRect(cell.frame));
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
