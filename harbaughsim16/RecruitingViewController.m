//
//  RecruitingViewController.m
//  harbaughsim16
//
//  Created by Akshay Easwaran on 3/20/16.
//  Copyright © 2016 Akshay Easwaran. All rights reserved.
//

#import "RecruitingViewController.h"
#import "League.h"
#import "Team.h"
#import "HBRecruitCell.h"
#import "harbaughsim16-Swift.h"

#import "Player.h"
#import "PlayerQB.h"
#import "PlayerRB.h"
#import "PlayerWR.h"
#import "PlayerK.h"
#import "PlayerOL.h"
#import "PlayerF7.h"
#import "PlayerCB.h"
#import "PlayerS.h"

#define TUTORIAL_SHOWN @"kHBTutorialShownKey"

@interface RecruitingViewController ()
{
    // Variables use during recruiting
    //private String teamName;
    //private String teamAbbr;
    //int recruitingBudget;
    //private final String[] letterGrades = {"F", "F+", "D", "D+", "C", "C+", "B", "B+", "A", "A+"};
    
    NSMutableArray<Player*>* playersRecruited;
    NSMutableArray<Player*>* playersGraduating;
    NSMutableArray<Player*>* teamPlayers; //all players
    
    NSMutableArray<Player*>* availQBs;
    NSMutableArray<Player*>* availRBs;
    NSMutableArray<Player*>* availWRs;
    NSMutableArray<Player*>* availOLs;
    NSMutableArray<Player*>* availKs;
    NSMutableArray<Player*>* availSs;
    NSMutableArray<Player*>* availCBs;
    NSMutableArray<Player*>* availF7s;
    NSMutableArray<Player*>* availAll;
    
    NSInteger needQBs;
    NSInteger needRBs;
    NSInteger needWRs;
    NSInteger needOLs;
    NSInteger needKs;
    NSInteger needSs;
    NSInteger needCBs;
    NSInteger needF7s;
    
    int recruitingBudget;
    
    NSMutableArray<Player*>* positions;
    NSMutableArray<Player*>* players;
}
@end


@implementation RecruitingViewController

