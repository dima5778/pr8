class LibraryItem {
  final int? id;
  final String name;
  final String description;
  final String details;
  final String image;

  const LibraryItem({
    this.id,
    required this.name,
    required this.description,
    required this.details,
    required this.image,
  });
}