//
//  SecondViewController.m
//  Minesweep
//
//  Created by Prasen Revenkar on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
        
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)createGridWithRows:(NSInteger )x Columns:(NSInteger)y{
    gameData=[[NSMutableArray alloc] init];
//  initialize an Empty Array
    for (int i=0; i<(x*y); i++) {
        [gameData addObject:@"0"];
    }
    for (int i=0; i<gameData.count; i++) {
        NSLog(@"data in gameData Array %@",[gameData objectAtIndex:i]);
    }
    NSLog(@"%d",gameData.count);
    NSLog(@"gameData Array Size %d",gameData.count);
//  generate Random Bomb and Insert in GameData Array
    [self RandomGenarateBomb:7 withLimit:(x*y)];
    NSLog(@"%@",bombPosition);
    for (int i=0; i<bombPosition.count; i++) {
        [gameData removeObjectAtIndex:[[bombPosition objectAtIndex:i] intValue]];
        [gameData insertObject:@"X" atIndex:[[bombPosition objectAtIndex:i] intValue]];
         NSLog(@"Mines Are At %d",[[bombPosition objectAtIndex:i] intValue]);
    }
    
//Insert Numbers surrounding The Mine.
    for (int col=0 ; col<y; col++) {       
        for (int row=0; row < x; row++) {
            [self generateNumbersForRow:row Col:col];
        }
    }
    
    int rowLimit = x,colLimit = y,count=0;
    colCount=colLimit;
    rowCount= rowLimit;

    if (rowLimit > 3 && colLimit > 3) {
        int x = 1;
        int y = 1;
        int tag;
        tag = 0;
        for (int col=0 ; col<colLimit; col++) {       
            for (int row=0; row < rowLimit; row++) {
                UIButton *theButton=[[UIButton alloc]initWithFrame:CGRectMake(x, y, (310/rowLimit)-1, (310/rowLimit)-1)];
            
                //set their selector using add selector
                [theButton addTarget:self action:@selector(imgButtonClicked:) 
                forControlEvents:UIControlEventTouchDown ];
            
                theButton.backgroundColor = [UIColor orangeColor];
                theButton.layer.borderWidth = 1;
                theButton.layer.borderColor = [[UIColor orangeColor]CGColor];
//                [theButton setTitle:[gameData objectAtIndex:count] forState:UIControlStateNormal];
                theButton.tag=count+1;

                count++;
                [self.view addSubview:theButton];
                x+=(310/rowLimit)+1;
            }
            y+=310/rowLimit;
            x = 1;
        }       
    } 
}

-(NSString *) getDateFor:(NSMutableArray*)twoDimArray atRow:(NSInteger)row andColums:(NSInteger)col{
    if ((row>=0&&col>=0)&&(row<rowCount&&col<colCount)) {    
        int index= ((rowCount*col)+row);   
        NSLog(@"Index:%d",index);
        return [twoDimArray objectAtIndex:index];
    }
    return @"0";
}
-(void) setDateFor2DArrayatRow:(NSInteger)row andColums:(NSInteger)col havingData:(NSString*)data{
    int index= ((rowCount*col)+row);
    [gameData insertObject:data atIndex:index];   
}

-(NSDictionary *) getPosition:(NSInteger )tag {
    NSDictionary *Postion= [[NSDictionary alloc]init];
    NSString *x,*y;
    y= [NSString  stringWithFormat: @"%d",tag/rowCount];
    x=[NSString  stringWithFormat: @"%d",tag%rowCount];    
    
    Postion =[NSDictionary dictionaryWithObjectsAndKeys:x,@"XPos",y,@"YPos", nil];
    return Postion;
}
-(NSMutableArray *) RandomGenarateBomb:(NSInteger)size withLimit:(NSInteger)limit{
    
    bombPosition=[[NSMutableArray alloc] init];   
    int noOfBomb=size;
    for(int i=0;i<noOfBomb;i++)
    {         
        if(bombPosition.count==0) {
            [bombPosition addObject:[NSString stringWithFormat:@"%d",(arc4random()%limit)]];
            NSLog(@"%@",@"First Random Value");
            
        }else{
            NSString *randomNo=[NSString stringWithFormat:@"%d",(arc4random()%(limit))];
            int isRandomNoExist= 0;
            for (int j= 0; j<bombPosition.count; j++) {
                
                if (([[bombPosition objectAtIndex:j]isEqualToString:randomNo])) {
                    //[bombPosition addObject:randomNo];
                    isRandomNoExist= 1;
                    NSLog(@"Random Number exist");
                    i--;
                    break;
                }else {
                    isRandomNoExist = 0;
                }
                
            }
            if (isRandomNoExist == 0) {
                [bombPosition addObject:randomNo];
            }
        }   
    }
    return bombPosition;
}


