/*
 This program is licensed under the Taboola, Inc. SDK License Agreement (the “License Agreement”).  
 By copying, using or redistributing this program, you agree to the terms of the License Agreement.  
 The full text of the license agreement can be found at https://github.com/taboola/taboola-ios/blob/master/LICENSE
 
 Copyright 2017 Taboola, Inc.  All rights reserved.
*/

//  TaboolaView.h
//  TaboolaView

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LogLevel) {
    LogLevelDebug   = 0,
    LogLevelInfo    = 1,
    LogLevelWarning = 2,
    LogLevelError   = 3
};
/**
 This protocol should be implemented by the host app. TaboolaView sends various lifecycle events to the delegate, to allow more flexibility for the host app.
 */
@protocol TaboolaViewDelegate <NSObject>

@optional
/**
 Attaches a delegate to the TaboolaView. Allows intercepting clicks.
 
 @param pURLString string representation of URL.
 
 @return YES if the view should begin loading content; otherwise, NO. Default value is YES
 */
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic;

@optional
/**
Triggered when the taboolaView resizes after content render
 */
- (void)taboolaViewResizeHandler;

@optional
/**
 Triggered after the taboolaView is succesfully rendered
 */
- (void)taboolaDidReceiveAd:(UIView *)view;

@optional
/**
 Triggered after the taboolaView fails to render
 */
- (void)taboolaDidFailAd:(NSError *)error;

@end

/**
  TaboolaView represnents a single Taboola widget.
 */
@interface TaboolaView : UIView
/**
 Mandatory. Sets the publisher id
 */
@property(nonatomic, strong) NSString *publisher;

/*
 Mandatory. Sets the widget UI mode (template)
 */
@property(nonatomic, strong) NSString *mode;

/**
 Mandatory. Sets the widget placement code (for reporting /configuration purposes)
 */
@property(nonatomic, strong) NSString *placement;

/**
 Mandatory. Sets the page type of the page on which the widget is displayed (one of
 article, photo, video, home, category, search)
 */
@property(nonatomic, strong) NSString *pageType;

/**
 Mandatory. Sets the canonical URL for the page on which the widget is displayed
 */
@property(nonatomic, strong) NSString *pageUrl;

/**
 Optional. Default: "mix". Change only if it's specified by your Taboola account manager
 */

@property(nonatomic, strong) NSString *targetType;

/**
 Optional. Sets the page id of the page on which the widget is displayed (default to auto generate from the URL)
 */
@property(nonatomic, strong) NSString *pageId;

/**
 Optional. Attaches a TaboolaViewDelegate to the TaboolaView. Allows intercepting clicks.
 */
@property(nonatomic, weak) id<TaboolaViewDelegate> delegate;

/**
 Optional. controls whether the widget content is scrollable or not (enabled by default)
 */
@property(nonatomic, readwrite) BOOL scrollEnable;

/**
 Optional. the in-app browser will be pushed to thiw UIViewController
 */
@property(nonatomic, weak) UIViewController *ownerViewController;

/**
 Optional. force legacy UIWebView
 */

@property(nonatomic, readwrite) BOOL forceLegacyWebView;

/**
 Optional. controls whether to show or hide the action buttons on the in-app browser. Default YES
 */
@property(nonatomic, readwrite) BOOL showBrowserIcons;

/**
 Optional. sets the background color for the in-app browser. Default #f5f6f4
 */
@property (nonatomic, strong) UIColor *browserBackColor;

/**
 Optional. Sets the color for the in-app browser title text. Default #007cff
 */
@property (nonatomic, strong) UIColor *browserTitleTextColor;

/**
Optional. When enabled, TaboolaView automatically resizes its height after rendering the widget.
Default YES.
 */
@property(nonatomic, readwrite) BOOL autoResizeHeight;

/**
 Optional. Sets additional styling CSS rules for the widget, use it for controling the widget background, for example.
 */
@property(nonatomic, strong) NSString *optionalWidgetStyle;

/**
 Optional. controls whether item clicks sent to the delegate clickHandler or not. if not they will be opened in Safari (default YES);
 */
@property(nonatomic, readwrite) BOOL enableClickHandler;

/**
 Optional. Controls the ammount (level) of the console log messages by TaboolaSDK. LogLevel enum defines importance levels. Default: LogLevelError
 */
@property(nonatomic, readwrite) LogLevel logLevel;

/**
 Optional. Mediation provider.
 */
@property (nonatomic) NSString* mediation;

/**
 Version of the SDK
*/
+ (NSString*)version;

/**
 Optional. Allows setting additional page commands to the Taboola widget, as used in the Taboola JavaScript API.
 @param pCommands list of commands.
 */
-(void)setOptionalPageCommands:(NSDictionary *)pCommands;

/**
 Optional. Allows setting additional mode commands to the Taboola widget, as used in the Taboola JavaScript API.
 @param pCommands list of commands.
 */
-(void)setOptionalModeCommands:(NSDictionary *)pCommands;

/**
 Resets the TaboolaView - All conents and pushed commands are cleared. new commands must be pushed before fetching data again.
 */
- (void)reset;

/**
 Refreshes the recommendations displayed on the TaboolaView.
 */
- (void)refresh;

/*!
 After initializing the TaboolaView, this method should be called to actually fetch the recommendations
 */
- (void)fetchContent;

@end
