
#import <Foundation/Foundation.h>
#import "Request.h"
#import "RequestDelegate.h"
#import "Constants.h"

@interface MinnazManager : NSObject <RequestDelegate> {
    ItemLoadedBlock _itemLoadedBlock;
}

+ (id) Instance;

+ (void)clearDatabBase;



-(void)loadMyFiles:(NSString *)str WithBlock:(ItemLoadedBlock)block;


@end
