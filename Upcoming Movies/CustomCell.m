//
//  CustomCell.m
//  Upcoming Movies
//
//  Created by Shiv Sakhuja on 24/05/14.
//  Copyright (c) 2014 Shiv Sakhuja. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize cellView;

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
    cellView.layer.masksToBounds = NO;
    cellView.layer.shadowColor = [[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3] CGColor];
    cellView.layer.shadowOpacity = 0.0;
    cellView.layer.shadowOffset = CGSizeMake(0, 1);
    cellView.layer.shadowRadius = 1.0;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 4;
    frame.size.height -= 2 * 4;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
