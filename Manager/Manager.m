
#import "MinnazManager.h"
#import "AppDelegate.h"
#import "AccountManager.h"
#import "Account.h"
#import <MagicalRecord/MagicalRecord.h>
#import <FastEasyMapping/FEMMapping.h>
#import "FEMDeserializer.h"

static Manager *sharedInstance = nil;

@implementation Manager

+ (id) Instance {
    sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[Manager alloc]init];
    }
    return sharedInstance;
}

//Arun :: Whenever you add a class, add it here to clear the database
+ (void)clearDatabBase {
    [SVProgressHUD showWithStatus:Kplease_wait];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        [School MR_truncateAllInContext:localContext];
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
         [SVProgressHUD dismiss];
    }];
}

#pragma TrickyJsons

-(NSMutableDictionary *)ProfileTrickyJson:(NSMutableDictionary *)obj{
    NSMutableDictionary * inDictachievements = [obj valueForKey:@"achievements"];
    NSMutableDictionary * inDictgoals = [obj valueForKey:@"goals"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[inDictachievements valueForKey:@"daily_achievement"] forKey:@"daily_achievement"];
    [dic setObject:[inDictachievements valueForKey:@"monthly_achievement"] forKey:@"monthly_achievement"];
    [dic setObject:[inDictachievements valueForKey:@"weekly_achievement"] forKey:@"weekly_achievement"];
    [dic setObject:[inDictgoals valueForKey:@"daily_count"] forKey:@"daily_count"];
    [dic setObject:[inDictgoals valueForKey:@"monthly_count"] forKey:@"monthly_count"];
    [dic setObject:[inDictgoals valueForKey:@"weekly_count"] forKey:@"weekly_count"];
    [dic setObject:[inDictgoals valueForKey:@"_id"] forKey:@"entity_id"];
    return dic;
}





#pragma mark - API Request

-(void)loadMyFiles:(NSString *)str WithBlock:(ItemLoadedBlock)block{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:str forKey:@"lession"];
        
        Request *request = [[Request alloc] initWithUrl:KStudentMaterial andDelegate:self andMethod:POST];
        [request setParameter:dic forKey:@"where"];
        request.Tag = KStudentMaterial;
        [request startRequest];
    }else{[self InternetConnectionCallback];}
}

-(void)InternetConnectionCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_itemLoadedBlock) {
            _itemLoadedBlock(nil, KINTERNET_CONNECTION);
        }
    });
}


#pragma mark - Request Delegate
-(void)RequestDidSuccess:(Request *)request{
    if (request.IsSuccess) {
      
        if ([request.Tag isEqualToString:KDashboardStatistics]) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {

                    [ProblematicWords MR_truncateAllInContext:localContext];
                     [DashStatisticas MR_truncateAllInContext:localContext];
                     [Statistics_Yearwise_data MR_truncateAllInContext:localContext];
                     [Statistics_Monthwise_data MR_truncateAllInContext:localContext];
                     [Statistics_Weekwise_data MR_truncateAllInContext:localContext];
                     [Statistics_YearwiseWord_data MR_truncateAllInContext:localContext];
                     [Statistics_MonthwiseWord_data MR_truncateAllInContext:localContext];
                     [Statistics_WeekwiseWord_data MR_truncateAllInContext:localContext];
               
              //  NSArray *array = [FEMDeserializer collectionFromRepresentation:[self StatisticsTrickyJson:[[request.serverData objectForKey:@"data"] valueForKey:@"study_data"]] mapping:[DashStatisticas defaultMapping] context:localContext];
                
                NSArray *arrarProblemWord = [FEMDeserializer collectionFromRepresentation:[self TrickyJsonForproblematicsWord:[[request.serverData objectForKey:@"data"] valueForKey:@"problematic_words"]] mapping:[ProblematicWords defaultMapping] context:localContext];
                
                NSArray *arrayA = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"yearwise_data"] mapping:[Statistics_Yearwise_data defaultMapping] context:localContext];
                
                NSArray *arrayB = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"monthwise_data"] mapping:[Statistics_Monthwise_data defaultMapping] context:localContext];
                
                NSArray *arrayC = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"weekwise_data"] mapping:[Statistics_Weekwise_data defaultMapping] context:localContext];
                
                NSArray *arrayD = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"yearwise_worddata"] mapping:[Statistics_YearwiseWord_data defaultMapping] context:localContext];
                
                NSArray *arrayE = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"monthwise_worddata"] mapping:[Statistics_MonthwiseWord_data defaultMapping] context:localContext];
                
                NSArray *arrayF = [FEMDeserializer collectionFromRepresentation:[[request.serverData objectForKey:@"data"] valueForKey:@"weekwise_worddata"] mapping:[Statistics_WeekwiseWord_data defaultMapping] context:localContext];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_itemLoadedBlock) {
                        _itemLoadedBlock(nil, nil);
                    }
                });
            }];
        }
}

-(void)RequestDidFailForRequest:(Request *)request withError:(NSError *)error{
    if (_itemLoadedBlock) {
        
        NSString * aString = [error.userInfo valueForKey:@"message"];
        if ([aString length]==0) {
            aString = @"error";
        }
        _itemLoadedBlock(nil, aString);
    }
}
-(NSMutableArray *)TrickyJsonForproblematicsWord:(NSMutableArray *)arrData{
    NSMutableArray *arrWords = [[NSMutableArray alloc] init];
    int indx = 1;
    
    for (NSMutableDictionary *dd in arrData) {
         NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        [temp setObject:[dd valueForKey:@"_id"] forKey:@"_id"];
        [temp setObject:[NSString stringWithFormat:@"%d",indx] forKey:@"indx"];
        [temp setValue:[dd valueForKey:@"count"] forKey:@"count"];
        [temp setValue:[[[dd valueForKey:@"word"] objectAtIndex:0] valueForKey:@"word"] forKey:@"word"];
        
        [arrWords addObject:temp];
        indx++;
    }
    return arrWords;
}
@end
