import 'package:numerology/app/data/data_provider/numerology_helper.dart';

dynamic getEntity({
  String table,
  String queryColumn,
  String resColumn,
  String value,
}) async {
  var query = 'select $resColumn from $table where $queryColumn = $value';
  var fromMap = (map) => map[resColumn] as String;

  return await NumerologyDBProvider.instance.getEntity(
    query,
    fromMap,
  );
}

dynamic getEntityAdvanced({
  String table,
  String queryColumn,
  String resColumn,
  String value,
  Function fromMap,
}) async {
  var query = 'select * from $table where $queryColumn = $value';

  return await NumerologyDBProvider.instance.getEntity(
    query,
    fromMap,
  );
}
