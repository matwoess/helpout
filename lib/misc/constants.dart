class Constants {
  static double detailDialogPadding = 16.0;
  static double detailDialogAvatarRadius = 42.0;
  static final String userTableData = 'username, firstname, lastname, gender:gid(name), zipcode, region:zipcode(name),price, description, asset, password';

  // Use @<variable> to address parameters to substitute => prepared statement (see: https://pub.dev/packages/postgres, improves resiliance against SQL injection)
  // Select Queries
  //// General
  static final String getAllUsers = "SELECT * FROM public.user, public.city, public.gender WHERE public.user.zipcode = public.city.zipcode AND public.user.gid = public.gender.gid;";
  static final String getUserByName = "SELECT * FROM public.user, public.city, public.gender WHERE public.user.zipcode = public.city.zipcode AND public.user.gid = public.gender.gid AND username = @name";
  static final String getUsersByRegion = "SELECT * FROM public.user, public.city, public.gender WHERE public.user.zipcode = public.city.zipcode AND public.user.gid = public.gender.gid AND public.user.zipcode = @zip;";
  static final String getRegions = "SELECT * FROM public.city";
  static final String getUserChats = "SELECT * FROM public.chat WHERE username1 = @username OR username2 = @username;";
  static final String getChat = "SELECT * FROM public.chat WHERE (username1 = @username1 AND username2 = @username2) OR (username1 = @username2 AND username2 = @username1);";
  static final String getChatHistory = "SELECT * FROM public.message WHERE chatid = @cid;";
  static final String getChatHistoryViaUsers = "SELECT * FROM public.chat, public.message WHERE public.chat.chatid = public.message.chatid AND username1 = @username1 AND username2 = @username2;";
  //// IDs
  static final String getGenderID = "SELECT gid FROM public.gender WHERE name = @gender;";
  static final String getChatID = "SELECT chatid FROM public.chat WHERE (username1 = @username1 AND username2 = @username2) OR (username1 = @username2 AND username2 = @username1);";
  // static final String getCurrentMessageID = "SELECT COUNT(*) FROM public.message WHERE chatid = @cid;";
  //// Content
  static final String getLastMessage = "SELECT * FROM public.message WHERE chatid = @chatid AND msgid = (SELECT MAX(msgid) FROM public.message WHERE chatid = @chatid);";

  // Insert Queries
  static final String insertUser = "INSERT INTO public.user(username, firstname, lastname, price, asset, description, gid, zipcode, level, score) VALUES (@username, @first, @last, @price, @asset, @description, @gid, @zipcode, 1, 0);";
  static final String insertCity = "INSERT INTO public.city(zipcode, name) VALUES (@zip, @name);";
  static final String insertMessage = "INSERT INTO public.message(chatid, username, timestamp, content) VALUES (@chatid, @user, @ts, @cont);";
  static final String insertChat = "INSERT INTO public.chat(isread, username1, username2) VALUES (false, @user1, @user2)";

  // Update Queries
  static final String updateUserCredentials = "UPDATE public.user SET firstname = @first, lastname = @last, price = @price, asset = @asset, description = @desc, gid = @gid, zipcode = @zip WHERE username = @user;";
  static final String updateUserScore = "UPDATE public.user SET level = @level, score = @score WHERE username = @user;";
  static final String updateChatState = "UPDATE public.chat SET isread = @state WHERE chatid = @chatid;";

}