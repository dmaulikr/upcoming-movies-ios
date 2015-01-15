//
//  CustomCell.h
//  Upcoming Movies
//
//  Created by Shiv Sakhuja on 24/05/14.
//  Copyright (c) 2014 Shiv Sakhuja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {
    
}

@property (weak, nonatomic) IBOutlet UIButton *cellButtonMovie;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posterBlurImageView;
@property (weak, nonatomic) IBOutlet UILabel *criticsRatingScore;
@property (weak, nonatomic) IBOutlet UILabel *runtime;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRating;
@property (weak, nonatomic) IBOutlet UILabel *criticsConsensus;

@property (weak, nonatomic) IBOutlet UIView *cellView;

@end
