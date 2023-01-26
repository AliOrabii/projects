class NewsObject {
  Source? source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  NewsObject(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );
}

class Source {
  String id;
  String name;

  Source(this.id, this.name);
}

class NewsData {
  List<NewsObject> News;
  NewsData(this.News);
}
