//
//  ArticleTableCell.h
//  ParseHtmlDemo
//
//  Created by andson-zhw on 17/3/3.
//  Copyright © 2017年 andson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarIcon;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UIImageView *articleImgView;

@property (weak, nonatomic) IBOutlet UILabel *articleContentLab;

@property (weak, nonatomic) IBOutlet UIButton *articleTypeBtn;

@property (weak, nonatomic) IBOutlet UILabel *readNumLab;

@property (weak, nonatomic) IBOutlet UILabel *commentsNumLab;

@property (weak, nonatomic) IBOutlet UILabel *likeNumLab;

-(void)setCellData:(id)data;
@end
