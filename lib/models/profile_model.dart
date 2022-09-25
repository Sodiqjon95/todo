class ProfileModel {
  ProfileModel( {
    required this.imagePath,
    required this.password,
    required this.lastName,
    required this.userAge,
    required this.firstName,
    required this.userEmail
  });
  final String lastName;
  final String imagePath;
  final int userAge;
  final String password;
  final String firstName;
  final String userEmail;

}