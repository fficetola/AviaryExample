//
//  ViewController.h
//  AviaryExample
//
//  Created by Fr@nk on 22/04/13.
//  Copyright (c) 2013 LuBannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPhotoEditorController.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController : UIViewController<AFPhotoEditorControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
    
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker;
    
}

- (void) selectPhoto:(UIImagePickerControllerSourceType) pickerType;
- (IBAction)displayAviaryEditor:(id)sender;
- (void)displayEditorForImage:(UIImage *)imageToEdit;
- (IBAction)openBannerFullScreen;

@property (nonatomic, retain) UIImage *imageModifiedAviary;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIImagePickerController *picker;

@end
