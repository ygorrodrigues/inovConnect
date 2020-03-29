class PostProjeto {
  final String title;
  final String subtitle;
  final String description;

  PostProjeto(
    this.title,
    this.subtitle,
    this.description
  );

  PostProjeto.fromJson(Map<String,dynamic> json) 
    : title = json['title'],
      subtitle = json['subtitle'],
      description = json['description'];

  Map<String,dynamic> toJson() => 
    {
      'title' : title,
      'subtitle': subtitle,
      'description': description
    };

  @override
  String toString() {
    return 'Post{Titulo: $title, subtitle: $subtitle, '
      'descrição: $description}';
  }
}