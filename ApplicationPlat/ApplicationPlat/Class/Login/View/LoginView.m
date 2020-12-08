//
//  LoginView.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/8/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "LoginView.h"
#import "CutsomIpBtn.h"
#import "LoginViewModel.h"
@interface LoginView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *accountText;
@property (nonatomic, strong) UITextField *pwdText;
@property (nonatomic, strong) UIButton *eyeBtn;
@property (nonatomic, strong) UIButton* remember_button;
@property (nonatomic, strong) CutsomIpBtn * ipBtn;
@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (nonatomic, strong) UILabel *loginPromptLab;
@property (nonatomic, strong) UILabel *pwdPromptLab;
@property (nonatomic, strong) CAShapeLayer *accountLine;
@property (nonatomic, strong) CAShapeLayer *pwdLine;
@property (nonatomic, strong) UIButton *denglu_button;
@end

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self readValue];
    }
    return self;
}
- (void)createUI
{
    
    UILabel *loginLab = [UILabel labelWithframe:CGRectMake(27 * WidthScale, 69 * HeightScale, 150 * WidthScale, 53 * WidthScale) title:NSLocalizedString(@"loginTitle", nil) font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#1B1B4E") line:0];
    loginLab.font = PingFangSCLight(36);
    
    [self addSubview:loginLab];
    
    UILabel *accountLab = [UILabel labelWithframe:CGRectMake(27 * WidthScale, loginLab.bottom + 70 * HeightScale, 100 * WidthScale, 22 * HeightScale) title:NSLocalizedString(@"loginAccount", nil) font:PingFangSCLight(16) color:ColorString(@"#AEB3C0") line:0];
    [self addSubview:accountLab];
    
    self.accountText = [[UITextField alloc]initWithFrame:CGRectMake(27 * WidthScale, accountLab.bottom + 9 * HeightScale, KScreenWidth - 27 * WidthScale * 2, 30 * HeightScale)];
    _accountText.font = [UIFont fontWithName:@"Helvetica" size:16];
    _accountText.textColor = ColorString(@"#3B4664");
    _accountText.delegate = self;
    [self addSubview:_accountText];

//    font-family: Helvetica;
    self.accountLine = [UIView drawLine:CGPointMake(27 * WidthScale, _accountText.bottom + 10 * HeightScale) to:CGPointMake(KScreenWidth - 27 * WidthScale, _accountText.bottom + 10 * HeightScale) color:ColorString(@"#EBEBEB") lineWidth:2];
    [self.layer addSublayer:_accountLine];
    
    
    self.loginPromptLab = [UILabel labelWithframe:CGRectMake(27 * WidthScale, _accountText.bottom + 10 * HeightScale + 2, 200 * WidthScale, 20 * HeightScale) title:@"" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#E02020") line:0];
    _loginPromptLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    //    _loginPromptLab.text = @"帐号不能为空";
    [self addSubview:_loginPromptLab];
    
    
    UILabel *pwdLab = [UILabel labelWithframe:CGRectMake(27 * WidthScale, _loginPromptLab.bottom + 15 * HeightScale , 100 * WidthScale, 22 * HeightScale) title:NSLocalizedString(@"loginPwd", nil) font:PingFangSCLight(16) color:ColorString(@"#AEB3C0") line:0];
    [self addSubview:pwdLab];
    
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(27 * WidthScale, pwdLab.bottom + 9 * HeightScale, KScreenWidth - 27 * WidthScale * 2 - 24 * HeightScale, 30 * HeightScale)];
    _pwdText.font = [UIFont fontWithName:@"Helvetica" size:16];
    _pwdText.textColor = ColorString(@"#3B4664");
    _pwdText.secureTextEntry = YES;
    _pwdText.delegate = self;
    [self addSubview:_pwdText];
    
    self.eyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_pwdText.right, pwdLab.bottom + 9 * HeightScale +3 * HeightScale, 24 * HeightScale, 24 * HeightScale)];
    [_eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_eyeBtn setImage:[SVGKImage imageNamed:@"eye-17"].UIImage forState:UIControlStateNormal];
    [_eyeBtn setImage:[UIImage imageNamed:@"icon_passwordOn"] forState:UIControlStateSelected];
    [self addSubview:_eyeBtn];
    
    
    self.pwdLine = [UIView drawLine:CGPointMake(27 * WidthScale, _pwdText.bottom + 10 * HeightScale) to:CGPointMake(KScreenWidth - 27 * WidthScale, _pwdText.bottom + 10 * HeightScale) color:ColorString(@"#EBEBEB") lineWidth:2];
    [self.layer addSublayer:_pwdLine];
    
    self.pwdPromptLab = [UILabel labelWithframe:CGRectMake(27 * WidthScale, _pwdText.bottom + 10 * HeightScale + 2, 200 * WidthScale, 20 * HeightScale) title:@"" font:[UIFont italicSystemFontOfSize:38] color:ColorString(@"#E02020") line:0];
    _pwdPromptLab.font = PingFangSCLight(12);
    [self addSubview:_pwdPromptLab];
    
    
    self.remember_button = [[UIButton alloc] initWithFrame:CGRectMake(27 * WidthScale, _pwdPromptLab.bottom + 20 * HeightScale, 30 * HeightScale, 30 * HeightScale)];
    [_remember_button setImage:[UIImage imageNamed:@"icon_checkbox_default"] forState:(UIControlStateNormal)];
    [_remember_button addTarget:self action:@selector(rememberbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_remember_button];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_remember_button.right, _pwdPromptLab.bottom + 20 * HeightScale, 150 * WidthScale, 30 * HeightScale)];
    
    [btn setTitle:NSLocalizedString(@"loginRememberBtn", nil) forState:(UIControlStateNormal)];
    btn.width = [NSLocalizedString(@"loginRememberBtn", nil) widthWithFont:PingFangSCLight(16) h:30 * HeightScale];
    btn.titleLabel.font = PingFangSCLight(16);
    [btn setTitleColor:ColorString(@"#AEB3C0") forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(rememberbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:btn];
    self.denglu_button = [[UIButton alloc]initWithFrame:CGRectMake(27 * WidthScale, self.remember_button.bottom +71 * HeightScale, KScreenWidth - 27 * WidthScale * 2, 52 * HeightScale)];
    [_denglu_button setTitle:NSLocalizedString(@"loginBtn", nil) forState:UIControlStateNormal];
    _denglu_button.backgroundColor = DefaColor;
    _denglu_button.titleLabel.font = PingFangSCMedium(17);
    [_denglu_button borderRoundCornerRadius:4];
    [_denglu_button addTarget:self action:@selector(DengLuNetWorking) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_denglu_button];
    self.denglu_button.userInteractionEnabled = YES;

    self.ipBtn = [[CutsomIpBtn alloc]initWithFrame:CGRectMake(27 * WidthScale, self.height - 52 * HeightScale * 2, self.width - 27 * WidthScale * 2, 52 * HeightScale)];
    _ipBtn.backgroundColor = [UIColor colorWithHex:@"#6D7278" alpha:0.15];
    [_ipBtn borderRoundCornerRadius:4];
    _ipBtn.imageV.image =  [SVGKImage imageNamed:@"server"].UIImage;
    [_ipBtn addTarget:self action:@selector(setLineClick) forControlEvents:UIControlEventTouchUpInside];
    [self readIp];
    [self addSubview:_ipBtn];
    
    
    
}
#pragma mark---记住pwd
- (void)rememberbtnAction:(UIButton *)sender
{
    _remember_button.selected = !_remember_button.selected;
    [self rememberPwd:_remember_button];
}
- (void)rememberPwd:(UIButton *)btn
{
    if (btn.selected)
    {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.pwdText.text forKey:@"z_pwd"];
        [[NSUserDefaults standardUserDefaults] setObject:self.accountText.text forKey:@"z_username"];
        [_remember_button setImage:[UIImage imageNamed:@"icon_checkbox_highlight"] forState:(UIControlStateNormal)];
        
    }else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"z_pwd"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"z_username"];
        [_remember_button setImage:[UIImage imageNamed:@"icon_checkbox_default"] forState:(UIControlStateNormal)];
        
    }
}
#pragma mark -- 登录
- (void)DengLuNetWorking
{
    
    
    [_accountText resignFirstResponder];
    [_pwdText resignFirstResponder];
    
//    [self.delegate loginSuccess];
//    
//    self.denglu_button.userInteractionEnabled = YES;
//    return;
    
    if (_accountText.isTouchInside  ) {
        
        if (_accountText.text.length == 0 || _accountText.text.length >= 50 || [_accountText.text isSpecialCharacter]) {
            return;
        }
        
    }
    if (_pwdText.isTouchInside) {
        if (_pwdText.text.length == 0 || _pwdText.text.length >= 50 ) {
            return;
        }
    }
    
    self.denglu_button.userInteractionEnabled = NO;
    CZHWeakSelf(self)
    [self.loginViewModel loginPhoneStr:_accountText.text pwdStr:_pwdText.text success:^(BOOL isSuccess, NSString * _Nonnull errorMsg) {
        
        if (isSuccess) {
            [self rememberPwd:self.remember_button];
            if ([weakself.delegate respondsToSelector:@selector(loginSuccess)]) {
                [weakself.delegate loginSuccess];
            }
        }else{
            
            [CustomAlert alertVcWithMessage:errorMsg Vc:self.superview.viewController];
        }
        self.denglu_button.userInteractionEnabled = YES;
    }];
    
    
    
}

