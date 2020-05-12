class PostProjeto {
  final String title;
  final String description;
  final List<dynamic> categories;
  final String status;
  final String type;

  PostProjeto(
    this.title,
    this.description,
    this.categories,
    this.status,
    this.type
  );

  PostProjeto.fromJson(Map<String,dynamic> json) 
    : title = json['title'],
      description = json['description'],
      categories = json['categories'],
      status = json['status']['name'],
      type = json['type']['name'];

  Map<String,dynamic> toJson() => 
    {
      'title' : title,
      'description': description
    };

  @override
  String toString() {
    return 
      'Post{Titulo: $title, '
      'descrição: $description}, '
      'categorias: $categories, '
      'status: $status, '
      'type: $type}';
  }
}