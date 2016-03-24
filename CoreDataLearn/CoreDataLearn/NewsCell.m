//
//  NewsCell.m
//  WangyiNews
//
//  Created by iHope on 14-1-10.
//  Copyright (c) 2014年 任海丽. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

-(void)setContent:(News*)info
{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:info.imgurl]];
    UIImage *image = [UIImage imageWithData:imageData];
//    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl]];
    _newsImageView.image = image;
    _newsTitle.text = info.title;
    _newsDescr.text = info.descr;
    if ([info.islook isEqualToString:@"1"]) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

@end
