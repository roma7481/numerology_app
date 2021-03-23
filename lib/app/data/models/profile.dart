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

  Profile copyWith({
    int profileId,
    String profileName,
    String firstName,
    String lastName,
    String middleName,
    int dob,
    int wedPartnerDate,
    int partnerDate,
    int isSelected,
  }) {
    if ((profileId == null || identical(profileId, this.profileId)) &&
        (profileName == null || identical(profileName, this.profileName)) &&
        (firstName == null || identical(firstName, this.firstName)) &&
        (lastName == null || identical(lastName, this.lastName)) &&
        (middleName == null || identical(middleName, this.middleName)) &&
        (dob == null || identical(dob, this.dob)) &&
        (wedPartnerDate == null ||
            identical(wedPartnerDate, this.wedPartnerDate)) &&
        (partnerDate == null || identical(partnerDate, this.partnerDate)) &&
        (isSelected == null || identical(isSelected, this.isSelected))) {
      return this;
    }

    return new Profile(
      profileId: profileId ?? this.profileId,
      profileName: profileName ?? this.profileName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      dob: dob ?? this.dob,
      wedPartnerDate: wedPartnerDate ?? this.wedPartnerDate,
      partnerDate: partnerDate ?? this.partnerDate,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
