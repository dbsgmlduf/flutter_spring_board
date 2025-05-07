import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/board.dart';

class BoardController {
  static const String baseUrl = 'http://10.0.2.2:8081/FlutterSpringPractice/api/board';

  Future<List<Board>> getBoardList() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> boardData = jsonData['data'];
      return boardData.map((json) => Board.fromJson(json)).toList();
    }
    throw Exception('Failed to load board list');
  }

  Future<void> createBoard(Board board) async {
    final response = await http.post(
      Uri.parse('$baseUrl/enroll'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(board.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create board');
    }
  }

  Future<void> updateBoard(Board board) async {
    final response = await http.post(
      Uri.parse('$baseUrl/modify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(board.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to update board');
    }
  }

  Future<void> deleteBoard(int bno) async {
    final response = await http.get(Uri.parse('$baseUrl/delete/$bno'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete board');
    }
  }
} 