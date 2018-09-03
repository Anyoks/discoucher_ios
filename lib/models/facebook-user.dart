class FacebookProfile {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final Picture picture;

  FacebookProfile.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        firstName = map['first_name'],
        lastName = map['last_name'],
        email = map['email'],
        picture = map['picture'] == null
            ? null
            : new Picture.fromJson(map['picture'] as Map<String, dynamic>);
}

class Picture {
  final PictureData data;

  Picture.fromJson(Map<String, dynamic> map)
      : data = map['data'] == null
            ? null
            : new PictureData.fromJson(map['data'] as Map<String, dynamic>);
}

class PictureData {
  final bool isSilhouette;
  final String url;
  final int height;
  final int width;

  PictureData.fromJson(Map<String, dynamic> map)
      : isSilhouette = map['is_silhouette'],
        url = map['url'],
        height = map['height'],
        width = map['width'];
}
