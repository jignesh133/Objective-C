
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AFNetworkReachabilityManager.h"
#import "LoginViewController.h"
#import "DashBoardViewController.h"
#import "AFNetworkActivityLogger.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"
#import "CustomSplashScreenViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseMessaging/FirebaseMessaging.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate,FIRMessagingDelegate,AccountAuthenticateDelegate>

@property (strong, nonatomic) NSString *strTokenId;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CustomSplashScreenViewController *customSplashviewController;

@property (strong, nonatomic) DashBoardViewController *viewController;

@property (nonatomic ,retain) MFSideMenuContainerViewController *containerVC;

@property (strong ,nonatomic) SideMenuViewController *sideMenuViewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) UNUserNotificationCenter *center;

-(void)saveContext;

-(void)showLoginScreen;

-(BOOL)isReachable;

-(void)userDidLogin;

-(void)logout;

+(AppDelegate*)appDelegate;

-(void)fireLocalNotification:(NSDate *)dt;

-(void)showloading:(NSString *)str;

-(void)hideloading;

@end
