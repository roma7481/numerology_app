class Profile {
  final int profileId;

  final String profileName;
  final String firstName;
  final String lastName;
  final String middleName;
  final int dob;
  final int wedPartnerDate;
  final int partnerDate;
  final int isSelected;

  Profile({
    this.profileId,
    this.profileName = '',
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
    this.dob,
    this.wedPartnerDate,
    this.partnerDate,
    this.isSelected = 0,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return new Profile(
      profileId: map['profileId'] as int,
      profileName: map['profileName'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      middleName: map['middleName'] as String,
      dob: map['dob'] as int,
      wedPartnerDate: map['wedPartnerDate'] as int,
      partnerDate: map['partnerDate'] as int,
      isSelected: map['isSelected'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'profileId': this.profileId,
      'profileName': this.profileName,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'middleName': this.middleName,
      'dob': this.dob,
      'wedPartnerDate': this.wedPartnerDate,
      'partnerDate': this.partnerDate,
      'isSelected': this.isSelected,
    } as Map<String, dynamic>;
  }
}
