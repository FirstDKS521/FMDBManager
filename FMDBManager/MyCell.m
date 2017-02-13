//
//  MyCell.m
//  FMDBManager
//
//  Created by aDu on 2017/2/7.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *aId;

@end

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(MyModel *)model
{
    if (_model != model) {
        self.name.text = model.name;
        self.age.text = model.age;
        self.aId.text = model.aId;
    }
    _model = model;
}

@end
