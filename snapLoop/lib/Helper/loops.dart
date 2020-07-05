import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';

/// author: @sanchitmonga22

// This will be sorted according to the time of the creation
final chat = Chat(chatID: "chat", chat: [
  ChatInfo(senderDisplayName: null, content: null, time: null, senderID: null),
  ChatInfo(senderDisplayName: null, content: null, time: null, senderID: null),
  ChatInfo(senderDisplayName: null, content: null, time: null, senderID: null)
]);

//Chronological order for printing the loop on the homeScreen is:
//  NEW_LOOP
//  NEW_NOTIFICATION
//  EXISTING_LOOP

//Order for printing the inactive loops:
// INACTIVE_LOOPS_SUCCESSFUL
// INACTIVE_LOOPS_FAILED
final loops = [
  Loop(
      id: "1",
      chatID: "1",
      creatorId: "1",
      name: "Trump",
      numberOfMembers: 5,
      type: LoopType.NEW_LOOP,
      userIDs: ["1", "2", "3", "4", "5"]),
  Loop(
      id: "2",
      chatID: "2",
      creatorId: "2",
      name: "Desi Gang",
      numberOfMembers: 5,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3", "4", "5"]),
  Loop(
      id: "3",
      chatID: "3",
      creatorId: "3",
      name: "RIT students",
      numberOfMembers: 5,
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
      userIDs: ["1", "2", "3", "4", "5"]),
  Loop(
      id: "4",
      chatID: "4",
      creatorId: "4",
      name: "Team SnapLoop",
      numberOfMembers: 5,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3", "4", "5"]),
  Loop(
      id: "5",
      chatID: "5",
      creatorId: "5",
      name: "RIT Gang",
      numberOfMembers: 5,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3", "4", "5"])
];
