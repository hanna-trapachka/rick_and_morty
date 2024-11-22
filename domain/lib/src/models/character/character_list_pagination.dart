class CharacterListPagination {
  const CharacterListPagination({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;
}
