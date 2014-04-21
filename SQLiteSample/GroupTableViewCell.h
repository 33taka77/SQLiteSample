//
//  GroupTableViewCell.h
//  SQLiteSample
//
//  Created by 相澤 隆志 on 2014/04/21.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *makerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end
