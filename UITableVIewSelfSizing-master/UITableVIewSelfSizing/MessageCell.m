//
//  MessageCell.m
//  UITableVIewSelfSizing
//
//  Created by 赵赤赤 on 2017/1/11.
//  Copyright © 2017年 mhz. All rights reserved.
//

#import "MessageCell.h"
#import "Masonry.h"

@interface MessageCell ()

@property (nonatomic, strong) UILabel *messsageLabel;

@property (nonatomic, strong) UILabel * label;

@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建UI
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    /** 发言 */
    self.messsageLabel = [[UILabel alloc] init];
    self.messsageLabel.numberOfLines = 0;
    
    //只设置约束宽度
    self.messsageLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-20;
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-100;
    [self.contentView addSubview:_label];
    
    [self.contentView addSubview:self.messsageLabel];
    [self.messsageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(_label.mas_top);
        //make.height.mas_equalTo(100);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_messsageLabel.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-8);
        //make.height.mas_equalTo(30);
    }];
    
    
    
    
    
}



- (void)setMessage:(CellModel *)message {
    // 创建一个可变属性字符串
    NSMutableAttributedString *finalStr = [[NSMutableAttributedString alloc] init];
    
    // 创建姓名
    NSAttributedString *nameStr = [[NSAttributedString alloc] initWithString:message.name attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor redColor]}];
    
    // 创建发言内容
    NSAttributedString *messageStr = [[NSAttributedString alloc] initWithString:message.message attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    // 拼接上两个字符串
    [finalStr appendAttributedString:nameStr];
    [finalStr appendAttributedString:messageStr];
    self.messsageLabel.attributedText = finalStr;
    self.label.attributedText = finalStr;
}

// 根绝数据计算cell的高度
- (CGFloat)heightForModel:(CellModel *)message {
    [self setMessage:message];
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
    
    return cellHeight;
}

@end
