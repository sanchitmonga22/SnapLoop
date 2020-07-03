import 'package:SnapLoop/Model/chat.dart';
import 'package:SnapLoop/Model/loop.dart';

/**
 * author: @sanchitmonga22
 */
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
      id: "Loop1",
      creatorId: "1",
      name: "Loop1",
      numberOfMembers: 14,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3", "4", "5", "6"],
      chatID: "chat1"),
  Loop(
      id: "Loop1",
      creatorId: "1",
      name: "Loo1",
      numberOfMembers: 15,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3", "4", "5", "6"],
      chatID: "chat1"),
  Loop(
      id: "Loop2",
      creatorId: "1",
      name: "Loo2",
      numberOfMembers: 16,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3", "4", "5", "6"],
      chatID: "chat1"),
  Loop(
      id: "Loop3",
      creatorId: "1",
      name: "Loo3",
      numberOfMembers: 17,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3", "4", "5", "6"],
      chatID: "chat1"),
  Loop(
      creatorId: "4",
      id: "Loop2",
      name: "Loop2",
      numberOfMembers: 18,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"],
      chatID: "chat1"),
  Loop(
      creatorId: "5",
      id: "Loop3",
      name: "Loop3",
      numberOfMembers: 8,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"],
      chatID: "chat1"),
  Loop(
      creatorId: "1",
      id: "Loop4",
      name: "Loop4",
      numberOfMembers: 11,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"],
      chatID: "chat1"),
  Loop(
      creatorId: "5",
      id: "Loop20",
      name: "Loop20",
      numberOfMembers: 12,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"],
      chatID: "chat1"),
  Loop(
      creatorId: "5",
      id: "Loop5",
      name: "Loop5",
      numberOfMembers: 3,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5"],
      chatID: "chat1"),
  Loop(
      creatorId: "2",
      id: "Loop6",
      name: "Loop6",
      numberOfMembers: 5,
      type: LoopType.NEW_LOOP,
      userIDs: ["2", "4", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "4",
      id: "Loop7",
      name: "Loop7",
      numberOfMembers: 5,
      type: LoopType.NEW_LOOP,
      userIDs: ["2", "4", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "4",
      id: "Loop8",
      name: "Loop8",
      numberOfMembers: 5,
      type: LoopType.NEW_LOOP,
      userIDs: ["2", "4", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "4",
      id: "Loop9",
      name: "Loop9",
      numberOfMembers: 5,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["2", "4", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "1",
      id: "Loop10",
      name: "Loop10",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "1",
      id: "Loop11",
      name: "Loop11",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "3",
      id: "Loop12",
      name: "Loop12",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "2",
      id: "Loop13",
      name: "Loop13",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "2",
      id: "Loop14",
      name: "Loop14",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "3",
      id: "Loop15",
      name: "Loop15",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "2",
      id: "Loop16",
      name: "Loop16",
      numberOfMembers: 5,
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
      userIDs: ["2", "4", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "5",
      id: "Loop17",
      name: "Loop17",
      numberOfMembers: 4,
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
      userIDs: ["2", "4", "5", "1"],
      chatID: "chat1"),
  Loop(
      creatorId: "2",
      id: "Loop18",
      name: "Loop18",
      numberOfMembers: 40,
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
      userIDs: ["2", "5", "1", "3"],
      chatID: "chat1"),
  Loop(
      creatorId: "1",
      id: "Loop19",
      name: "Loop19",
      numberOfMembers: 5,
      userIDs: ["2", "4", "5", "1", "3"],
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
      chatID: "chat1")
];
