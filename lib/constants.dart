
class Constants {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `LocalStorageKey()` accidentally
  Constants._();
  
  // the properties are static so that we can use them without a class instance
  // e.g. can be retrieved by `LocalStorageKey.saveUserId`.
  static const String apiKey = '52dfce66a64eea1b695a1bc919b2de8e';
  static const String iconsApi = 'http://openweathermap.org/img/wn/';
  static const String imageEnd = '@2x.png';

  static const List<String> cities =["Viana do Castelo","Braga","Vila Real",
  "Bragança", "Porto", "Aveiro","Viseu","Guarda", "Coimbra", "Castelo Branco", "Leiria", "Santarém", "Portalegre","Lisboa","Évora", "Setúbal","Beja","Faro"];
  }