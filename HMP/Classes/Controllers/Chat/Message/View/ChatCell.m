//
//  ChatCell.m
//  LALANote
//
//  Created by hcb on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChatCell.h"
#import "UIButton+WebCache.h"
@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.lableLeft.priority = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dataDidChange{
    ChatData *d = self.data;
    
    self.content.text = d.message;

    if ([d.type isEqualToString:@"text"]) {
        
        self.time.text = d.created_at;
    }else{
        
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:d.message]];
    }
    [self.head sd_setImageWithURL:[NSURL URLWithString:d.isme?d.from_avatar:d.to_avatar] forState:UIControlStateNormal];
    
}

@end
