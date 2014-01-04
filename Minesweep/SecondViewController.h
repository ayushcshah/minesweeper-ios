//
//  SecondViewController.h
//  Minesweep
//
//  Created by Prasen Revenkar on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    int rowCount,colCount;
    NSMutableArray *gameData;
    NSMutableArray *bombPosition;
}
-(NSDictionary *) getPosition:(NSInteger )tag;
-(NSString *) getDateFor:(NSMutableArray*)twoDimArray atRow:(NSInteger)x andColums:(NSInteger)y;
-(void) setDateFor2DArrayatRow:(NSInteger)x andColums:(NSInteger)y havingData:(NSString*)data;
-(NSMutableArray *) RandomGenarateBomb:(NSInteger)size withLimit:(NSInteger)limit;
-(NSString *)generateNumbersForRow:(NSInteger ) rowx Col:(NSInteger ) coly;
-(void)animationCode:(BOOL)boolVal forButtton:(UIButton *) btn;
@end
