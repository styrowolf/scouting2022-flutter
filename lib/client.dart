import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:rapid_react_scouting/credentials.dart';
import 'package:rapid_react_scouting/models/teamdata.dart';
import 'package:rapid_react_scouting/models/teammatchstats.dart';
import 'package:rapid_react_scouting/models/teamnumber.dart';
import 'package:rapid_react_scouting/models/user.dart';

class RRSClient {
  static const endpoint = "http://127.0.0.1:8000";
  late oauth2.Client client;
  final Credentials credentials;
  late final User user;
  int selectedTeamIndex = 0;

  RRSClient._construct(this.credentials);

  static RRSClient init(Credentials credentials) {
    RRSClient rrsc = RRSClient._construct(credentials);
    rrsc.refreshToken();
    return rrsc;
  }

  Future<void> refreshToken() async {
    client = await oauth2.resourceOwnerPasswordGrant(authEndpoint, email, password);
    refreshUser();
  }

  Future<void> checkAndRefreshToken() async {
    if (Jwt.isExpired(jwt)) {
      await refreshToken();
    }
  }

  void refreshUser() {
    Map<String, dynamic> json = Jwt.parseJwt(jwt);
    user = User.fromJson(json);
  }

  String get jwt {
    return client.credentials.accessToken;
  }

  String get email {
    return credentials.email;
  }

  String get password {
    return credentials.password;
  }

  TeamNumber get selectedTeam {
    return user.teams[selectedTeamIndex];
  }

  bool get hasTeams {
    return user.teams.isNotEmpty;
  }

  // Endpoints
  static Uri get authEndpoint {
    return Uri.parse(endpoint + '/token');
  }

  static Uri metadataEndpoint(TeamNumber team) {
    return Uri.parse(endpoint + '/metadata/$team');
  }

  static Uri dataEndpoint(TeamNumber team) {
    return Uri.parse(endpoint + '/data/$team');
  }

  static Uri tournamentCreationEndpoint(TeamNumber team) {
    return Uri.parse(endpoint + '/create/$team/tournament');
  }

  static Uri matchCreationEndpoint(TeamNumber team, String tournamentId) {
    return Uri.parse(endpoint + '/create/$team/$tournamentId/match');
  }

  static Uri teamMatchStatsAdditionEndpoint(TeamNumber team, String tournamentId, String matchId) {
    return Uri.parse(endpoint + '/add/$team/$tournamentId/$matchId');
  }

  // Request methods
  Future<TeamDataMetadata?> getMetadata() async {
    await checkAndRefreshToken();
    var response = await client.get(metadataEndpoint(selectedTeam));
    if (response.statusCode == 200) {
      var jsonString = String.fromCharCodes(response.bodyBytes);
      var json = jsonDecode(jsonString);
      return TeamDataMetadata.fromJson(json);  
    } else {
      return null;
    }
  }

  Future<TeamData?> getData() async {
    await checkAndRefreshToken();
    var response = await client.get(dataEndpoint(selectedTeam));
    if (response.statusCode == 200) {
      var jsonString = String.fromCharCodes(response.bodyBytes);
      var json = jsonDecode(jsonString);
      return TeamData.fromJson(json);  
    } else {
      return null;
    }
  }

  Future<void> createTournament(String name) async {
    await checkAndRefreshToken();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
    };
    
    await client.post(
      tournamentCreationEndpoint(selectedTeam),
      headers: headers,
      body: jsonEncode({'name': name}),
    );
  }

  Future<void> createMatch(String name, String tournamentId) async {
    await checkAndRefreshToken();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
    };
    
    await client.post(
      matchCreationEndpoint(selectedTeam, tournamentId),
      headers: headers,
      body: jsonEncode({'name': name}),
    );
  }

  Future<void> addTeamMatchStats(String tournamentId, String matchId, TeamMatchStats tms) async {
    await checkAndRefreshToken();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
    };
    
    await client.post(
      teamMatchStatsAdditionEndpoint(selectedTeam, tournamentId, matchId),
      headers: headers,
      body: jsonEncode(tms.toJson()),
    );
  }
}

