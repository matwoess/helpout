enum SearchType { REQUEST, ASSIST }

class AppState {
  bool loggedIn;
  SearchType searchType;
  String region;
  bool darkTheme;

  AppState({
    this.loggedIn,
    this.searchType,
    this.region,
    this.darkTheme,
  });
}
