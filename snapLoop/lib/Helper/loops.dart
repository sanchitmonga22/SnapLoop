import 'package:SnapLoop/Model/loop.dart';

//Chronological order for printing the loop on the homeScreen is:
//  NEW_LOOP
//  NEW_NOTIFICATION
//  EXISTING_LOOP
final loops = [
  Loop(name: "Loop1", numberOfMembers: 100, type: LoopType.EXISTING_LOOP),
  Loop(name: "Loop2", numberOfMembers: 100, type: LoopType.EXISTING_LOOP),
  Loop(name: "Loop3", numberOfMembers: 100, type: LoopType.EXISTING_LOOP),
  Loop(name: "Loop4", numberOfMembers: 100, type: LoopType.EXISTING_LOOP),
  Loop(name: "Loop5", numberOfMembers: 3, type: LoopType.EXISTING_LOOP),
  Loop(name: "Loop6", numberOfMembers: 4, type: LoopType.NEW_LOOP),
  Loop(name: "Loop7", numberOfMembers: 7, type: LoopType.NEW_LOOP),
  Loop(name: "Loop8", numberOfMembers: 3, type: LoopType.NEW_LOOP),
  Loop(name: "Loop9", numberOfMembers: 8, type: LoopType.NEW_NOTIFICATION),
  Loop(name: "Loop10", numberOfMembers: 4, type: LoopType.NEW_NOTIFICATION),
  Loop(name: "Loop11", numberOfMembers: 3, type: LoopType.NEW_NOTIFICATION),
  Loop(name: "Loop12", numberOfMembers: 6, type: LoopType.NEW_NOTIFICATION),
];
