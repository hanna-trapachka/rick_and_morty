enum BlocStatus { loading, idle, error }

class BlocStatusRecord {
  const BlocStatusRecord(this.status);

  final (BlocStatus, String?) status;

  factory BlocStatusRecord.loading() =>
      const BlocStatusRecord((BlocStatus.loading, null));

  factory BlocStatusRecord.idle() =>
      const BlocStatusRecord((BlocStatus.idle, null));

  factory BlocStatusRecord.error(String message) =>
      BlocStatusRecord((BlocStatus.error, message));

  bool get isLoading => status.$1 == BlocStatus.loading;
  bool get isIdle => status.$1 == BlocStatus.idle;
  bool get isError => status.$1 == BlocStatus.error;

  String? get error => isError && status.$2 != null ? status.$2 : null;
}
