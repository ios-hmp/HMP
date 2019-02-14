//
//  AllDefines.h
//  HMP
//
//  Created by hcb on 2019/1/25.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef AllDefines_h
#define AllDefines_h

#define MainColor RGBA(252,76,124,1.0)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ADDTarget(btn,tgr,slc) [btn addTarget:tgr action:slc forControlEvents:UIControlEventTouchUpInside]


#define KDURL @"https://itunes.apple.com/cn/app/id1447772016"
#define BUser [BmobUser currentUser]
#define PUSH(vc) [self.navigationController pushViewController:vc animated:YES];
#define POP [self.navigationController popViewControllerAnimated:YES];
#define SHOW(vc) vc?[self showViewController:vc sender:nil]:nil;
#define GOBACK if (self.navigationController) {\
POP;\
}else{\
[self dismissViewControllerAnimated:YES completion:nil];\
}
#define KDFTPAGESIZE 30

#endif /* AllDefines_h */
