class Profile {
  final int? profileId;

  final String? profileName;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final int? dob;
  final int? weddingDate;
  final int? partnerDob;
  final int? isSelected;

  Profile({
    this.profileId,
    this.profileName = '',
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
    this.dob,
    this.weddingDate,
    this.partnerDob,
    this.isSelected = 0,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return new Profile(
      profileId: map['profileId'] as int?,
      profileName: map['profileName'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      middleName: map['middleName'] as String?,
      dob: map['dob'] as int?,
      weddingDate: map['weddingDate'] as int?,
      partnerDob: map['partnerDob'] as int?,
      isSelected: map['isSelected'] as int?,
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
      'weddingDate': this.weddingDate,
      'partnerDob': this.partnerDob,
      'isSelected': this.isSelected,
    } as Map<String, dynamic>;
  }

  Profile copyWith({
    int? profileId,
    String? profileName,
    String? firstName,
    String? lastName,
    String? middleName,
    int? dob,
    int? weddingDate,
    int? partnerDob,
    int? isSelected,
  }) {
    if ((profileId == null || identical(profileId, this.profileId)) &&
        (profileName == null || identical(profileName, this.profileName)) &&
        (firstName == null || identical(firstName, this.firstName)) &&
        (lastName == null || identical(lastName, this.lastName)) &&
        (middleName == null || identical(middleName, this.middleName)) &&
        (dob == null || identical(dob, this.dob)) &&
        (weddingDate == null || identical(weddingDate, this.weddingDate)) &&
        (partnerDob == null || identical(partnerDob, this.partnerDob)) &&
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
      weddingDate: weddingDate ?? this.weddingDate,
      partnerDob: partnerDob ?? this.partnerDob,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
