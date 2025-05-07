import 'package:flutter/material.dart';
import '../controllers/board_controller.dart';
import '../models/board.dart';
import 'write_page.dart';
import 'detail_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final BoardController _boardController = BoardController();
  List<Board> boardList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBoardList();
  }

  Future<void> _loadBoardList() async {
    try {
      final boards = await _boardController.getBoardList();
      setState(() {
        boardList = boards;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시글 목록을 불러오는데 실패했습니다.')),
      );
    }
  }

  Future<void> _navigateToWritePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WritePage()),
    );

    if (result == true) {
      _loadBoardList();
    }
  }

  Widget _buildBoardItem(Board board) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(board.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("작성자: ${board.writer}"),
          ],
        ),
        isThreeLine: true,
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(board: board),
            ),
          );

          if (result == true) {
            _loadBoardList();
          } else if (result != null && result is Board) {
            setState(() {
              final index = boardList.indexWhere((item) => item.bno == result.bno);
              if (index != -1) {
                boardList[index] = result;
              }
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("게시글 리스트"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '글 작성',
            onPressed: _navigateToWritePage,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadBoardList,
              child: ListView.builder(
                itemCount: boardList.length,
                itemBuilder: (context, index) {
                  return _buildBoardItem(boardList[index]);
                },
              ),
            ),
    );
  }
} 