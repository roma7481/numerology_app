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
