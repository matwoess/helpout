enum SearchType { REQUEST, ASSIST }

class AppState {
  bool loggedIn;
  SearchType searchType;
  String region;
  bool darkTheme;
  bool ads;

  AppState({
    this.loggedIn,
    this.searchType,
    this.region,
    this.darkTheme,
  });
}
