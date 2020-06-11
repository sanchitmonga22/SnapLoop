import 'package:SnapLoop/Model/user.dart';

final user = User(
    userID: "1",
    displayName: "Monga",
    email: "sanchitmonga22@gmail.com",
    score: 783,
    username: "sanchitmonga22",
    friendsIds: ["2", "3", "5"]);

final users = [
  User(
      friendsIds: ["1", "3"],
      userID: "2",
      displayName: "Baali",
      email: "aahishbali@gmail.com",
      score: 563,
      username: "Aahish"),
  User(
      friendsIds: ["2", "1", "3"],
      userID: "3",
      displayName: "Gotti",
      email: "gottii@gmail.com",
      score: 753,
      username: "Gnandeep"),
  User(
      friendsIds: ["5", "3"],
      userID: "4",
      displayName: "Anuj",
      email: "anushm@gmail.com",
      score: 143,
      username: "Anush"),
  User(
      friendsIds: ["1", "4"],
      userID: "5",
      displayName: "Prekki",
      email: "aprekki@gmail.com",
      score: 53,
      username: "Aditya"),
];
