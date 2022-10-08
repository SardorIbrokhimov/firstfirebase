class Post {
  late String userId;
  late String name;
  late String surname;
  late String date;
  late String content;


  Post({required this.userId, required this.name, required this.surname,required this.content,required this.date});

  Post.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        surname = map['surname'],
        date = map['date'],
        content = map['content'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'surname': surname,
    'date': date,
    'content': content,
  };
}