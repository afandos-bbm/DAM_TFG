class Category {
  String name;
  String image;
  List<dynamic> modelos;

  Category(this.name, this.image, this.modelos);

  Category.fromJson(Map<String, dynamic> json)
      : name = json['nombre'],
        image = json['logo'],
        modelos = json['modelos'];

  Map<String, dynamic> toJson() => {
        'nombre': name,
        'logo': image,
        'modelos': modelos,
      };
}
