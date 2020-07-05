import 'package:SnapLoop/Model/user.dart';

/// author: @sanchitmonga22

final user = User(
    userID: "1",
    displayName: "Monga",
    email: "sanchitmonga22@gmail.com",
    score: 783,
    username: "sanchitmonga22",
    friendsIds: ["2", "3", "5", "4"],
    loopIDs: ["1", "2", "3", "4", "5"]);

final friends = [
  FriendsData(
      displayName: "Baali",
      status: "Busy",
      userID: "2",
      email: "aahishbali@gmail.com",
      score: 563,
      username: "Aahish",
      commonLoops: ["1", "2", "3", "4", "5"]),
  FriendsData(
      displayName: "Gotti",
      status: "Online",
      userID: "3",
      email: "gottii@gmail.com",
      score: 753,
      username: "Gnandeep",
      commonLoops: ["1", "2", "3", "4", "5"]),
  FriendsData(
      status: "Online",
      userID: "4",
      displayName: "Anuj",
      email: "anushm@gmail.com",
      score: 143,
      username: "Anush",
      commonLoops: ["1", "2", "3", "4", "5"]),
  FriendsData(
      status: "Busy",
      userID: "5",
      displayName: "Prekki",
      email: "aprekki@gmail.com",
      score: 53,
      username: "Aditya",
      commonLoops: ["1", "2", "3", "4", "5"]),
];

// final users = [
//   User(
//       friendsIds: ["1", "3"],
//       userID: "2",
//       displayName: "Baali",
//       email: "aahishbali@gmail.com",
//       score: 563,
//       username: "Aahish",
//       loopIDs: ["1", "2", "3", "4", "5"]),
//   User(
//       friendsIds: ["2", "1", "3"],
//       userID: "3",
//       displayName: "Gotti",
//       email: "gottii@gmail.com",
//       score: 753,
//       username: "Gnandeep",
//       loopIDs: ["1", "2", "3", "4", "5"]),
//   User(
//       friendsIds: ["5", "3"],
//       userID: "4",
//       displayName: "Anuj",
//       email: "anushm@gmail.com",
//       score: 143,
//       username: "Anush",
//       loopIDs: ["1", "2", "3", "4", "5"]),
//   User(
//       friendsIds: ["1", "4"],
//       userID: "5",
//       displayName: "Prekki",
//       email: "aprekki@gmail.com",
//       score: 53,
//       username: "Aditya",
//       loopIDs: ["1", "2", "3", "4", "5"]),
// ];
