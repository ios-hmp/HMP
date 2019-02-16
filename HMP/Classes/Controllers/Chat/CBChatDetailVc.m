//
//  CBChatDetailVc.m
//  HMP
//
//  Created by hcb on 2019/2/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBChatDetailVc.h"

@interface CBChatDetailVc ()

@end

@implementation CBChatDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)sendMsg{
    /*
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"要发送的消息"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    
    
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:@"audioPath" displayName:@"audio"];
    body.duration = duration;
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:messageExt];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
     */
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
