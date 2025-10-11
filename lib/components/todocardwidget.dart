import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

final Map<String, IconData> categoryIcons = {
  "Work": Icons.work,
  "Study": Icons.school,
  "Personal": Icons.person,
  "Food": Icons.fastfood,
  "Sport": Icons.fitness_center,
  "Music": Icons.headphones,
};

class TodoCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String? date;
  final String? time;
  final String? project;

  final bool isDone;
  final bool isHistory;
  final bool showDelete;

  final VoidCallback? onToggleDone;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TodoCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.date,
    this.time,
    this.project,
    this.isDone = false,
    this.isHistory = false,
    this.showDelete = true,
    this.onToggleDone,
    this.onDelete,
    this.onEdit,
  });

  @override
  State<TodoCardWidget> createState() => _TodoCardWidgetState();
}

class _TodoCardWidgetState extends State<TodoCardWidget> {
  bool _expanded = false;

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Customcolors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: _toggleExpand,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  if (widget.project != null)
                    Container(
                      width: 28,
                      height: 28,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Customcolors.bluewidget.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        categoryIcons[widget.project] ?? Icons.category,
                        size: 16,
                        color: Customcolors.bluewidget,
                      ),
                    ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: widget.isDone
                                ? Customcolors.grey600
                                : Customcolors.textPrimary,
                            decoration: widget.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.description.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            child: Text(
                              "Desc: ${widget.description}",
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.isDone
                                    ? Customcolors.grey600
                                    : Customcolors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),

                  if (!widget.isHistory && widget.onToggleDone != null)
                    GestureDetector(
                      onTap: widget.onToggleDone,
                      child: Container(
                        width: 18,
                        height: 18,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.isDone
                                ? Customcolors.bluewidget
                                : Customcolors.grey600,
                            width: 2,
                          ),
                          color: widget.isDone
                              ? Customcolors.bluewidget
                              : Customcolors.transparent,
                        ),
                        child: widget.isDone
                            ? const Icon(Icons.check,
                                size: 14, color: Customcolors.white)
                            : null,
                      ),
                    ),

                  if (widget.showDelete && widget.onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Customcolors.textPrimary, size: 20),
                      onPressed: widget.onDelete,
                    ),

                  if (widget.isHistory && widget.onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Customcolors.textPrimary, size: 20),
                      onPressed: widget.onEdit,
                    ),
                ],
              ),
            ),

            if (_expanded)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Customcolors.background,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (widget.date != null)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: const Icon(Icons.calendar_today,
                            size: 14, color: Customcolors.green),
                        label: Text(widget.date!,
                            style: const TextStyle(
                                fontSize: 11, color: Customcolors.green)),
                        backgroundColor: Customcolors.green.withOpacity(0.15),
                      ),
                    if (widget.time != null)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: const Icon(Icons.access_time,
                            size: 14, color: Customcolors.redAccent),
                        label: Text(widget.time!,
                            style: const TextStyle(
                                fontSize: 11, color: Customcolors.redAccent)),
                        backgroundColor:
                            Customcolors.redAccent.withOpacity(0.15),
                      ),
                    if (widget.project != null)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: Icon(
                            categoryIcons[widget.project] ?? Icons.category,
                            size: 14,
                            color: Customcolors.bluewidget),
                        label: Text(widget.project!,
                            style: const TextStyle(
                                fontSize: 11, color: Customcolors.bluewidget)),
                        backgroundColor:
                            Customcolors.bluewidget.withOpacity(0.15),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
