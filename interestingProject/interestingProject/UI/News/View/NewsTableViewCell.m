//
//  NewsTableViewCell.m
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModel.h"
@interface NewsTableViewCell ()

@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *contentLab;

@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.imgView];
        [self.backView addSubview:self.contentLab];
    }
    return self;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = RGB(245, 245, 245);
        ViewBorderRadius(_backView, 4, 1, [UIColor clearColor]);
    }
    return _backView;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (UILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = COLOR_30;
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat spacing = 12 * SCREEN_POINT_375;
    CGFloat height = self.contentView.sd_height;
    CGFloat width = self.contentView.sd_width;
    self.backView.frame = CGRectMake(spacing, spacing, width - 2 * spacing, height - spacing);
    self.imgView.frame = CGRectMake(0, 0, self.backView.sd_width, 120 * SCREEN_POINT_375);
    self.contentLab.frame = CGRectMake(8, self.imgView.bottom, self.backView.sd_width - 16, self.backView.sd_height - self.imgView.sd_height);
}

- (void)configWithModel:(NewsModel *)model {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.backgroundImage]];
    NSInteger count = model.titleList.count;
    NSString *contenStr = [[NSString alloc]init];
    for (NSInteger i = 0; i < count; i ++) {
        NSString *tmpStr = model.titleList[i];
        [tmpStr substringToIndex:tmpStr.length - 1];
        NSString *text = [NSString stringWithFormat:@"%@\n", tmpStr];
        if (i == count - 1) {
            text = [NSString stringWithFormat:@"%@", tmpStr];
        }
        contenStr = [contenStr stringByAppendingString:text];
    }
    self.contentLab.attributedText = [self designText:contenStr];
}

- (NSMutableAttributedString *)designText:(NSString *)text {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setAlignment:NSTextAlignmentLeft];
    [style setParagraphSpacing:4.0f];
    style.lineSpacing = 3.0f;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr addAttributes:@{NSParagraphStyleAttributeName: style} range:NSMakeRange(0, text.length)];
    return attStr;
}

@end
