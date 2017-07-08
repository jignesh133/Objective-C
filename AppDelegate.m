#import "AppDelegate.h"
#import "Reachability.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Utils.h"
#import "MinnazManager.h"
#import "Account.h"
#import <Contacts/Contacts.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <Firebase/Firebase.h>
#import "ChatDetailsViewController.h"
#import "AnnouncementViewController.h"
#import "LessonDetailsViewController.h"
#import "AnnouncementFirstMessageViewController.h"
#import "NotificationSetting.h"
#import "Constants.h"

@import Firebase;
@interface AppDelegate (){
    ChatDetailsViewController *objChatDetailsViewController;
    AnnouncementViewController *objAnnouncementViewController;
    LessonDetailsViewController *objLessonDetailsViewController;
    AnnouncementFirstMessageViewController *objAnnouncementFirstMessageVC;
    NotificationSetting *objNotificationSetting;
}
@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self notificationRegister];
    _center  = [UNUserNotificationCenter currentNotificationCenter];
    _center.delegate= self;
    [[AFNetworkActivityLogger sharedLogger]startLogging];
    [AFNetworkActivityLogger sharedLogger].level= AFLoggerLevelDebug;
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Minnaz.sqlite"];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelAll];
    self.viewController = [DashBoardViewController initViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _customSplashviewController = [CustomSplashScreenViewController initViewController];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    self.window.rootViewController = _customSplashviewController;
    [self.window makeKeyAndVisible];
    [self performSelector:@selector(SplashFinished) withObject:nil afterDelay:6.0];
    return YES;
}
-(void)SplashFinished{
    
    _containerVC.panMode = MFSideMenuPanModeNone;
    self.sideMenuViewController = [SideMenuViewController initViewController];
    self.viewController = [DashBoardViewController initViewController];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    _containerVC = [MFSideMenuContainerViewController containerWithCenterViewController:self.navigationController leftMenuViewController:_sideMenuViewController rightMenuViewController:nil];
    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    self.window.rootViewController = _containerVC;
    if (![AccountManager Instance].activeAccount && [Utils getBoolForKey:kTutorialScreenHide] ) {
        [self showLoginScreen];
    }
   else if (![Utils getBoolForKey:kTutorialScreenHide]) {
        [self showToturialScreen];
    }
    [self.window makeKeyAndVisible];
    
}
-(void)showToturialScreen{
    StartupViewController *controller = [StartupViewController initViewController];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    
    if ([url.absoluteString containsString:@"google"]) {
        return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    } else {
        return [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
}

- (BOOL)isReachable {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    return [reach isReachable];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return ([[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation] || [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation]);
}
- (void) notificationRegister{
    [FIRApp configure];
    [self connectToFcm];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && IPHONE_OS_VERSION_MAX_ALLOWED >= IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
        
        // For iOS 10 data message (sent via FCM)
        [FIRMessaging messaging].remoteMessageDelegate = self;
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)connectToFcm {
    if (![[FIRInstanceID instanceID] token]) {
        return;
    }
    [[FIRMessaging messaging] disconnect];
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Unable to connect to FCM. %@", error);
        } else {
            NSLog(@"Connected to FCM.");
        }
    }];
}


- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"%@", remoteMessage.appData);
    // Chek Topview controller in ios
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary* )userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive ||  state == UIApplicationStateActive)
    {
        //Do checking here.
        [self handleRemoteNotificationDate:userInfo];
    }
    
        //   completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[FIRMessaging messaging] disconnect];
    NSLog(@"Disconnected from FCM");
}


-(void)showLoginScreen{
    LoginViewController *controller = [LoginViewController initViewController];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}

- (void)logout {
    [self resetDefaults];
    [AccountManager Instance].activeAccount = nil;
    [[GIDSignIn sharedInstance] signOut];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [loginManager logOut];
    [MinnazManager clearDatabBase];
    [self showLoginScreen];
}
- (void)resetDefaults {

    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    BOOL boolval = [defs boolForKey:kTutorialScreenHide];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
            [defs removeObjectForKey:key];
    }
    [defs synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:boolval forKey:kTutorialScreenHide];
    [defs synchronize];
}

