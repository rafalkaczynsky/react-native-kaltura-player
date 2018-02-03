//  Created by react-native-create-bridge
#import <Foundation/Foundation.h>
#import "supermodule.h"
#import <KALTURAPlayerSDK/KPPlayerConfig.h>
#import <KALTURAPlayerSDK/KPViewController.h>

// import RCTEventDispatcher
#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#elif __has_include(“RCTEventDispatcher.h”)
#import “RCTEventDispatcher.h”
#else
#import “React/RCTEventDispatcher.h” // Required when used as a Pod in a Swift project
#endif


@implementation supermodule : UIView  

{
  RCTEventDispatcher *_eventDispatcher;
  UIView *_childView;
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
    if ((self = [super init])){
        _eventDispatcher = eventDispatcher;
        _childView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _childView.backgroundColor = [UIColor blueColor];
    }

    return self;
}

// attach _childView to a parrent
- (void)layoutSubviews
{
    [super layoutSubviews];
    _childView.frame = self.bounds; // assign child frame to bounds of parent

    [self addSubview: _childView]; // add subview to UIView
}

// example of setter for props from react native 
- (void)setExampleProp:(NSArray *)exampleProp{
    if(![exampleProp isEqual:_exampleProp]){
        _exampleProp = [exampleProp copy];
        [self addTextView: _exampleProp];
    }
}

- (UIViewController *)player {
  if (!_player) {
    // Account Params 
    KPPlayerConfig *config = [[KPPlayerConfig alloc] initWithDomain:@"http://cdnapi.kaltura.com"
                                                           uiConfID:@"26698911"
                                                           partnerId:@"1831271"];
    // Video Entry
    config.entryId = @"1_o426d3i4";
    // Setting this property will cache the html pages in the limit size
    config.cacheSize = 0.8;
    _player = [[KPViewController alloc] initWithConfiguration:config];
  }
  return _player;
}

// once prop is set we can use it  
- (void)addTextView:(NSArray *)config
{
   
   UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  
   NSString *partnerId = config[0];
   NSString *configId = config[1];
   NSString *entryId = config[2];
   NSString *url = config[3];


    NSLog (partnerId);
    NSLog (configId);
    NSLog (entryId);
    NSLog (url);

    NSLog (@"Number of books in dictionary = %lu", [config count]);

    textLabel.text = partnerId;
    textLabel.textColor = [UIColor whiteColor];
    [textLabel sizeToFit];

    self.player.view.frame = _childView.frame;
    [_childView addSubview: self.player.view];
    [_childView setNeedsDisplay];
}

@end
