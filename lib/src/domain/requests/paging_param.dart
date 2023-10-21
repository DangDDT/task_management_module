class PagingQueryParam {
  final int pageSize;
  final int pageIndex;
  final String? searchKey;

  PagingQueryParam({
    required this.pageSize,
    required this.pageIndex,
    this.searchKey,
  });
}
