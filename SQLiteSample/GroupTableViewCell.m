//
//  GroupTableViewCell.m
//  SQLiteSample
//
//  Created by 相澤 隆志 on 2014/04/21.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
