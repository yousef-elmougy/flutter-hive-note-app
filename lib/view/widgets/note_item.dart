import 'package:flutter/material.dart';
import 'package:hive_note/model/note.dart';
import 'package:hive_note/view/screens/edit_note_screen.dart';

import 'dynamic_text_highlighting_widget.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    this.onDelete,
    this.isSearch = false,
    this.query = '',
  });

  final Note note;
  final VoidCallback? onDelete;
  final bool isSearch;
  final String query;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditNoteScreen(note: note),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(note.color),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(24).copyWith(right: 8),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DynamicTextHighlightingWidget(
                    text: note.title,
                    highlights: [query],
                    caseSensitive: false,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                subtitle: DynamicTextHighlightingWidget(
                  text: note.content,
                  highlights: [query],
                  caseSensitive: false,
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: isSearch
                    ? null
                    : IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 32,
                        ),
                        onPressed: onDelete,
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                note.date,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      );
}