#pragma mark - 读取是否记录密码
- (void)readValue{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"z_username"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"z_pwd"]) {
        self.remember_button.selected = YES;
        self.accountText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"z_username"];
        self.pwdText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"z_pwd"];
        [_remember_button setImage:[UIImage imageNamed:@"icon_checkbox_highlight"] forState:(UIControlStateNormal)];
        
    }else{
        
        [_remember_button setImage:[UIImage imageNamed:@"icon_checkbox_default"] forState:(UIControlStateNormal)];
        
    }
    
}
#pragma mark -- 读取ip地址
- (void)readIp
{
    NSString *domain_ip = [[NSUserDefaults standardUserDefaults] objectForKey:@"domain_ip"];
    NSString *dunkou = [[NSUserDefaults standardUserDefaults] objectForKey:@"duankou"];
    NSString *wangzhi = [NSString stringWithFormat:@"%@:%@", domain_ip,dunkou];
    _ipBtn.titleLab.text = wangzhi;
}
#pragma mark -- 密码是否显示
- (void)eyeBtnAction:(UIButton *)btn
{
    btn.selected =!btn.selected;
    if (btn.selected) {
        _pwdText.secureTextEntry = NO;
    }else{
        _pwdText.secureTextEntry = YES;
        
    }
}
#pragma mark -- 跳转改变ip地址
- (void)setLineClick
{
    if ([_delegate respondsToSelector:@selector(pushTestLineController)]) {
        [self.delegate pushTestLineController];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _accountText) {
        _loginPromptLab.text = @"";
        _accountLine.strokeColor = ColorString(@"#EBEBEB").CGColor;
    }
    if (textField == _pwdText) {
        _pwdPromptLab.text = @"";
        _pwdLine.strokeColor = ColorString(@"#EBEBEB").CGColor;
    }
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _accountText) {
        if (_accountText.text.length ==0) {
//            _loginPromptLab.text = @"帐号不能为空";
            _loginPromptLab.text = NSLocalizedString(@"loginPhoneKongAlert", nil);
            _accountLine.strokeColor = ColorString(@"#E02020").CGColor;
            
        }else{
            if ([textField.text isSpecialCharacter]) {
//                _loginPromptLab.text = @"帐号不能含有特殊字符";
                _loginPromptLab.text = NSLocalizedString(@"loginPhoneTeshuAlert", nil);

                _accountLine.strokeColor = ColorString(@"#E02020").CGColor;
            }else{
                if (textField.text.length >= 50) {
//                    _loginPromptLab.text = @"帐号不能含有特殊字符";
                    _loginPromptLab.text = NSLocalizedString(@"loginPhoneTeshuAlert", nil);

                    _accountLine.strokeColor = ColorString(@"#E02020").CGColor;
                }else{
                    _loginPromptLab.text = @"";
                    _accountLine.strokeColor = ColorString(@"#EBEBEB").CGColor;
                }
            }
        }
        
    }
    if (textField == _pwdText) {
        if (_pwdText.text.length ==0) {
//            _pwdPromptLab.text = @"密码不能为空";
            _pwdPromptLab.text = NSLocalizedString(@"loginPwdKongAlert", nil);

            _pwdLine.strokeColor = ColorString(@"#E02020").CGColor;
            
        }else{
//            if ([textField.text isSpecialCharacter]) {
//                _pwdPromptLab.text = @"密码不能含有特殊字符";
//                _pwdLine.strokeColor = ColorString(@"#E02020").CGColor;
//            }else{
                if (textField.text.length >= 50) {
//                    _pwdPromptLab.text = @"密码不能含有特殊字符";
                    _pwdPromptLab.text = NSLocalizedString(@"loginPwdTeshuAlert", nil);

                    _pwdLine.strokeColor = ColorString(@"#E02020").CGColor;
                }else{
                    _pwdPromptLab.text = @"";
                    _pwdLine.strokeColor = ColorString(@"#EBEBEB").CGColor;
                }
//            }
        }
    }
}

- (LoginViewModel *)loginViewModel
{
    if (_loginViewModel==nil) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}
@end
