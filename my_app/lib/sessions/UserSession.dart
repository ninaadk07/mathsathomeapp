class UserSession {
  // This class holds the logged-in user information, including the FamilyID.
  static int? familyID;

  static void logIn(int familyID) {
    UserSession.familyID = familyID;
  }
  static void logOut() {
    UserSession.familyID = null;
  }
}