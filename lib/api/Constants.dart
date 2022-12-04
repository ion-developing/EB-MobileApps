class Paths {
  static const String BASE_URL =
      "https://probable-knowledgeable-zoo.glitch.me/";
  register() {
    return "${BASE_URL}users";
  }

  login(String username, String password) {
    return "${BASE_URL}users?username=$username&password=$password";
  }

  restaurants() {
    return "${BASE_URL}restaurants";
  }

  restaurantsById(String id) {
    return "${BASE_URL}restaurants/$id";
  }
}
