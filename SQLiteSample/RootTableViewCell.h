//
//  RootTableViewCell.h
//  SQLiteSample
//
//  Created by 相澤 隆志 on 2014/04/19.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewCell : UITableViewCell
@property (weak, nonatomic, readonly) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *groupTitle;


@end
