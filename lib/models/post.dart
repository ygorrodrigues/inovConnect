class Post {
  final int id;
  final String username;
  final String title;
  final String description;
  final List<dynamic> categories;
  final String postStatus;
  final int postStatusId;
  final String type;
  final String creationDate;
  final int ownerId;

  Post(
    this.id,
    this.username,
    this.title,
    this.description,
    this.categories,
    this.postStatus,
    this.postStatusId,
    this.type,
    this.creationDate,
    this.ownerId
  );

  Post.fromJson(Map<String,dynamic> json) 
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      categories = json['categories'],
      postStatus = json['post_status']['name'],
      postStatusId = json['post_status']['id'],
      type = json['type']['name'],
      username = json['user']['name'],
      creationDate = json['created_at'],
      ownerId = json['user']['id'];

  Map<String,dynamic> toJson() => 
    {
      'title' : title,
      'description': description
    };

  @override
  String toString() {
    return 
      'Post{id: $id, '
      'titulo: $title, '
      'descrição: $description, '
      'usuário: $username, '
      'categorias: $categories, '
      'post_status: $postStatus, '
      'type: $type}';
  }
}