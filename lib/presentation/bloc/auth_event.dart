
abstract class AuthEvent{}

class SentOtpEvent extends AuthEvent{
  final String phoneNumber;

   SentOtpEvent(this.phoneNumber);
}

class VerifyOtpEvents extends AuthEvent{
  final String phoneNumber;
  final String otp;
  final String token;

  VerifyOtpEvents(this.phoneNumber,this.otp,this.token);
}

class FetchCsrfTokenEvent extends AuthEvent {} // New event for fetching CSRF