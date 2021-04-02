import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/data_provider/numerology_helper.dart';

Future<dynamic> getEntity({
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

Future<dynamic> getEntityRawQuery(String query,
    {String resColumn = 'description'}) async {
  return await NumerologyDBProvider.instance.getEntity(
    query,
    (map) => map[resColumn] as String,
  );
}

Future<dynamic> getEntityAdvanced({
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

Future<Map<String, String>> getDescription(
    String table, int calculation) async {
  var description = await getEntity(
      table: table,
      queryColumn: 'number',
      resColumn: 'description',
      value: calculation.toString());
  var info = await getEntity(
      table: 'TABLE_DESCRIPTION',
      queryColumn: 'table_name',
      resColumn: 'description',
      value: '\"$table\"');

  var language = Globals.instance.language;
  Map<String, String> descriptionContent = {
    language.description: description,
    language.info: info
  };

  return descriptionContent;
}
