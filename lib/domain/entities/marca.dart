class Marca {
  String name;
  String image;
  List<dynamic> modelos;

  Marca(this.name, this.image, this.modelos);

  Marca.fromJson(Map<String, dynamic> json)
      : name = json['nombre'],
        image = json['logo'],
        modelos = json['modelos'];

  Map<String, dynamic> toJson() => {
        'nombre': name,
        'logo': image,
        'modelos': modelos,
      };
}
