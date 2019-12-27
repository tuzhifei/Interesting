//
//  VideoListTableViewCell.m
//  App
//
//  Created by Mark on 19/9/7.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "VideoListTableViewCell.h"
#import "VideoListModel.h"
@interface VideoListTableViewCell ()


@property (nonatomic, weak) UIImageView *ImageView;
@property (nonatomic, weak) UIImageView *shadeView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *messageLabel;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *timeLab;

@end

@implementation VideoListTableViewCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
        UIImageView *image = [[UIImageView alloc] init];
        [self.backView addSubview:image];
        self.ImageView = image;
        
        UIImageView *shadeView = [[UIImageView alloc]init];
        shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.shadeView = shadeView;
        [image addSubview:self.shadeView];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:15.f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        
        self.titleLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = COLOR_85_light;
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        [self.contentView addSubview:self.iconImg];
        [self.backView addSubview:self.timeLab];
    }
    return self;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        ViewBorderRadius(_backView, 6, 3, [UIColor clearColor]);
    }
    return _backView;
}

- (UIImageView *)iconImg {
    if (_iconImg == nil) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.backgroundColor = [UIColor whiteColor];
        ViewBorderRadius(_iconImg, 20, .1f, [UIColor redColor]);
    }
    return _iconImg;
}

- (UILabel *)timeLab {
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.backgroundColor = [UIColor blackColor];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.text = @"01:45";
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.font = [UIFont systemFontOfSize:11];
    }
    return _timeLab;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat spacing = 12 * SCREEN_POINT_375;
    CGFloat bottomHeight = 40 * SCREEN_POINT_375;
    self.backView.frame = CGRectMake(spacing, spacing, self.contentView.width - 2 * spacing, self.contentView.height - spacing - 60 * SCREEN_POINT_375);
    self.iconImg.frame = CGRectMake(spacing, self.backView.bottom + bottomHeight/4, bottomHeight, bottomHeight);
    self.titleLabel.frame = CGRectMake(self.iconImg.right + spacing, self.iconImg.mj_y, self.backView.width - self.iconImg.right - 2 * spacing, bottomHeight/2);
    self.messageLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, bottomHeight/2);
    self.ImageView.frame = self.backView.bounds;
    self.shadeView.frame = self.backView.bounds;
    
    self.timeLab.frame = CGRectMake(self.backView.width - 50 * SCREEN_POINT_375, self.backView.bottom -  bottomHeight, bottomHeight, bottomHeight/2);
    ViewBorderRadius(self.timeLab, 3, .1f, [UIColor redColor]);
}

- (void)configWithModel:(VideoListModel *)model {
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    self.titleLabel.text = model.titleLabel;
    self.timeLab.text = [self timeStrFormTime:model.duration];
    self.messageLabel.text = [NSString stringWithFormat:@"%@ / #%@", model.authorName, model.category];
//    [NSString stringWithFormat:@"#%@",model.category];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.authorIcon]];
    
}

//转换时间格式
- (NSString *)timeStrFormTime:(NSString *)timeStr {
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minutes,second];
}

@end
