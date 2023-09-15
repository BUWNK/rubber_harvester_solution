// String title, String description, String author, String date, String image

class NewsModel {
  final String title;
  final String description;
  final String author;
  final String date;
  final String image;

  NewsModel({
    required this.title,
    required this.description,
    required this.author,
    required this.date,
    required this.image,
  });

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
        title: map['title'],
        description: map['description'],
        author: map['author'],
        date: map['date'],
        image: map['image']);
  }
}
