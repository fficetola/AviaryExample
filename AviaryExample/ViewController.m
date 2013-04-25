//
//  ViewController.m
//  AviaryExample
//
//  Created by Fr@nk on 22/04/13.
//  Copyright (c) 2013 LuBannaiuolu. All rights reserved.
//

#import "ViewController.h"
#import "BannerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;
@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //gallery
    if (buttonIndex==0) {
        [self selectPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    //fotocamera
    else if(buttonIndex==1){
        [self selectPhoto:UIImagePickerControllerSourceTypeCamera];
    }
    
    //annulla
    else if(buttonIndex==2){
        
    }
}


- (IBAction)showOptionsPhotoGallery:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Seleziona tra le seguenti opzioni:"
                                                             delegate:self
                                                    cancelButtonTitle:@"Annulla"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Da Gallery",@"Da Fotocamera",nil];
    
    [actionSheet showInView:self.view];
}

- (void) selectPhoto:(UIImagePickerControllerSourceType) pickerType {
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.sourceType = pickerType;
    //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentModalViewController:picker animated:YES];
    
}


#pragma mark - UIImagePicker Delegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *) photopicker {
    
    [photopicker dismissModalViewControllerAnimated:YES];
    
    [photopicker release];
    
}

- (void)imagePickerController:(UIImagePickerController *) photopicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [photopicker dismissModalViewControllerAnimated:YES];
    [photopicker release];
    
}


#pragma mark - Aviary Delegate

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    
    //read modified image
    [imageView setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}





- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}


- (IBAction)displayAviaryEditor:(id)sender{
     
    [self displayEditorForImage:imageView.image];
}





//Per salvare la foto modificata nella Gallery

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Salvataggio Fallito"
                                                          message:@" *ATTENZIONE* non è stato possibile salvare l'immagine"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Salvataggio effettuato con successo"
                                                          message:@"La tua foto è stata salvata nella Gallery"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}


-(IBAction)savePhotoInGallery:(id)sender{
    
    //salvo la foto nella Gallery
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
}


//aprire immagine in fullscreen
- (IBAction)openBannerFullScreen{
    
    BannerViewController *bannerViewController = [[BannerViewController alloc]init];
    bannerViewController.image = imageView.image;
    [self presentModalViewController:bannerViewController animated:YES];
    [bannerViewController release];
    
}

@end