-(void)reloadRecruits {
    [availAll removeAllObjects];
    
    [availQBs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availRBs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availWRs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availOLs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availF7s sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    
    [availCBs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availSs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availKs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    [availAll addObjectsFromArray:availQBs];
    [availAll addObjectsFromArray:availRBs];
    [availAll addObjectsFromArray:availWRs];
    [availAll addObjectsFromArray:availOLs];
    [availAll addObjectsFromArray:availF7s];
    [availAll addObjectsFromArray:availCBs];
    [availAll addObjectsFromArray:availSs];
    [availAll addObjectsFromArray:availKs];
    
    [availAll sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    
    [self.tableView reloadData];
    self.title = [NSString stringWithFormat:@"Budget: $%d",recruitingBudget];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setToolbarItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithTitle:@"Remaining Needs" style:UIBarButtonItemStylePlain target:self action:@selector(showRemainingNeeds)], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news-sort"] style:UIBarButtonItemStylePlain target:self action:@selector(showRecruitCategories)]]];
    self.navigationController.toolbarHidden = NO;
    
    NSArray *needs = [[HBSharedUtils getLeague].userTeam graduateSeniorsAndGetTeamNeeds];
    needQBs = [needs[0] intValue];
    needRBs = [needs[1] intValue];
    needWRs = [needs[2] intValue];
    needOLs = [needs[4] intValue];
    needF7s  = [needs[7] intValue];
    needCBs  = [needs[6] intValue];
    needSs = [needs[5] intValue];
    needKs = [needs[3] intValue];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 140;
    self.tableView.estimatedRowHeight = 140;
    recruitingBudget = [HBSharedUtils getLeague].userTeam.recruitingMoney;
    
    playersRecruited = [NSMutableArray array];
    playersGraduating = [NSMutableArray array];
    teamPlayers = [NSMutableArray array];
    availQBs = [NSMutableArray array];
    availRBs = [NSMutableArray array];
    availWRs = [NSMutableArray array];
    availOLs = [NSMutableArray array];
    availKs = [NSMutableArray array];
    availSs = [NSMutableArray array];
    availCBs = [NSMutableArray array];
    availF7s = [NSMutableArray array];
    availAll = [NSMutableArray array];
    
    playersGraduating = [[[HBSharedUtils getLeague].userTeam.getGraduatingPlayersString componentsSeparatedByString:@"\n\n"
                         ] mutableCopy];
    recruitingBudget = [HBSharedUtils getLeague].userTeam.teamPrestige * 20;
    
    //recruiting star distribution from here: http://www.cbssports.com/collegefootball/eye-on-college-football/21641769
    // 5-star: 13/100
    // 4-star: 35/100
    // 3-star: 35/100
    // 2-star: 14/100
    // 1-star: 3/100
    // extend that to 200 recruits

    for (int i = 0; i < 26; i++) {
        [availQBs addObject:[PlayerQB newQBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
        [availRBs addObject:[PlayerRB newRBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
        [availWRs addObject:[PlayerWR newWRWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
        [availOLs addObject:[PlayerOL newOLWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
        [availF7s addObject:[PlayerF7 newF7WithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
        [availCBs addObject:[PlayerCB newCBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5]];
        [availSs addObject:[PlayerS newSWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5]];
        [availKs addObject:[PlayerK newKWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:5 team:nil]];
    }
    
    for (int i = 0; i < 70; i++) {
        [availQBs addObject:[PlayerQB newQBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
        [availRBs addObject:[PlayerRB newRBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
        [availWRs addObject:[PlayerWR newWRWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
        [availOLs addObject:[PlayerOL newOLWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
        [availF7s addObject:[PlayerF7 newF7WithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
        [availCBs addObject:[PlayerCB newCBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4]];
        [availSs addObject:[PlayerS newSWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4]];
        [availKs addObject:[PlayerK newKWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:4 team:nil]];
    }
    
    for (int i = 0; i < 70; i++) {
        [availQBs addObject:[PlayerQB newQBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
        [availRBs addObject:[PlayerRB newRBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
        [availWRs addObject:[PlayerWR newWRWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
        [availOLs addObject:[PlayerOL newOLWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
        [availF7s addObject:[PlayerF7 newF7WithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
        [availCBs addObject:[PlayerCB newCBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3]];
        [availSs addObject:[PlayerS newSWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3]];
        [availKs addObject:[PlayerK newKWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:3 team:nil]];
    }
    
    for (int i = 0; i < 28; i++) {
        [availQBs addObject:[PlayerQB newQBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
        [availRBs addObject:[PlayerRB newRBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
        [availWRs addObject:[PlayerWR newWRWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
        [availOLs addObject:[PlayerOL newOLWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
        [availF7s addObject:[PlayerF7 newF7WithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
        [availCBs addObject:[PlayerCB newCBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2]];
        [availSs addObject:[PlayerS newSWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2]];
        [availKs addObject:[PlayerK newKWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:2 team:nil]];
    }
    
    for (int i = 0; i < 6; i++) {
        [availQBs addObject:[PlayerQB newQBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
        [availRBs addObject:[PlayerRB newRBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
        [availWRs addObject:[PlayerWR newWRWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
        [availOLs addObject:[PlayerOL newOLWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
        [availF7s addObject:[PlayerF7 newF7WithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
        [availCBs addObject:[PlayerCB newCBWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1]];
        [availSs addObject:[PlayerS newSWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1]];
        [availKs addObject:[PlayerK newKWithName:[[HBSharedUtils getLeague] getRandName] year:0 stars:1 team:nil]];
    }
    
    [self reloadRecruits];
    [self updatePositionNeeds];
    players = availAll;
    
    //display tutorial alert on first launch
    BOOL tutorialShown = [[NSUserDefaults standardUserDefaults] boolForKey:TUTORIAL_SHOWN];
    if (!tutorialShown) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TUTORIAL_SHOWN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //display intro screen
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Welcome to Recruiting Season, Coach!" message:@"At the end of each season, graduating seniors leave the program and spots open up. As coach, you are responsible for recruiting the next class of players that will lead your team to bigger and better wins. You recruit based on a budget, which is determined by your team's prestige. Better teams will have more money to work with, while worse teams will have to save money wherever they can.\n\nWhen you press \"Start Recruiting\" after the season, you can see who is leaving your program and give you a sense of how many players you will need to replace. Next, the Recruiting menu opens up (where you are now). You can view the Top 200 recruits from every position to see the best of the best. Each Recruit has their positional ratings as well as an Overall and Potential. The cost of each recruit (insert Cam Newton and/or Ole Miss joke here) is determined by how good they are. Once you are done recruiting all the players you need, or that you can afford, press \"Done\" to advance to the next season." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishRecruiting)];
    //[self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissVC)];
    
    self.title = [NSString stringWithFormat:@"Budget: $%d",recruitingBudget];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HBRecruitCell" bundle:nil] forCellReuseIdentifier:@"HBRecruitCell"];
    [self.view setBackgroundColor:[HBSharedUtils styleColor]];
}

-(void)showRecruitCategories {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"View a specific position" message:@"Which position would you like to see?" preferredStyle:UIAlertControllerStyleActionSheet];
    NSString *position = @"";
    if (playersRecruited.count > 0) {
        for (int i = 0; i < 10; i++) {
            if (i == 0) {
                position = @"All Players";
            } else if (i == 1) {
                position = @"Recruited Players";
            } else if (i == 2) {
                position = @"QB";
            } else if (i == 3) {
                position = @"RB";
            } else if (i == 4) {
                position = @"WR";
            } else if (i == 5) {
                position = @"OL";
            } else if (i == 6) {
                position = @"F7";
            } else if (i == 7) {
                position = @"CB";
            } else if (i == 8) {
                position = @"S";
            } else {
                position = @"K";
            }
            [alertController addAction:[UIAlertAction actionWithTitle:position style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i == 0) {
                    players = availAll;
                } else if (i == 1) {
                    players = playersRecruited;
                } else if (i == 2) {
                    players = availQBs;
                } else if (i == 3) {
                    players = availRBs;
                } else if (i == 4) {
                    players = availWRs;
                } else if (i == 5) {
                    players = availOLs;
                } else if (i == 6) {
                    players = availF7s;
                } else if (i == 7) {
                    players = availCBs;
                } else if (i == 8) {
                    players = availSs;
                } else {
                    players = availKs;
                }
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.tableView reloadData];
            }]];

        }
    } else {
        for (int i = 0; i < 9; i++) {
            if (i == 0) {
                position = @"All Players";
            } else if (i == 1) {
                position = @"QB";
            } else if (i == 2) {
                position = @"RB";
            } else if (i == 3) {
                position = @"WR";
            } else if (i == 4) {
                position = @"OL";
            } else if (i == 5) {
                position = @"F7";
            } else if (i == 6) {
                position = @"CB";
            } else if (i == 7) {
                position = @"S";
            } else {
                position = @"K";
            }
            [alertController addAction:[UIAlertAction actionWithTitle:position style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i == 0) {
                    players = availAll;
                } else if (i == 1) {
                    players = availQBs;
                } else if (i == 2) {
                    players = availRBs;
                } else if (i == 3) {
                    players = availWRs;
                } else if (i == 4) {
                    players = availOLs;
                } else if (i == 5) {
                    players = availF7s;
                } else if (i == 6) {
                    players = availCBs;
                } else if (i == 7) {
                    players = availSs;
                } else {
                    players = availKs;
                }
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.tableView reloadData];
            }]];
        }
        
    }
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)showRemainingNeeds {
    NSMutableString *summary = [NSMutableString string];
    
    if (needQBs > 0) {
        if (needQBs > 1) {
            [summary appendFormat:@"Need %ld QBs\n\n",(long)needQBs];
        } else {
            [summary appendFormat:@"Need %ld QB\n\n",(long)needQBs];
        }
    }
    
    if (needRBs > 0) {
        if (needRBs > 1) {
            [summary appendFormat:@"Need %ld RBs\n\n",(long)needRBs];
        } else {
            [summary appendFormat:@"Need %ld RB\n\n",(long)needRBs];
        }
    }
    
    if (needWRs > 0) {
        if (needWRs > 1) {
            [summary appendFormat:@"Need %ld WRs\n\n",(long)needWRs];
        } else {
            [summary appendFormat:@"Need %ld WR\n\n",(long)needWRs];
        }
    }
    
    if (needOLs > 0) {
        if (needOLs > 1) {
            [summary appendFormat:@"Need %ld OLs\n\n",(long)needOLs];
        } else {
            [summary appendFormat:@"Need %ld OL\n\n",(long)needOLs];
        }
    }
    
    if (needF7s > 0) {
        if (needF7s > 1) {
            [summary appendFormat:@"Need %ld F7s\n\n",(long)needF7s];
        } else {
            [summary appendFormat:@"Need %ld F7\n\n",(long)needF7s];
        }
    }
    
    if (needCBs > 0) {
        if (needCBs > 1) {
            [summary appendFormat:@"Need %ld CBs\n\n",(long)needCBs];
        } else {
            [summary appendFormat:@"Need %ld CB\n\n",(long)needCBs];
        }
    }
    
    if (needSs > 0) {
        if (needSs > 1) {
            [summary appendFormat:@"Need %ld Ss\n\n",(long)needSs];
        } else {
            [summary appendFormat:@"Need %ld S\n\n",(long)needSs];
        }
    }
    
    if (needKs > 0) {
        if (needKs > 1) {
            [summary appendFormat:@"Need %ld Ks\n\n",(long)needKs];
        } else {
            [summary appendFormat:@"Need %ld K\n\n",(long)needKs];
        }
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ Remaining Needs",[HBSharedUtils getLeague].userTeam.abbreviation] message:summary preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)updatePositionNeeds {
    /*needQBs = 2  - [HBSharedUtils getLeague].userTeam.teamQBs.count;
    needRBs = 4  - [HBSharedUtils getLeague].userTeam.teamRBs.count;
    needWRs = 6  - [HBSharedUtils getLeague].userTeam.teamWRs.count;
    needOLs = 10 - [HBSharedUtils getLeague].userTeam.teamOLs.count;
    needKs  = 2  - [HBSharedUtils getLeague].userTeam.teamKs.count;
    needSs  = 2  - [HBSharedUtils getLeague].userTeam.teamSs.count;
    needCBs = 6  - [HBSharedUtils getLeague].userTeam.teamCBs.count;
    needF7s = 14 - [HBSharedUtils getLeague].userTeam.teamF7s.count;*/
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return players.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBRecruitCell *cell = (HBRecruitCell*)[tableView dequeueReusableCellWithIdentifier:@"HBRecruitCell"];
    Player *player = players[indexPath.row];
    [cell.nameLabel setText:player.name];
    [cell.positionLabel setText:player.position];
    [cell.ovrLabel setText:[NSString stringWithFormat:@"Ovr: %d",player.ratOvr]];
    [cell.recruitButton setTitle:[NSString stringWithFormat:@"Recruit Player ($%d)", player.cost] forState:UIControlStateNormal];
    [cell.recruitButton addTarget:self action:@selector(recruitPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [cell.recruitButton setTag:indexPath.row];
    [cell.stat1Label setText:@"Potential"];
    [cell.stat1ValueLabel setText:[NSString stringWithFormat:@"%d", player.ratPot]];
    if ([player isKindOfClass:[PlayerQB class]]) {
        [cell.stat2Label setText:@"Throwing Power"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerQB*)player).ratPassPow]];
        [cell.stat3Label setText:@"Throwing Acc."];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerQB*)player).ratPassAcc]];
        [cell.stat4Label setText:@"Evasion"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerQB*)player).ratPassEva]];
    } else if ([player isKindOfClass:[PlayerRB class]]) {
        [cell.stat2Label setText:@"Strength"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerRB*)player).ratRushPow]];
        [cell.stat3Label setText:@"Speed"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerRB*)player).ratRushSpd]];
        [cell.stat4Label setText:@"Evasion"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerRB*)player).ratRushEva]];
    } else if ([player isKindOfClass:[PlayerWR class]]) {
        [cell.stat2Label setText:@"Catching"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerWR*)player).ratRecCat]];
        [cell.stat3Label setText:@"Speed"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerWR*)player).ratRecSpd]];
        [cell.stat4Label setText:@"Evasion"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerWR*)player).ratRecEva]];
    } else if ([player isKindOfClass:[PlayerOL class]]) {
        [cell.stat2Label setText:@"Strength"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerOL*)player).ratOLPow]];
        [cell.stat3Label setText:@"Pass Blocking"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerOL*)player).ratOLBkP]];
        [cell.stat4Label setText:@"Run Blocking"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerOL*)player).ratOLBkR]];
    } else if ([player isKindOfClass:[PlayerF7 class]]) {
        [cell.stat2Label setText:@"Strength"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerF7*)player).ratF7Pow]];
        [cell.stat3Label setText:@"Pass Pressure"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerF7*)player).ratF7Pas]];
        [cell.stat4Label setText:@"Run Stopping"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerF7*)player).ratF7Rsh]];
    } else if ([player isKindOfClass:[PlayerCB class]]) {
        [cell.stat2Label setText:@"Coverage"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerCB*)player).ratCBCov]];
        [cell.stat3Label setText:@"Speed"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerCB*)player).ratCBSpd]];
        [cell.stat4Label setText:@"Tackling"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerCB*)player).ratCBTkl]];
    } else if ([player isKindOfClass:[PlayerS class]]) {
        [cell.stat2Label setText:@"Coverage"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerS*)player).ratSCov]];
        [cell.stat3Label setText:@"Speed"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerS*)player).ratSSpd]];
        [cell.stat4Label setText:@"Tackling"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerS*)player).ratSTkl]];
    } else { // PlayerK class
        [cell.stat2Label setText:@"Kick Power"];
        [cell.stat2ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerK*)player).ratKickPow]];
        [cell.stat3Label setText:@"Kick Accuracy"];
        [cell.stat3ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerK*)player).ratKickAcc]];
        [cell.stat4Label setText:@"Clumsiness"];
        [cell.stat4ValueLabel setText:[NSString stringWithFormat:@"%d",((PlayerK*)player).ratKickFum]];
    }
    
    if (player.cost > recruitingBudget) {
        [cell.recruitButton setEnabled:NO];
        [cell.recruitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        [cell.recruitButton setEnabled:YES];
        [cell.recruitButton setTitleColor:[HBSharedUtils styleColor] forState:UIControlStateNormal];
    }
    
    return cell;
}

