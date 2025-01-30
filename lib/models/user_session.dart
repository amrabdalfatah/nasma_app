class UserSession {
  int? id;
  int? userId;
  int? sessionId;

  UserSession({
    this.id,
    this.userId,
    this.sessionId,
  });

  UserSession.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    userId = map['user_id'];
    sessionId = map['session_id'];
  }
}
