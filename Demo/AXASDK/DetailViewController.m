//
//  DetailViewController.m
//  AXASDK
//
//  Created by AXAET_APPLE on 15/7/15.
//  Copyright (c) 2015年 axaet. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <AXATagManagerDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITextField *uuidTextField;
@property (nonatomic, strong) UITextField *majorTextField;
@property (nonatomic, strong) UITextField *minorTextField;
@property (nonatomic, strong) UITextField *powerTextField;
@property (nonatomic, strong) UITextField *advInteralTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *modifyBtn;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.uuidTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.uuidTextField.delegate = self;


    self.majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.majorTextField.delegate = self;


    self.minorTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.minorTextField.delegate = self;


    self.powerTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.powerTextField.delegate = self;


    self.advInteralTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.advInteralTextField.delegate = self;


    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.nameTextField.delegate = self;
    self.nameTextField.text = self.beacon.name;

    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.bounds) - 20, 40)];
    self.pswTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"connecting";
    [AXABeaconManager sharedManager].tagDelegate = self;
    [[AXABeaconManager sharedManager] connectBleDevice:self.beacon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail"];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(cell.contentView.frame) - 40, CGRectGetHeight(cell.contentView.frame))];
    
    
    
    switch (indexPath.section) {
        case 0:
            [cell.contentView addSubview:self.uuidTextField];

            break;
        case 1:
            [cell.contentView addSubview:self.majorTextField];

            break;
        case 2:
            [cell.contentView addSubview:self.minorTextField];

            break;
        case 3:
            [cell.contentView addSubview:self.powerTextField];

            break;
        case 4:
            [cell.contentView addSubview:self.advInteralTextField];

            break;
        case 5:
            [cell.contentView addSubview:self.nameTextField];

            break;
        case 6:
            [cell.contentView addSubview:self.pswTextField];
            
            break;
        case 7:
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(cell.contentView.frame) - 40, CGRectGetHeight(cell.contentView.frame))];
            button.tag = 0;
            [button addTarget:self action:@selector(handleWriteAndReset:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:@"reset device" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:button];
            self.resetBtn = button;
        }
            
            break;
        case 8:
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(cell.contentView.frame) - 40, CGRectGetHeight(cell.contentView.frame))];
            button.tag = 1;
            [button addTarget:self action:@selector(handleWriteAndReset:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:@"modify password" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:button];
            self.modifyBtn = button;
        }
            
            break;
            
        default:
            break;
    }
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"proximityUUID";
            break;
        case 1:
            return @"major (0 ~ 65565)";
            break;
        case 2:
            return @"minor (0 ~ 65565)";
            break;
        case 3:
            return @"power (can be 0(0dbm) 1(-6dbm) 2(-23dbm))";
            break;
        case 4:
            return @"advInterval (100 ~ 10000)";
            break;
        case 5:
            return @"name";
            break;
        case 6:
            return @"password(pBeacon_n must add password, ibeacon not need)";
            break;
        case 7:
            return @"write value and reset";
            break;
        case 8:
            return @"modify password 123456 to 456789";
            break;
            
            
        default:
            return @"write value and reset";
            break;
    }
    return nil;
}



#pragma mark - tag delegate

/**
 * did connected beacon
 */
- (void)didConnectBeacon:(AXABeacon *)beacon {
    NSLog(@"%@", beacon.name);
    self.navigationItem.title = @"connected";


    /**
     * make a timer to scheduled timer with a time interval to read RSSI
     * @see twoSecondRead
     * you can change the value of Time Interval what you want.
     */
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:[AXABeaconManager sharedManager] selector:@selector(readRssi) userInfo:nil repeats:YES];
}

- (void)didDiscoverBeacon:(AXABeacon *)beacon {

//        NSLog(@"beacon.rssi == %@", beacon.rssi);
}

- (void)didDisconnectBeacon:(AXABeacon *)beacon {
    NSLog(@"%@", beacon.name);
    self.navigationItem.title = @"disconnect";
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didGetProximityUUIDForBeacon:(AXABeacon *)beacon {
    NSLog(@"uuid: %@", beacon.proximityUUID);
    self.beacon.proximityUUID = beacon.proximityUUID;
    self.uuidTextField.text = self.beacon.proximityUUID;
    [self.tableView reloadData];
}

- (void)didGetMajorMinorPowerAdvInterval:(AXABeacon *)beacon {
    NSLog(@"major: %@ minor: %@ power: %@ advInterval: %@", beacon.major, beacon.minor, beacon.power, beacon.advInterval);
    self.beacon.major = beacon.major;
    self.majorTextField.text = self.beacon.major;
    self.beacon.minor = beacon.minor;
    self.minorTextField.text = self.beacon.minor;
    self.beacon.power = beacon.power;
    self.powerTextField.text = self.beacon.power;
    self.beacon.advInterval = beacon.advInterval;
    self.advInteralTextField.text = self.beacon.advInterval;
    [self.tableView reloadData];
}

- (void)didWritePassword:(BOOL)correct {
    NSLog(@"%d", correct);
    if (correct) {
        [[AXABeaconManager sharedManager] writeProximityUUID:self.uuidTextField.text];
        [[AXABeaconManager sharedManager] writeMajor:self.majorTextField.text withMinor:self.minorTextField.text withPower:self.powerTextField.text withAdvInterval:self.advInteralTextField.text];
        [[AXABeaconManager sharedManager] resetDevice];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"password is wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [[AXABeaconManager sharedManager] disconnectBleDevice:self.beacon];
    }
}

- (void)didModifyPasswordRight {
    [[AXABeaconManager sharedManager] resetDevice];
}

- (void)didReadRssi:(NSNumber *)rssi Beacon:(AXABeacon *)beacon {
    NSLog(@"RSSI --- %@", rssi);
}

#pragma mark - private

- (void)handleWriteAndReset:(UIButton *)sender {
    if (sender.tag) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"modify password" message:@"password will change password 123456 to 456789" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        if ([self.resetBtn.backgroundColor isEqual:[UIColor blueColor]]) {
            self.resetBtn.backgroundColor = [UIColor greenColor];
        } else {
            self.resetBtn.backgroundColor = [UIColor blueColor];
        }
        
        [[AXABeaconManager sharedManager] writePassword:self.pswTextField.text];
    }
    
}

#pragma mark - textField delegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[AXABeaconManager sharedManager] writeModifyPassword:@"123456" newPSW:@"456789"];
    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}


@end
