//
//  ViewController.h
//  Upcoming Movies
//
//  Created by Shiv Sakhuja on 23/05/14.
//  Copyright (c) 2014 Shiv Sakhuja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {

    IBOutlet UIImageView *backgroundBlurImage;
    IBOutlet UIImageView *backgroundBlurImageView2;
    IBOutlet UILabel *movieCriticsRating;
    IBOutlet UILabel *movieAudienceRating;
    IBOutlet UITextView *movieSynopsis;
    IBOutlet UILabel *movieReleaseDate;
    
    IBOutlet UIView *listView;
    IBOutlet UIView *headerView;
    IBOutlet UIView *detailView;
    IBOutlet UIView *detailViewCard;
    IBOutlet UIView *noInternetView;
    
    IBOutlet UIImageView *movieDetailImageView;
    IBOutlet UIImageView *movieDetailImageViewBlur;
    IBOutlet UILabel *movieDetailTitle;
    IBOutlet UILabel *movieDetailCriticsRating;
    IBOutlet UILabel *movieDetailAudienceRating;
    IBOutlet UILabel *movieDetailReleaseDate;
    IBOutlet UITextView *movieDetailSynopsis;
    IBOutlet UITextView *movieDetailCast;

    NSIndexPath *indexPath;
    UITableView *tableView;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (copy, nonatomic) NSArray *movieCellNames;
@property (copy, nonatomic) NSArray *movieCellDates;

@property (strong, nonatomic) NSMutableDictionary *cachedImages;



-(IBAction)showMovieDetails:(id)sender;
-(IBAction)backToList:(id)sender;

-(IBAction)showNoInternetMessage:(id)sender;
-(IBAction)retryButton:(id)sender;

@end
