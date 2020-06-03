class Post {
  final int id;
  final String username;
  final String title;
  final String description;
  final List<dynamic> categories;
  final String status;
  final String type;
  final String creationDate;

  Post(
    this.id,
    this.username,
    this.title,
    this.description,
    this.categories,
    this.status,
    this.type,
    this.creationDate
  );

  Post.fromJson(Map<String,dynamic> json) 
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      categories = json['categories'],
      status = json['status']['name'],
      type = json['type']['name'],
      username = json['user']['name'],
      creationDate = json['created_at'];

  Map<String,dynamic> toJson() => 
    {
      'title' : title,
      'description': description
    };

  @override
  String toString() {
    return 
      'Post{usuário: $username, '
      'titulo: $title, '
      'descrição: $description, '
      'categorias: $categories, '
      'status: $status, '
      'type: $type}';
  }
}