class TopicItem {
  final String itemId;
  final String id;
  final String image;
  final String title;
  final String description;
  final bool isFavorite;
  final List<Item> items;

  TopicItem({
    required this.itemId,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    this.isFavorite = false,
    required this.items,
  });
}

class Item {
  final String id;
  final String title;
  final String description;

  Item({
    required this.id,
    required this.title,
    required this.description,
  });
}
