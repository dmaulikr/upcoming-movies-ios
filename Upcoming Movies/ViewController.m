//
//  ViewController.m
//  Upcoming Movies
//
//  Created by Shiv Sakhuja on 23/05/14.
//  Copyright (c) 2014 Shiv Sakhuja. All rights reserved.
//

#import "ViewController.h"
#import "MSCellAccessory.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (nonatomic, retain) NSArray *openingMoviesResponseArray;
@property (nonatomic, retain) UIImage *posterImage;
@property (nonatomic, retain) NSString *firstMoviePoster;


@end

@implementation ViewController

@synthesize myTableView, openingMoviesResponseArray, posterImage, cachedImages;

-(IBAction)showMovieDetails:(id)sender {
    
    CGRect frame_detailView = detailView.frame;
    frame_detailView.origin.x = 0;
    frame_detailView.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    detailView.frame = frame_detailView;
    
    [UIView commitAnimations];
    
    listView.hidden = NO;
    detailView.hidden = NO;
    
    long movieIndex = [sender tag];
    
    NSLog(@"Selected Table Cell %ld", movieIndex);
    NSDictionary *detailMovieDictionary = [self.openingMoviesResponseArray objectAtIndex:movieIndex];
    
    NSString *movie_title = [detailMovieDictionary valueForKey:@"title"];
    
    NSDictionary *movie_release_dates_dict = [detailMovieDictionary objectForKey:@"release_dates"];
    NSString *movie_release_date_theater = [movie_release_dates_dict valueForKey:@"theater"];
    
    
    NSDictionary *movie_ratings_dict = [detailMovieDictionary objectForKey:@"ratings"];
    NSString *movie_critics_score = [movie_ratings_dict valueForKey:@"critics_score"];
    NSString *movie_audience_score = [movie_ratings_dict valueForKey:@"audience_score"];
    
    NSString *movie_synopsis = [detailMovieDictionary valueForKey:@"synopsis"];
    
    NSString *new_movie_audience_score = [NSString stringWithFormat:@"%@%%", movie_audience_score];
    NSString *new_movie_critics_score = [NSString stringWithFormat:@"%@%%", movie_critics_score];
    
    movieDetailTitle.text = movie_title;
    
    NSDateFormatter *releaseDateFormatter = [[NSDateFormatter alloc] init];
    [releaseDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *releaseDate = [releaseDateFormatter dateFromString:movie_release_date_theater];
    [releaseDateFormatter setDateFormat:@"dd MMMM YYYY"];
    NSString *releaseDateFormatted = [releaseDateFormatter stringFromDate:releaseDate];
    
    movieDetailReleaseDate.text = releaseDateFormatted;

    movieDetailAudienceRating.text = new_movie_audience_score;
    movieDetailCriticsRating.text = new_movie_critics_score;
    
    [movieDetailSynopsis setScrollEnabled:YES];
    [movieDetailSynopsis setText:movie_synopsis];
    
    movieDetailSynopsis.textAlignment = NSTextAlignmentJustified;
    [movieDetailSynopsis setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14]];
    [movieDetailSynopsis setTextColor:[UIColor darkGrayColor]];

}

-(IBAction)backToList:(id)sender {
    //Bring List View to Screen
    
    listView.hidden = NO;
    detailView.hidden = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Setup Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Check for Internet Connection
    NSString *connect = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://google.com"]] encoding:NSUTF8StringEncoding error:nil];
    
    listView.hidden = NO;
    detailView.hidden = YES;
    
    if (connect == NULL) {
        //No Internet Connection
        [self showNoInternetMessage:nil];
    }
    
    else {
        [self getMovieJSON];
    }
    backgroundBlurImage.image = [[UIImage imageNamed:@"dirtybluebg"] stackBlur:320];
    
    self.cachedImages = [[NSMutableDictionary alloc] init];
    
    CALayer *detailViewCardLayer = detailViewCard.layer;
    detailViewCardLayer.cornerRadius = 15;
    detailViewCardLayer.shadowColor = [[UIColor blackColor] CGColor];
    detailViewCardLayer.shadowRadius = 3.0f;
    detailViewCardLayer.shadowOpacity = 1.0f;
    detailViewCardLayer.shadowOffset = CGSizeMake(0.0, 0.0);
    detailViewCardLayer.masksToBounds = NO;
    
}

