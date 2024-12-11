class BaseUrl{

  static const BaseUrlForUserLoginApi = 'https://staginguserapi.adda247.com/' ;

}
class Header{
//Header to send for verify otp
  static Map<String, String> getHeadersForVerifyApi(String token) {
    return {
      'cp-origin': '11',
      'dname': 'Chrome on Mac Desktop',
      'login_type':'2',
      'x-auth-token': 'fpoa43edty5',
      'x-csrf-token' : token,
      'dID': '1e0def8712fc92f7',
      'dName': 'google sdk_gphone64_x86_64',
      'Content-Type': 'application/json',
    };
  }

  //Header to send for to get Csrf Token from Api
  static Map<String,String> getHeaderToGetCsrfToken ={
    'cp-origin': '11',
    'login_type':'1',
    'x-auth-token': 'fpoa43edty5',

};
//Header to send for send otp
 static Map<String,String> getHeaderToSendOtp={
      'cp-origin': '11',
      'x-auth-token': 'fpoa43edty5',
      'Content-Type': 'application/json'
  };
}
class JsonConstant{

  static const phone='phone';
  static const otp='otp';
}

class EndPoints{

  static const verifyOtpEndPoint='v3/new-otp-verify?src=and';
  static const toGetCsrfToken='csrf/token?src=and';
  static const sendOtpEndPoint= 'new-phone-verify?src=aweb';
}