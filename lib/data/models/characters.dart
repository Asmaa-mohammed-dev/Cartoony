class Character {
  late int id;
  late String name;
  late String status;
  late String image;
  late String locationName;
  late String locationUrl;
  late List<String> episodes;
  late String type;
  late String species;
  late String gender;
  late String originName;
  late String originUrl;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    image = json['image'];
    locationName = json['location']['name'] ?? ''; // الحصول على اسم الموقع
    locationUrl = json['location']['url'] ?? ''; // الحصول على رابط الموقع
    episodes =
        List<String>.from(json['episode']); // تحويل الحلقات إلى قائمة من النصوص
    type = json['type'] ?? ''; // الحقل قد يكون فارغًا
    species = json['species'];
    gender = json['gender'];
    originName = json['origin']['name'] ?? ''; // الحصول على اسم الأصل
    originUrl = json['origin']['url'] ?? ''; // الحصول على رابط الأصل
  }
}
