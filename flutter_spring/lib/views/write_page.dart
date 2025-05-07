import 'package:flutter/material.dart';
import '../controllers/board_controller.dart';
import '../models/board.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final BoardController _boardController = BoardController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController writerController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_checkFormFilled);
    writerController.addListener(_checkFormFilled);
    contentController.addListener(_checkFormFilled);
  }

  void _checkFormFilled() {
    final isFilled = titleController.text.trim().isNotEmpty &&
        writerController.text.trim().isNotEmpty &&
        contentController.text.trim().isNotEmpty;

    if (_isButtonEnabled != isFilled) {
      setState(() {
        _isButtonEnabled = isFilled;
      });
    }
  }

  Future<void> _submitBoard() async {
    try {
      final newBoard = Board(
        title: titleController.text,
        writer: writerController.text,
        content: contentController.text,
      );

      await _boardController.createBoard(newBoard);

      titleController.clear();
      writerController.clear();
      contentController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("등록되었습니다.")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("등록 실패")),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    writerController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("글작성"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: writerController,
              decoration: const InputDecoration(
                labelText: '작성자',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isButtonEnabled ? _submitBoard : null,
                  child: const Text("등록"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("취소"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
} 