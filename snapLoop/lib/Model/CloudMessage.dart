class CloudMessage {
  final String title;
  final String message;
  final String body;
  CloudMessage({this.title, this.body, this.message});

  dynamic toJson() {
    return {"title": this.title, "message": this.message, "body": this.body};
  }
}
