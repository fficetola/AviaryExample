
#import "BannerViewController.h"

@implementation BannerViewController
@synthesize scrollView;
@synthesize imageView;
@synthesize image;


-(void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(self.scrollView.zoomScale > scrollView.minimumZoomScale)
        [self.scrollView setZoomScale:scrollView.minimumZoomScale animated:YES];
    else
        [self.scrollView setZoomScale:scrollView.maximumZoomScale animated:YES];
}

-(IBAction)closeModal:(id)sender{
    // Dismiss the view controller
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"BANNER_TITLE", nil);
    
    
        
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeModal:)];
    
    DLog(@"bannerURLString %@",bannerURLString);

    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleDoubleTap:)];
    
    tapTwice.numberOfTapsRequired = 2;

    [self.view addGestureRecognizer:tapTwice];
    
    
    UIImage *imageFullScreen = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:imageFullScreen];
     
    //self.scrollView.contentSize = image.size;
    self.scrollView.delegate = self;
    //self.scrollView.minimumZoomScale = 10.0;
    self.scrollView.maximumZoomScale = 50.0;

    
    /*UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.center = CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height/2);
    spinner.hidesWhenStopped = YES;
    [self.imageView addSubview:spinner];
    [spinner startAnimating];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:bannerURL];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageView setImage:image];
            [spinner stopAnimating];
        
            //[self.imageView sizeToFit];
            
            //self.scrollView.contentSize = image.size;
            self.scrollView.delegate = self;
            //self.scrollView.minimumZoomScale = 10.0;
            self.scrollView.maximumZoomScale = 50.0;
            
        });
    });*/
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.scrollView.bounds),
                                      CGRectGetMidY(self.scrollView.bounds));
    [self view:self.imageView setCenter:centerPoint];
}

- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint
{
    CGRect vf = view.frame;
    CGPoint co = self.scrollView.contentOffset;
    
    CGFloat x = centerPoint.x - vf.size.width / 2.0;
    CGFloat y = centerPoint.y - vf.size.height / 2.0;
    
    if(x < 0)
    {
        co.x = -x;
        vf.origin.x = 0.0;
    }
    else 
    {
        vf.origin.x = x;
    }
    if(y < 0)
    {
        co.y = -y;
        vf.origin.y = 0.0;
    }
    else 
    {
        vf.origin.y = y;
    }
    
    view.frame = vf;
    self.scrollView.contentOffset = co;
}

// MARK: - UIScrollViewDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else 
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
        zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
    }
    else 
    {
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}



@end