-(void)recruitPlayer:(UIButton*)sender {
    Player *p = players[sender.tag];
    [self buyRecruit:p];
}

-(void)buyRecruit:(Player*)player { //Ole Mi$$
    int playerCost = player.cost;
    NSLog(@"COST: $%d",playerCost);
    if (recruitingBudget >= playerCost) {
        recruitingBudget -= playerCost;
        [playersRecruited addObject:player];
        if ([players containsObject:player]) {
            [players removeObject:player];
        }
        
        if ([availAll containsObject:player]) {
            [availAll removeObject:player];
        }
        [player setTeam:[HBSharedUtils getLeague].userTeam];
        
        if ([player isKindOfClass:[PlayerQB class]]) {
            if ([availQBs containsObject:player]) {
                [availQBs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamQBs addObject:(PlayerQB*)player];
            needQBs--;
        } else if ([player isKindOfClass:[PlayerRB class]]) {
            if ([availRBs containsObject:player]) {
                [availRBs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamRBs addObject:(PlayerRB*)player];
            needRBs--;
        } else if ([player isKindOfClass:[PlayerWR class]]) {
            if ([availWRs containsObject:player]) {
                [availWRs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamWRs addObject:(PlayerWR*)player];
            needWRs--;
        } else if ([player isKindOfClass:[PlayerOL class]]) {
            if ([availOLs containsObject:player]) {
                [availOLs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamOLs addObject:(PlayerOL*)player];
            needOLs--;
        } else if ([player isKindOfClass:[PlayerF7 class]]) {
            if ([availF7s containsObject:player]) {
                [availF7s removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamF7s addObject:(PlayerF7*)player];
            needF7s--;
        } else if ([player isKindOfClass:[PlayerCB class]]) {
            if ([availCBs containsObject:player]) {
                [availCBs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamCBs addObject:(PlayerCB*)player];
            needCBs--;
        } else if ([player isKindOfClass:[PlayerS class]]) {
            if ([availSs containsObject:player]) {
                [availSs removeObject:player];
            }
            [[HBSharedUtils getLeague].userTeam.teamSs addObject:(PlayerS*)player];
            needSs--;
        } else { // PlayerK class
            if ([availKs containsObject:player]) {
                [availKs removeObject:player];
            }
           [[HBSharedUtils getLeague].userTeam.teamKs addObject:(PlayerK*)player];
            needKs--;
        }
        
        [[HBSharedUtils getLeague].userTeam sortPlayers];
        
        [self updatePositionNeeds];
        [self reloadRecruits];
        [self.tableView reloadData];
        
        [WhisperBridge shout:@"New Recruit!" message:[NSString stringWithFormat:@"Recruited %@ %@ (Ovr: %d) to %@!",player.position, player.name, player.ratOvr, [HBSharedUtils getLeague].userTeam.abbreviation] toViewController:self];
        self.title = [NSString stringWithFormat:@"Budget: $%d",recruitingBudget];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Coach, you don't have enough money in your budget to recruit this player! Try recruiting a cheaper one instead." preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)dismissVC {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to quit recruiting?" message:@"If you choose to back out, your team's recruiting will be done automatically and you will have no control over who assistant coaches bring to your program. Do you still want to quit, coach?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[HBSharedUtils getLeague] advanceSeason];
        [[HBSharedUtils getLeague].userTeam recruitPlayersFreshman:@[@(needQBs), @(needRBs), @(needWRs), @(needKs), @(needOLs), @(needSs), @(needCBs), @(needF7s)]];
        [[HBSharedUtils getLeague] updateLeagueHistory];
        [[HBSharedUtils getLeague] updateTeamHistories];
        [[HBSharedUtils getLeague].userTeam resetStats];
        [HBSharedUtils getLeague].recruitingStage = 0;
        NSLog(@"SIM RECRUITING");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endedSeason" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newSeasonStart" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)finishRecruiting {
    NSMutableString *summary = [NSMutableString stringWithString:@"Any unfilled positions will be filled by walk-ons.\n\n"];
    
    if (needQBs > 0) {
        if (needQBs > 1) {
            [summary appendFormat:@"Need %ld QBs\n\n",(long)needQBs];
        } else {
            [summary appendFormat:@"Need %ld QB\n\n",(long)needQBs];
        }
    }
    
    if (needRBs > 0) {
        if (needRBs > 1) {
            [summary appendFormat:@"Need %ld RBs\n\n",(long)needRBs];
        } else {
            [summary appendFormat:@"Need %ld RB\n\n",(long)needRBs];
        }
    }
    
    if (needWRs > 0) {
        if (needWRs > 1) {
            [summary appendFormat:@"Need %ld WRs\n\n",(long)needWRs];
        } else {
            [summary appendFormat:@"Need %ld WR\n\n",(long)needWRs];
        }
    }
    
    if (needOLs > 0) {
        if (needOLs > 1) {
            [summary appendFormat:@"Need %ld OLs\n\n",(long)needOLs];
        } else {
            [summary appendFormat:@"Need %ld OL\n\n",(long)needOLs];
        }
    }
    
    if (needF7s > 0) {
        if (needF7s > 1) {
            [summary appendFormat:@"Need %ld F7s\n\n",(long)needF7s];
        } else {
            [summary appendFormat:@"Need %ld F7\n\n",(long)needF7s];
        }
    }
    
    if (needCBs > 0) {
        if (needCBs > 1) {
            [summary appendFormat:@"Need %ld CBs\n\n",(long)needCBs];
        } else {
            [summary appendFormat:@"Need %ld CB\n\n",(long)needCBs];
        }
    }
    
    if (needSs > 0) {
        if (needSs > 1) {
            [summary appendFormat:@"Need %ld Ss\n\n",(long)needSs];
        } else {
            [summary appendFormat:@"Need %ld S\n\n",(long)needSs];
        }
    }
    
    if (needKs > 0) {
        if (needKs > 1) {
            [summary appendFormat:@"Need %ld Ks\n\n",(long)needKs];
        } else {
            [summary appendFormat:@"Need %ld K\n\n",(long)needKs];
        }
    }
    
    [playersRecruited sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return a.ratOvr > b.ratOvr ? -1 : a.ratOvr == b.ratOvr ? 0 : 1;
    }];
    
    NSMutableString *recruitSummary = [NSMutableString string];
    
    for (Player *p in playersRecruited) {
        [recruitSummary appendFormat:@"%@ %@ (Ovr: %d, Pot: %d)\n", p.position, p.name, p.ratOvr, p.ratPot];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you are done recruiting?" message:summary preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //save game
        [[HBSharedUtils getLeague] advanceSeason];
        //[[HBSharedUtils getLeague].userTeam recruitWalkOns];
        [[HBSharedUtils getLeague].userTeam recruitPlayersFreshman:@[@(needQBs), @(needRBs), @(needWRs), @(needKs), @(needOLs), @(needSs), @(needCBs), @(needF7s)]];
        [[HBSharedUtils getLeague] updateLeagueHistory];
        [[HBSharedUtils getLeague] updateTeamHistories];
        [[HBSharedUtils getLeague].userTeam resetStats];
        
        [HBSharedUtils getLeague].recruitingStage = 0;
        [[HBSharedUtils getLeague] save];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newSeasonStart" object:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@'s %ld Recruiting Class",[HBSharedUtils getLeague].userTeam.abbreviation, (long)(2016 + [HBSharedUtils getLeague].leagueHistory.count)] message:recruitSummary preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endedSeason" object:nil];
        [self.presentingViewController presentViewController:alert animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
