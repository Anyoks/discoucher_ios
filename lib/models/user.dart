class User {
    String id;
    String email;
    int roleId;
    String provider;
    String uid;
    String firstName;
    String lastName;
    String phoneNumber;
    bool allowPasswordChange;

    DateTime dob;
    String password;
    String passwordConfirmation;

    User({
        this.id,
        this.email,
        this.roleId,
        this.provider,
        this.uid,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.allowPasswordChange,
    });

    factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        email: json["email"],
        roleId: json["role_id"],
        provider: json["provider"],
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        allowPasswordChange: json["allow_password_change"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role_id": roleId,
        "provider": provider,
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "allow_password_change": allowPasswordChange,
    };
}