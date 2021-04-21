import 'package:numerology/app/data/data_provider/numerology_helper.dart';

Future<dynamic> getEntityRawQuery(String query,
    {String resColumn = 'description'}) async {
  return await NumerologyDBProvider.instance.getEntity(
    query,
    (map) => map[resColumn] as String,
  );
}