-(void)dashBoard{
    DashBoardViewController *controller = [DashBoardViewController initViewController];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}
-(void)loadNotificationSettings{
    objNotificationSetting = [NotificationSetting newEntity];
    [objNotificationSetting loadMyNotificatinoSettings:^(id result, NSString *error) {
        if ([[result valueForKey:@"data"] count]==0) {
            objNotificationSetting.forum_flag = [NSNumber numberWithBool:YES];
            objNotificationSetting.chat_flag = [NSNumber numberWithBool:YES];
            objNotificationSetting.material_flag = [NSNumber numberWithBool:YES];
            [objNotificationSetting saveSetNotificationSetting:^(id result, NSString *error) {
            }];
        }
    }];
}
-(void)userDidLogin{
    [self loadNotificationSettings];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        NSNotification *myNotification = [NSNotification notificationWithName:@"LoginSucess" object:self userInfo:@"Login Sucess"];
        [[NSNotificationCenter defaultCenter] postNotification:myNotification];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
+(AppDelegate*)appDelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [Utils setAppEndTime];
    if ([[AccountManager Instance].activeAccount.user_id length]>0) {
        Account *accout = [AccountManager Instance].activeAccount;
        NSMutableDictionary *dic = [Utils getAppTime];
        [dic setObject:accout.user_id forKey:@"user"];
        [dic setObject:[dic valueForKey:@"app_startdate"] forKey:@"app_startdate"];
        [dic setObject:[dic valueForKey:@"app_enddate"] forKey:@"app_enddate"];
        [dic setObject:[dic valueForKey:@"minutes"] forKey:@"minutes"];
        [self UpdateAppLog:dic];
    }
}
-(void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [FBSDKAppEvents activateApp];
    [Utils setAppStartTime];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma makr - Notificatino
// In your delegate ...
-(void)handleRemoteNotificationDate:(NSDictionary *)userInfo{
    NSLog(@"%@", userInfo);
    //     type = announcement;
    NSString *strType = [userInfo valueForKey:@"type"];
    
    if ([strType isEqualToString:@"approval"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"Your are approved by school." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[AppDelegate appDelegate] logout];
            
        }]];
        [alert show];
        

    }
    if ([strType isEqualToString:@"add_student"]) {
        Account *account = [AccountManager Instance].activeAccount;
        [account updateAccountWithDelegate:self];
    
        // make call for update user info
    }
    if ([strType isEqualToString:@"deactivate"]) {
        [[AppDelegate appDelegate] logout];
    }
    if ([strType isEqualToString:@"chat"]) {
        NSString *fromUser = [userInfo valueForKey:@"from_user"];
        
        
        // JIGNESH for channge the word count
        if([self.navigationController.visibleViewController isKindOfClass:[DashBoardViewController class]]){
            self.viewController =  (DashBoardViewController *)[[self navigationController] topViewController];
            [self.viewController reloadWordcount];
        }
        else{
            NSNotification *myNotification = [NSNotification notificationWithName:@"reloadUnReadCount" object:self userInfo:@"reloadUnReadCount"];
            [[NSNotificationCenter defaultCenter] postNotification:myNotification];
        }
        if([self.navigationController.visibleViewController isKindOfClass:[ChatDetailsViewController class]]){
            objChatDetailsViewController = (ChatDetailsViewController *)[[self navigationController] topViewController];
            [objChatDetailsViewController reloadData];
            
        }   else{
            
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            if (state == UIApplicationStateInactive) {
                objChatDetailsViewController = [ChatDetailsViewController initViewController:fromUser];
                [self.navigationController pushViewController:objChatDetailsViewController animated:YES];
            }
            else{
                [UIAlertController showAlertInViewController:[Utils topMostController] withTitle:ALERT_TITLE message:[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"] cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:[NSArray arrayWithObjects:@"OK", nil] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    
                    if (buttonIndex == 0) {
                        
                    }
                    if (buttonIndex ==2) {
                        objChatDetailsViewController = [ChatDetailsViewController initViewController:fromUser];
                        [self.navigationController pushViewController:objChatDetailsViewController animated:YES];
                        
                    }
                    
                }];
                
                
            }
        }
    }
    if ([strType isEqualToString:@"announcement"]) {
        
        if([self.navigationController.visibleViewController isKindOfClass:[DashBoardViewController class]]){
            self.viewController =  (DashBoardViewController *)[[self navigationController] topViewController];
            [self.viewController reloadWordcount];
        }
        else{
            NSNotification *myNotification = [NSNotification notificationWithName:@"reloadUnReadCount" object:self userInfo:@"reloadUnReadCount"];
            [[NSNotificationCenter defaultCenter] postNotification:myNotification];
        }
        if([self.navigationController.visibleViewController isKindOfClass:[AnnouncementViewController class]]){
            objAnnouncementViewController = (AnnouncementViewController *)[[self navigationController] topViewController];
            [objAnnouncementViewController reloadData];
            
        }   else{
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            if (state == UIApplicationStateInactive) {
                objAnnouncementFirstMessageVC = [AnnouncementFirstMessageViewController initViewController];
                [self.navigationController pushViewController:objAnnouncementViewController animated:YES];
            }
            else{
                [UIAlertController showAlertInViewController:[Utils topMostController] withTitle:ALERT_TITLE message:[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"] cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:[NSArray arrayWithObjects:@"OK", nil] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    
                    if (buttonIndex == 0) {
                        
                    }
                    if (buttonIndex ==2) {
                        objAnnouncementFirstMessageVC = [AnnouncementFirstMessageViewController initViewController];
                        [self.navigationController pushViewController:objAnnouncementFirstMessageVC animated:YES];
                        
                    }
                    
                }];
            }
            
        }
        
    }
    if ([strType isEqualToString:@"forum"]) {
        NSString *lessonId = [userInfo valueForKey:@"lession"];
        
        if([self.navigationController.visibleViewController isKindOfClass:[LessonDetailsViewController class]]){
            
            objLessonDetailsViewController = (LessonDetailsViewController *)[[self navigationController] topViewController];
            
            [[objLessonDetailsViewController groupView] getAllForumMessage];
        }
        else
        {
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            if (state == UIApplicationStateInactive) {
                NSArray *arr = [Lesson getWithId:lessonId];
                if ([arr count]==0) {
                    return;
                }
                Lesson *objLesson = [Lesson createNewEntity];
                objLesson = [arr objectAtIndex:0];
                objLessonDetailsViewController = [LessonDetailsViewController initViewController:objLesson];
                [objLessonDetailsViewController onclkGroup:nil];
                [self.navigationController pushViewController:objLessonDetailsViewController animated:YES];
                NSLog(@"Log");
                
            }
            else{
                // As per the discussion on scrum;
                
                [UIAlertController showAlertInViewController:[Utils topMostController] withTitle:ALERT_TITLE message:[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"] cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:[NSArray arrayWithObjects:@"OK", nil] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    
                    if (buttonIndex == 0) {
                        
                    }
                    if (buttonIndex ==2) {
                        NSArray *arr = [Lesson getWithId:lessonId];
                        if ([arr count]==0) {
                            return;
                        }
                        Lesson *objLesson = [Lesson createNewEntity];
                        objLesson = [arr objectAtIndex:0];
                        objLessonDetailsViewController = [LessonDetailsViewController initViewController:objLesson];
                        [objLessonDetailsViewController onclkGroup:nil];
                        [self.navigationController pushViewController:objLessonDetailsViewController animated:YES];
                        NSLog(@"Log");
                    }
                    
                }];
            }
        }
    }
}
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//       willPresentNotification:(UNNotification *)notification
//         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//
//    // Notification arrived while the app was in foreground
//   // [Utils showAlertDismissActionWithMessage:[notification.request.content.body description]];
//
//
//  //  completionHandler(UNNotificationPresentationOptionAlert);
//    // This argument will make the notification appear in foreground
//}
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//didReceiveNotificationResponse:(UNNotificationResponse *)response
//         withCompletionHandler:(void (^)())completionHandler {
//
//    // Notification was tapped.
//    [self handleRemoteNotificationDate:response.notification.request.content.userInfo];
//
//    completionHandler();
//}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [Utils showAlertDismissActionWithMessage:notification.alertBody];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSString *str = [NSString
                     stringWithFormat:@"%@",devToken];
    //    _strTokenId = str;
    NSLog(@"device token - %@",str);
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken
                                        type:FIRInstanceIDAPNSTokenTypeSandbox];
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    _strTokenId = refreshedToken;
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error: %@", error.description);
    _strTokenId = @"123456";
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
    
}
- (void)tokenRefreshNotification:(NSNotification *)notification {
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    
    // Connect to FCM since connection may have failed when attempted before having a token.
    //  [self connectToFcm];
    
    // TODO: If necessary send token to application server.
}

