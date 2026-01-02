class ApiConstants {
  // static const String baseUrl = "http://192.168.1.8:8000/api/v1/user";
  //  static const String baseUrl = "http://192.168.1.5:8000/";
  //  static const String imagePath="http://192.168.1.5:8000";
  // static const String baseUrl = "http://10.0.2.2:8000/";
  // static const String imagePath = "http://10.0.2.2:8000";
  static const String baseUrl = "https://lavender26.pythonanywhere.com/";
  static const String imagePath = "https://lavender26.pythonanywhere.com";
  static const String signUp = "api/v1/user/register";
  static const String signIn = "api/v1/user/login";

  static const String getSpecialists = "api/v1/specialists/";
  static const String getUsers = "api/v1/users/";
  static const String getCurrentUser = "api/v1/user/userinfo";

  static const String getQuotes = "api/v1/quote/daily/";
  static const String getMeasurementQuizzes = "api/v1/quizzes/";
  static const String submitMeasurementQuizzesAnswer = "api/v1/answers/submit/";
  static const String getMusicCards = "api/v1/music/";
  static const String getMeasurementQuizResults = "api/v1/quizzes/";

  static const String getPosts = "api/v1/posts/";
  static const String addPost = "api/v1/posts/create/";
  static const String likePost = "api/v1/posts";
  static const String getPostComments = "api/v1/posts";
  static const String addPostComments = "api/v1/posts";
  static const String likeComment = "api/v1/comments";
  static const String getStatus = "api/v1/status/feed/";

  static const String searchSpecialists = "api/v1/specialists/";

  static const String getFavorites = "api/v1/specialist/favorites/";
  static const String addToFavorites = "api/v1/specialist/favorites/add/";
  static const String removeFromFavorites = "api/v1/specialist/favorites/remove";

  static const String getCourses = "api/v1/courses/";
  static const String getFreePrograms = "api/v1/free-programs/";

  static const String bookAppointment = "api/v1/appointments/checkout";

}