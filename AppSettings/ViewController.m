//
//  ViewController.m
//  AppSettings
//
//  Created by Brian Moakley on 5/25/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mood;
@property (weak, nonatomic) IBOutlet UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UIButton * pickImageButton;


@end

@implementation ViewController

//saving the NSUserDefaults
- (IBAction)saveData:(id)sender
{
    //get the user defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:self.firstName.text forKey:@"FirstName"];
    [userDefaults setObject:self.lastName.text forKey:@"LastName"];
    [userDefaults setObject:@(self.mood.selectedSegmentIndex) forKey:@"Mood"];

    if(self.imageView.image){

        NSData *data = UIImagePNGRepresentation(self.imageView.image);
        [userDefaults setObject:data forKey:@"Picture"];
        self.pickImageButton.hidden = YES;


    }
    [userDefaults synchronize];
}

- (IBAction) pickPhoto: (id) sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
    self.pickImageButton.hidden = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstName.delegate = self;
    self.lastName.delegate = self;

    //Load the Data from userDefaults.

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    self.firstName.text = [userDefaults objectForKey:@"FirstName"];
    self.lastName.text = [userDefaults objectForKey:@"LastName"];

    NSNumber *moodIndex = [userDefaults objectForKey:@"Mood"];
    self.mood.selectedSegmentIndex = moodIndex.integerValue;

    NSData *imageData =[userDefaults objectForKey:@"Picture"];
    if (imageData) {

    self.imageView.image = [UIImage imageWithData:imageData];
        self.pickImageButton.hidden = YES;

    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