#pragma mark - Custom UI

-(void)UpdateAppLog:(NSMutableDictionary *)info{
    [[MinnazManager Instance] LoadApplog:info WithBlock:^(id result, NSString *error) {
        
    }];
}
-(void)accountAuthenticatedWithAccount:(Account *)account{
    [AccountManager Instance].activeAccount = account;
    [[AccountManager Instance] saveAccount];
    
    NSNotification *myNotification = [NSNotification notificationWithName:@"LoginSucess" object:self userInfo:@"Login Sucess"];
    [[NSNotificationCenter defaultCenter] postNotification:myNotification];
}
-(void)accountDidFailAuthentication:(NSString *)error{

}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Minnaz"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


-(void) fireLocalNotification:(NSDate *) dt
{
    
    NSLog(@"fire Local Notification");
    //    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
    //
    //        //Notification Content
    //        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    //        content.body =  [NSString stringWithFormat:@"%@",ntTitle];
    //        content.sound = [UNNotificationSound defaultSound];
    //
    //        //Set Badge Number
    //        content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    //
    //        // Deliver the notification in five seconds.
    //        NSCalendar *calendar = [NSCalendar currentCalendar];
    //
    //        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:[NSDate date]];
    //        NSDateComponents *time = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dt];
    //        components.hour = time.hour;
    //        components.minute = time.minute; //- time_you_want_to_fire_notification_before; //ex. if you want to fire notification before 10 mins then -10 from time.minute
    //
    //
    //        UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    //
    //        //Notification Request
    //        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:content trigger:trigger];
    //
    //        //schedule localNotification
    //        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //        center.delegate = self;
    //        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    //            if (!error) {
    //                NSLog(@"add Notification Request succeeded!");
    //            }
    //        }];
    //
    //    }
    //    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:[NSDate date]];
       
        NSDateComponents *time = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dt];
        
        NSDateComponents *componentsForReferenceDate = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth ) fromDate:[NSDate date]];
        
        [componentsForReferenceDate setDay:components.day];
        [componentsForReferenceDate setMonth:components.month];
        [componentsForReferenceDate setYear:components.year];
        
        NSDate *referenceDate = [calendar dateFromComponents:componentsForReferenceDate];
        NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate: referenceDate];
        
        [componentsForFireDate setHour:time.hour];
        [componentsForFireDate setMinute:time.minute];
        [componentsForFireDate setSecond:time.second];

        
        NSDate *fireDateOfNotification = [calendar dateFromComponents:componentsForFireDate];
        
        NSLog(@"fireDateOfNotification -> %@",fireDateOfNotification);
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = fireDateOfNotification;
        notification.alertBody = ntTitle;
        notification.repeatInterval = /*NSDayCalendarUnit;*/NSCalendarUnitDay;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.timeZone = [NSTimeZone localTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
//-(void)showloading:(NSString *)str{
//    if ([str length]>0) {
//            self.hud = [GIFProgressHUD showHUDWithGIFName:@"minnaz-elephant-trunk_once" title:str addedToView:self.window animated:YES];
//        self.hud.backgroundColor = [UIColor clearColor];
//    }
//    else{
//        self.hud = [GIFProgressHUD showHUDWithGIFName:@"minnaz-elephant-trunk_once" title:Kplease_wait addedToView:self.window animated:YES];
//                self.hud.backgroundColor = [UIColor clearColor];
//    }
//}
//-(void)hideloading{
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        [self wait];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.hud hideWithAnimation:YES];
//        });
//    });
//}
//- (void)wait {
//    sleep(3);
//}

@end
