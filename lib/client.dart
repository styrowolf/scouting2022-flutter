import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:rapid_react_scouting/models/teamdata.dart';
import 'package:rapid_react_scouting/models/teammatchstats.dart';
import 'package:rapid_react_scouting/models/teamnumber.dart';
import 'package:rapid_react_scouting/models/user.dart';

class RRSClient {
  static const endpoint = "http://127.0.0.1:8000";
  late oauth2.Client client;
  final String email;
  final String password;
  late final User user;
  int _selectedTeamIndex = -1;

  RRSClient._construct(this.email, this.password);

  static Future<RRSClient> init(String email, String password) async {
    RRSClient rrsc = RRSClient._construct(email, password);
    rrsc.client = await oauth2.resourceOwnerPasswordGrant(authEndpoint, email, password);
    Map<String, dynamic> json = Jwt.parseJwt(rrsc.jwt);
    rrsc.user = User.fromJson(json);
    rrsc.selectedTeamIndex = 0;
    return rrsc;
  }

  void refreshToken() async {
    client = await oauth2.resourceOwnerPasswordGrant(authEndpoint, email, password);
  }

  void checkAndRefreshToken() async {
    if (Jwt.isExpired(jwt)) {
      refreshToken();
    }
  }

  String get jwt {
    return client.credentials.accessToken;
  }

  TeamNumber get selectedTeam {
    return user.teams[_selectedTeamIndex];
  }

  int get selectedTeamIndex {
    return _selectedTeamIndex;
  }

  set selectedTeamIndex(int i) {
    user.teams.elementAt(i);
    _selectedTeamIndex = i;
  }

  // Endpoints
  static Uri get authEndpoint {
    return Uri.parse(endpoint + '/token');
  }

  static Uri get tryAuthEndpoint {
    return Uri.parse(endpoint + '/tryauth');
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
    checkAndRefreshToken();
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
    checkAndRefreshToken();
    var response = await client.get(dataEndpoint(selectedTeam));
    if (response.statusCode == 200) {
      var jsonString = String.fromCharCodes(response.bodyBytes);
      var json = jsonDecode(jsonString);
      return TeamData.fromJson(json);  
    } else {
      return null;
    }
  }

  void createTournament(String name) async {
    checkAndRefreshToken();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
    };
    
    await client.post(
      tournamentCreationEndpoint(selectedTeam),
      headers: headers,
      body: jsonEncode({'name': name}),
    );
  }

  void createMatch(String name, String tournamentId) async {
    checkAndRefreshToken();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
    };
    
    await client.post(
      matchCreationEndpoint(selectedTeam, tournamentId),
      headers: headers,
      body: jsonEncode({'name': name}),
    );
  }

  void addTeamMatchStats(String tournamentId, String matchId, TeamMatchStats tms) async {
    checkAndRefreshToken();
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

