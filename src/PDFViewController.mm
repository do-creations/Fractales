//
//  PDFViewController.m
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

@synthesize webView, pdf;
@synthesize docController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    printf("PDF=====\n");
    
    //[webView loadData:pdf MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];

    //[NSString stringwithconte]
    //NSString *html = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
    //[self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    //[webView loadData:pdf MIMEType:@"application/rtf" textEncoding:NSUTF8StringEncoding baseURL:@"none"];
    [self openPDF];

}

-(void)openPDF{
    BOOL iBooksInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ibooks://"]];
    /*
    UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //PDF should be shown in entire screen
    webView2.scalesPageToFit = YES; //PDF page should be scaled to display whole page in screen
    webView2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:webView2];
    [webView2 loadData:pdf MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
*/
    //[pdf writeToFile:@"temp.pdf" atomically:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent:@"temp.pdf"];
    
    [pdf writeToFile:docFile atomically:NO];
    
    NSURL *pdfURL = [NSURL fileURLWithPath:docFile isDirectory:NO]; //[NSURL URLWithString: @"file://temp.pdf"];
    NSData *temp = [NSData dataWithContentsOfURL:pdfURL];
    
    if([temp isEqualToData:pdf]){
        printf("datos de url = datos\n");
    }
    else{
        printf("no son iguales \n");
    }
    
    UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //PDF should be shown in entire screen
    webView2.scalesPageToFit = YES; //PDF page should be scaled to display whole page in screen
    webView2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:webView2];
    [webView2 loadData:temp MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    //[pdf writeToURL:pdfURL atomically:NO];
    //use the UIDocInteractionController API to get list of devices that support the file type
    // your pdf link.
    //[UIDocumentInteractionController interactionControllerWithURL:pdfURL];
    
    //present a drop down list of the apps that support the file type, click an item in the list will open that app while passing in the file.
    docController = [UIDocumentInteractionController interactionControllerWithURL:pdfURL ];

    [docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
