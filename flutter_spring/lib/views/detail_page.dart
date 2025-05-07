import 'package:flutter/material.dart';
import '../controllers/board_controller.dart';
import '../models/board.dart';
import 'modify_page.dart';

class DetailPage extends StatefulWidget {
  final Board board;

  const DetailPage({Key? key, required this.board}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final BoardController _boardController = BoardController();
  late Board _currentBoard;

  @override
  void initState() {
    super.initState();
    _currentBoard = widget.board;
  }

  Future<void> _deleteBoard() async {
    try {
      await _boardController.deleteBoard(_currentBoard.bno!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("삭제되었습니다.")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("삭제 실패")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세보기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentBoard.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("작성자: ${_currentBoard.writer}", style: const TextStyle(fontSize: 16)),
            const Divider(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _currentBoard.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModifyPage(board: _currentBoard),
                      ),
                    );

                    if (result != null && result is Board) {
                      setState(() {
                        _currentBoard = result;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("수정"),
                ),
                ElevatedButton(
                  onPressed: _deleteBoard,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("삭제"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 