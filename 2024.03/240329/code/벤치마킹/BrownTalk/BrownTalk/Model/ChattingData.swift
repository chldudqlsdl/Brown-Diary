//
//  ChattingData.swift
//  BrownTalk
//
//  Created by Youngbin Choi on 3/29/24.
//

import Foundation

enum User: String {
    case hue = "joy"
    case jack = "fear"
    case bran = "angry"
    case den = "sorrow"
    case user
    
    var profileImage: String {
        switch self {
        default: return rawValue
        }
    }
}

struct ChatRoom {
    let chatroomId : Int
    let chatroomImage : String
    let chatroomName: String
    var chatList: [Chat]
}

struct Chat {
    let user : User
    let date : String
    let message : String
}

let chatRoomList : [ChatRoom] = [
   
    ChatRoom(chatroomId: 1,
             chatroomImage: User.hue.profileImage,
             chatroomName: User.hue.rawValue,
             chatList: [
                Chat(user: .hue,
                     date: "2024-01-11 15:30",
                     message: "열심히 공부하고 계시는거죠?"),
                Chat(user: .user,
                     date: "2024-01-11 15:48",
                     message: "열심히는 하고있어요..."),
                Chat(user: .user,
                     date: "2024-01-11 15:49",
                     message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ...."),
                Chat(user: .hue,
                     date: "2024-01-12 21:30",
                     message: "오...그러면... 내일 깃허브랑 블로그 전체 검사 진행 진행하도록 하겠습니다..."),
                Chat(user: .hue,
                     date: "2024-01-12 21:31",
                     message: "화이팅 ^^"),
             ]),
    ChatRoom(chatroomId: 2,
             chatroomImage: User.jack.profileImage,
             chatroomName: User.jack.rawValue,
             chatList: [
                Chat(user: .jack,
                     date: "2024-01-11 11:20",
                     message: "\(User.user.rawValue)님~ 오늘 깃허브를 보니 커밋을 안해주셨더라구요~~~\n깃허브 푸쉬 부탁드릴게요~~~\n설마 과제를 안하신건 아니시겠죠~~?!"),
                Chat(user: .user,
                     date: "2024-01-11 11:23",
                     message: "제.. 제가 푸쉬를 안했군요... 얼른 푸쉬하도록 하겠습니다..."),
                Chat(user: .jack,
                     date: "2024-01-11 13:29",
                     message: "00님~ 아직도 푸쉬가 안되어있네요 ^_^ 수업 끝나고 면담 진행하도록 할게요~~ 끝나고 남아주세요~"),
                Chat(user: .user,
                     date: "2024-01-11 13:31",
                     message: "넵.."),
                Chat(user: .jack,
                     date: "2024-01-11 14:42",
                     message: "면담 때 매일 10시까지 남아있겠다는 말 잘 지키시는지 확인할게요~~/n아 매일은 오늘도 포함인거 아시죠?!"),
                Chat(user: .user,
                     date: "2024-01-11 14:50",
                     message: "네...."),
                Chat(user: .jack,
                     date: "2024-01-12 20:30",
                     message: "안녕히 주무세요"),
             ]),
    ChatRoom(chatroomId: 3,
             chatroomImage: User.bran.profileImage,
             chatroomName: User.bran.rawValue,
             chatList: [
                Chat(user: .bran,
                     date: "2024-01-11 21:10",
                     message: "저번 과제 잘 봤습니다!!\n저번 과제에서 이러쿵 저러쿵 부분을 개선해볼 수 있을 것 같은데,\n그 부분까지 개선하셔서 다시 푸쉬해주실 수 있으시겠죠?\n설마 못한다고는 하지 않으시겠죠?"),
                Chat(user: .user,
                     date: "2024-01-12 11:12",
                     message: "브랜님! 다름 아니라 제가 어제 저녁에 쪼오오오끔 피곤해서 자느라 다 못했습니다...!"),
                Chat(user: .bran,
                     date: "2024-01-12 11:30",
                     message: "보고체계 진행하도록 하겠습니다. 수고하세요."),
                Chat(user: .user,
                     date: "2024-01-12 11:31",
                     message: "한번만 봐주세요.. 다음부터는 다 제출할게요 ㅠㅠㅠ"),
                Chat(user: .bran,
                     date: "2024-01-12 11:32",
                     message: "안됩니다."),
                Chat(user: .user,
                     date: "2024-01-12 16:30",
                     message: "예외처리로 한번만 봐주시면 안되나요...?"),
                Chat(user: .bran,
                     date: "2024-01-12 19:30",
                     message: "수고하세요"),
             ]),
    ChatRoom(chatroomId: 4,
             chatroomImage: User.den.profileImage,
             chatroomName: User.den.rawValue,
             chatList: [
                Chat(user: .den,
                     date: "2024-01-12 10:30",
                     message: "\(User.user.rawValue)님 잔디가 숭숭 빠지셔서 황무지 되시겠어요~ 푸쉬 기다리고 있을게요~"),
                Chat(user: .den,
                     date: "2024-01-12 10:31",
                     message: "잔디가 목마르다고 물 달라고 하네요~~"),
                Chat(user: .den,
                     date: "2024-01-12 11:31",
                     message: "어디가셨어요~~"),
                Chat(user: .den,
                     date: "2024-01-12 15:32",
                     message: "차단한 건 아니시죠, \(User.user.rawValue)님?"),
                Chat(user: .user,
                     date: "2024-01-12 16:10",
                     message: "오늘 주말이에요... 살려주세요.."),
                Chat(user: .den,
                     date: "2024-01-12 16:30",
                     message: "잔디는 생물이라 매일 물줘야 살아요."),
                Chat(user: .den,
                     date: "2024-01-12 16:32",
                     message: "푸시\n푸시\n커밋\n커밋\n으하하하\n푸시푸시"),
                Chat(user: .user,
                     date: "2024-01-12 19:10",
                     message: "오늘 주말이에요... 살려주세요 덴님... 주말이 평일보다 힘듭니다"),
                Chat(user: .den,
                     date: "2024-01-12 19:13",
                     message: "저도 주말인데 \(User.user.rawValue)님 깃허브 보고 있잖아요...?"),
                Chat(user: .user,
                     date: "2024-01-12 19:14",
                     message: "..."),
             ])
]