- (IBAction)imgButtonClicked:(UIButton *)btn{

    NSLog(@"Tag Number %d",btn.tag-1);
//    NSLog(@"colCount:%d RowCount:%d",colCount ,rowCount);
//    NSLog(@"x:%d y:%d",(btn.tag/rowCount),(btn.tag%rowCount));
//    NSLog(@"x:%@ y:%@",[[self getPosition:btn.tag] objectForKey:@"XPos"],[[self getPosition:btn.tag] objectForKey:@"YPos"]);

    NSString *x=[NSString stringWithFormat:@"%@",[[self getPosition:btn.tag-1] objectForKey:@"XPos"]];
    NSString *y=[NSString stringWithFormat:@"%@",[[self getPosition:btn.tag-1] objectForKey:@"YPos"]];
   
//    NSLog(@"Data in game Array %@",[self getDateFor:gameData atRow:[x intValue] andColums:[y intValue]]);  
    UIButton *button = (UIButton *)[self.view viewWithTag:btn.tag];
    [button setTitle:[self generateNumbersForRow:[x intValue] Col:[y intValue]] forState:UIControlStateNormal];
    if ([[self generateNumbersForRow:[x intValue] Col:[y intValue]]isEqualToString:@"X"]) {  
        
        //Show All Mines
        for (int i = 0; i<bombPosition.count; i++) {
            NSLog(@"Mine Position %@",[bombPosition objectAtIndex:i]);
            NSLog(@"Mine Position %@",[gameData objectAtIndex:[[bombPosition objectAtIndex:i]intValue]]);
            UIButton *button = (UIButton *)[self.view viewWithTag:[[bombPosition objectAtIndex:i]intValue]+1];
            [button setTitle:[gameData objectAtIndex:[[bombPosition objectAtIndex:i]intValue]] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor redColor]; 
            
        }
        
        
        
        button.backgroundColor = [UIColor redColor];        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"" delegate:self  cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        alert.message= @"Oopss!! It was A Mine Please try again";
        [alert show];
        //[self.navigationController popViewControllerAnimated:YES];
    }
    else {
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self animationCode:YES forButtton:button];
    }
   
    NSLog(@"gameData Array Size :%d",gameData.count);

}
-(void)animationCode:(BOOL)boolVal forButtton:(UIButton *) btn{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
    
//    [UIView setAnimationTransition:(boolVal)?UIViewAnimationTransitionCurlUp:UIViewAnimationTransitionCurlDown forView:btn cache:YES];	
	[UIView setAnimationTransition:(boolVal)?UIViewAnimationTransitionFlipFromLeft:UIViewAnimationTransitionFlipFromRight  forView:btn cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.50];
	[UIView commitAnimations];
}

-(NSString *)generateNumbersForRow:(NSInteger ) rowx Col:(NSInteger ) coly {
    if(!([[self getDateFor:gameData atRow:rowx andColums:coly]isEqualToString:@"X"])){
        NSInteger num=0;
        NSLog(@"%@",@"Started to Execute Number Generation Function");
        NSLog(@"%d",gameData.count);
        if([[self getDateFor:gameData atRow:rowx-1 andColums:coly-1]isEqualToString:@"X"])
        {//(-1,-1)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx andColums:coly-1]isEqualToString:@"X"]) {
            //(0,-1)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx+1 andColums:coly-1]isEqualToString:@"X"]) {
            //(+1,-1)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx-1 andColums:coly]isEqualToString:@"X"]) {
            //(-1,0)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx+1 andColums:coly]isEqualToString:@"X"]) {
            //(+1,0)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx-1 andColums:coly+1]isEqualToString:@"X"]) {
            //(-1,+1)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx andColums:coly+1]isEqualToString:@"X"]) {
            //(0,+1)
            num++;
        }
        if ([[self getDateFor:gameData atRow:rowx+1 andColums:coly+1]isEqualToString:@"X"]) {
            //(+1,+1)
            num++;
        }
        NSLog(@"Number Of Mines Arround the Block Are %d",num);
        return [NSString stringWithFormat:@"%d",num ];
    }
    //Event to Detect User Losses
        return @"X";
    
}
@end    
