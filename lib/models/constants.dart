class Constants {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `LocalStorageKey()` accidentally
  Constants._();
  
  // the properties are static so that we can use them without a class instance
  // e.g. can be retrieved by `LocalStorageKey.saveUserId`.
  static const String apiKey = 'c5739e683246ddc5a1beb8348d8f22a6';
  static const String iconsApi = 'http://openweathermap.org/img/wn/';
  static const String imageEnd = '@2x.png';

  static const List<String> cities =["Viana do Castelo","Braga","Vila Real",
  "Bragança", "Porto", "Aveiro","Viseu","Guarda", "Coimbra", "Castelo Branco", "Leiria", "Santarém", "Portalegre","Lisboa","Évora", "Setúbal","Beja","Faro"];

  static const topics = <String>['Temperature', 'Feels Like', 'Pressure', 'Sea Level', 'Ground Level', 'Humidity', 'Temperature KF'];
  static const JSONtopics = <String>['temp', 'feels_like', 'pressure', 'sea_level', 'grnd_level', 'humidity', 'temp_kf'];
}