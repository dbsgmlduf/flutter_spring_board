import 'package:flutter/material.dart';
import '../controllers/board_controller.dart';
import '../models/board.dart';

class ModifyPage extends StatefulWidget {
  final Board board;
  const ModifyPage({Key? key, required this.board}) : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  final BoardController _boardController = BoardController();
  late TextEditingController titleController;
  late TextEditingController writerController;
  late TextEditingController contentController;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.board.title);
    writerController = TextEditingController(text: widget.board.writer);
    contentController = TextEditingController(text: widget.board.content);

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

  Future<void> _submitModifiedBoard() async {
    try {
      final updatedBoard = Board(
        bno: widget.board.bno,
        title: titleController.text,
        writer: writerController.text,
        content: contentController.text,
      );

      await _boardController.updateBoard(updatedBoard);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("수정되었습니다.")),
        );
        Navigator.pop(context, updatedBoard);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("수정 실패")),
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
      appBar: AppBar(title: const Text("글 수정")),
      body: Padding(
        padding: const EdgeInsets.all(24),
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
              readOnly: true,
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
                  onPressed: _isButtonEnabled ? _submitModifiedBoard : null,
                  child: const Text("수정"),
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