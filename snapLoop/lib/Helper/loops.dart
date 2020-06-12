import 'package:SnapLoop/Model/loop.dart';

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
      name: "Loop1",
      numberOfMembers: 3,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop2",
      name: "Loop2",
      numberOfMembers: 4,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"]),
  Loop(
      id: "Loop3",
      name: "Loop3",
      numberOfMembers: 4,
      type: LoopType.EXISTING_LOOP,
      userIDs: ["2", "4", "5", "1"]),
  Loop(
    id: "Loop4",
    name: "Loop4",
    numberOfMembers: 4,
    type: LoopType.EXISTING_LOOP,
    userIDs: ["2", "4", "5", "1"],
  ),
  Loop(
    id: "Loop20",
    name: "Loop20",
    numberOfMembers: 4,
    type: LoopType.EXISTING_LOOP,
    userIDs: ["2", "4", "5", "1"],
  ),
  Loop(
    id: "Loop5",
    name: "Loop5",
    numberOfMembers: 3,
    type: LoopType.EXISTING_LOOP,
    userIDs: ["2", "4", "5"],
  ),
  Loop(
    id: "Loop6",
    name: "Loop6",
    numberOfMembers: 5,
    type: LoopType.NEW_LOOP,
    userIDs: ["2", "4", "5", "1", "3"],
  ),
  Loop(
    id: "Loop7",
    name: "Loop7",
    numberOfMembers: 5,
    type: LoopType.NEW_LOOP,
    userIDs: ["2", "4", "5", "1", "3"],
  ),
  Loop(
    id: "Loop8",
    name: "Loop8",
    numberOfMembers: 5,
    type: LoopType.NEW_LOOP,
    userIDs: ["2", "4", "5", "1", "3"],
  ),
  Loop(
    id: "Loop9",
    name: "Loop9",
    numberOfMembers: 5,
    type: LoopType.NEW_NOTIFICATION,
    userIDs: ["2", "4", "5", "1", "3"],
  ),
  Loop(
      id: "Loop10",
      name: "Loop10",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop11",
      name: "Loop11",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop12",
      name: "Loop12",
      numberOfMembers: 3,
      type: LoopType.NEW_NOTIFICATION,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop13",
      name: "Loop13",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop14",
      name: "Loop14",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"]),
  Loop(
      id: "Loop15",
      name: "Loop15",
      numberOfMembers: 3,
      type: LoopType.INACTIVE_LOOP_FAILED,
      userIDs: ["1", "2", "3"]),
  Loop(
    id: "Loop16",
    name: "Loop16",
    numberOfMembers: 5,
    type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
    userIDs: ["2", "4", "5", "1", "3"],
  ),
  Loop(
    id: "Loop17",
    name: "Loop17",
    numberOfMembers: 4,
    type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
    userIDs: ["2", "4", "5", "1"],
  ),
  Loop(
    id: "Loop18",
    name: "Loop18",
    numberOfMembers: 4,
    type: LoopType.INACTIVE_LOOP_SUCCESSFUL,
    userIDs: ["2", "5", "1", "3"],
  ),
  Loop(
      id: "Loop19",
      name: "Loop19",
      numberOfMembers: 5,
      userIDs: ["2", "4", "5", "1", "3"],
      type: LoopType.INACTIVE_LOOP_SUCCESSFUL),
];
