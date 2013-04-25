#import <UIKit/UIKit.h>


@interface BannerViewController : UIViewController<UIScrollViewDelegate>{
    
    NSString *bannerURLString;
    NSString *bannerTitle;
    UIImage *image;
    
}

-(IBAction)closeModal:(id)sender;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIImage* image;

@end
