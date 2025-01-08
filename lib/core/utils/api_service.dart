class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api/v1/";
  static const String login = "${baseUrl}dj-rest-auth/login/";
  static const String logout = "${baseUrl}dj-rest-auth/logout/";
  static const String verifyToken = "${baseUrl}dj-rest-auth/token/verify/";
  static const String passwordChange =
      "${baseUrl}dj-rest-auth/password/change/";
  static const String passwordReset = "${baseUrl}dj-rest-auth/password/reset/";
  static const String passwordResetConfirm =
      "${baseUrl}dj-rest-auth/password/reset/confirm/";
  static const String registration = "${baseUrl}dj-rest-auth/registration/";
  static const String registrationResendEmail =
      "${baseUrl}dj-rest-auth/registration/resend-email/";
  static const String registrationVerifyEmail =
      "${baseUrl}dj-rest-auth/registration/verify-email/";
  // static const String user = "${baseUrl}dj-rest-auth/user/";
  static const String user = "${baseUrl}users/";
  static const String questions = "${baseUrl}pss/questions/";
  static const String pssTest = "${baseUrl}pss/psstest/";
  static const String pssResults = "${baseUrl}pss/pssresults/";
  static const String breathingExercise =
      "${baseUrl}breathing/breathingexercise/";
  static const String userBreathingSession =
      "${baseUrl}breathing/userbreathingsession/";
  static const String breathingSession =
      "${baseUrl}breathing/breathingsession/";
  static const String article = "${baseUrl}article/";
}
