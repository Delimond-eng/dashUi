class Personals {
  int id;
  String name;
  String age;

  Personals({int id, String name, int age});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (id != null) {
      data["id"] = id;
    }

    data["nom"] = name;
    data["age"] = int.parse(age);
    return data;
  }

  Personals.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["nom"];
    age = data["age"];
  }
}
