import '../_manager/bindings.dart';

class ScUser {
  String id;
  String email;
  String userName;
  String pwd;
  bool isAdmin;
  String role;
  String firstName;
  String lastName;

  ScUser({
    this.id = '',
    this.email = '',
    this.userName = '',
    this.pwd = '',
    this.isAdmin = false,
    this.role = 'Client',
    this.firstName = '',
    this.lastName = '',
  });

  // Convert ScUser object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'pwd': pwd,
      'isAdmin': isAdmin,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // Create ScUser object from JSON
  factory ScUser.fromJson(Map<String, dynamic> json) {
    return ScUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
      pwd: json['pwd'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      role: json['role'] ?? 'Client',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