-(IBAction)showNoInternetMessage:(id)sender {
    NSLog(@"Show No Internet");
    CGRect frame_noInternet = noInternetView.frame;
    frame_noInternet.origin.x = 0;
    frame_noInternet.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    noInternetView.frame = frame_noInternet;
    
    [UIView commitAnimations];
}

-(IBAction)retryButton:(id)sender {
    CGRect frame_noInternet = noInternetView.frame;
    frame_noInternet.origin.x = 0;
    frame_noInternet.origin.y = 568;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    noInternetView.frame = frame_noInternet;
    
    [UIView commitAnimations];
    
    [self getMovieJSON];
}

-(void)getMovieJSON {
    //Start JSON Parsing
    NSString *rottenTomatoesAPIKey = @"dwr2g5k8m6bt5ds6btahh7uw";
    
    NSString *openingMoviesURLString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?apikey=%@", rottenTomatoesAPIKey];
    
    NSLog(@"Search %@",openingMoviesURLString);
    
    // Create NSURL from string.
    NSURL *openingMoviesURL = [NSURL URLWithString:openingMoviesURLString];
    
    // Get NSData from Final_Url
    NSData* openingMoviesData = [NSData dataWithContentsOfURL:openingMoviesURL];
    
    // parse out the json data
    NSError* error;
    
    NSDictionary* openingMoviesJSON = [NSJSONSerialization JSONObjectWithData:openingMoviesData options:kNilOptions error:&error];
    
    self.openingMoviesResponseArray = [openingMoviesJSON objectForKey:@"movies"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//No of sections in Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//No of rows in the Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Start JSON Parsing
    NSDictionary *movieDictionary = [self.openingMoviesResponseArray objectAtIndex:indexPath.row];
    
    NSString *movie_title = [movieDictionary valueForKey:@"title"];
    
    NSString *movie_mpaa_rating = [movieDictionary valueForKey:@"mpaa_rating"];
    NSString *movie_runtime = [movieDictionary valueForKey:@"runtime"];
    
    NSDictionary *movie_release_dates_dict = [movieDictionary objectForKey:@"release_dates"];
    NSString *movie_release_date_theater = [movie_release_dates_dict valueForKey:@"theater"];
    
    
    NSDictionary *movie_ratings_dict = [movieDictionary objectForKey:@"ratings"];
    NSString *movie_critics_rating = [movie_ratings_dict valueForKey:@"critics_rating"];
    NSString *movie_critics_score = [movie_ratings_dict valueForKey:@"critics_score"];
    
    NSDictionary *movie_posters_dict = [movieDictionary objectForKey:@"posters"];
    NSString *movie_poster_profile = [movie_posters_dict valueForKey:@"profile"];
    
    //End JSON Parsing

  
    
    static NSString *simpleIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentifier];
    }
    
    cell.posterImageView.image = [UIImage imageNamed:@"placeholder.png"];
    cell.cellButtonMovie.tag = indexPath.row;
    [cell.cellButtonMovie addTarget:self action:@selector(showMovieDetails:)
                   forControlEvents:UIControlEventTouchUpInside];
    cell.movieTitle.text = movie_title;
    
    NSDateFormatter *releaseDateFormatter = [[NSDateFormatter alloc] init];
    [releaseDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *releaseDate = [releaseDateFormatter dateFromString:movie_release_date_theater];
    [releaseDateFormatter setDateFormat:@"dd MMMM YYYY"];
    NSString *releaseDateFormatted = [releaseDateFormatter stringFromDate:releaseDate];
    
    cell.movieYear.text = releaseDateFormatted;
    cell.runtime.text = [NSString stringWithFormat:@"%@ min", movie_runtime];
    cell.mpaaRating.text = [NSString stringWithFormat:@"%@", movie_mpaa_rating];
    cell.criticsRatingScore.text = [NSString stringWithFormat:@"%@%%", movie_critics_score];
    cell.criticsConsensus.text = [NSString stringWithFormat:@"%@", movie_critics_rating];

    
    NSURL*imageURL = [NSURL URLWithString:movie_poster_profile];
    
    __block UIActivityIndicatorView *activityIndicator;
    [cell.posterImageView sd_setImageWithURL:imageURL
                           placeholderImage:nil
                                    options:SDWebImageProgressiveDownload
                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                       if (!activityIndicator) {
                                           [cell.posterImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                           activityIndicator.center = cell.posterImageView.center;
                                           [activityIndicator startAnimating];
                                       }
                                   }
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      [activityIndicator removeFromSuperview];
                                      activityIndicator = nil;
                                  }];
    
    
    
    return cell;
}


@end
