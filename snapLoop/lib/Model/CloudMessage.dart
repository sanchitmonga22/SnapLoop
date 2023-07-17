class CloudMessage {
  final String title;
  final String message;
  final String body;
  CloudMessage({required this.title, required this.body, required this.message});

  dynamic toJson() {
    return {"title": this.title, "message": this.message, "body": this.body};
  }
}
