class Login {
  int? code; 
  bool? status; 
  String? token; 
  int? userID; 
  String? userEmail; 

  Login({this.code, this.status, this.token, this.userID, this.userEmail}); 

  factory Login.fromJson(Map<String, dynamic> obj) { 
    final code = obj['code'] as int;
    final status = obj['status'] as bool;

    if (code == 200 && status) { 
      return Login( 
          code: code, 
          status: status, 
          token: obj['data']['token'], 
          userID: int.tryParse(obj['data']['user']['id'].toString()), 
          userEmail: obj['data']['user']['email']); 
    } else {
      return Login( 
        code: code, 
        status: status, 
      );
    }
  }
}