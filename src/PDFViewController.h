//
//  PDFViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController

@property(nonatomic, retain)IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSData *pdf;
@property(nonatomic, retain)UIDocumentInteractionController *docController;
@end
