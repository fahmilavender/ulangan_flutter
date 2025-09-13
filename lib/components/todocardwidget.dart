import 'package:flutter/material.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class TodoCardWidget extends StatefulWidget {
  final String title;
  final String? time;
  final String? project;
  final String? date;
  final bool isDone;
  final bool isActive;
  final VoidCallback? onToggleDone; 
  final VoidCallback? onDelete;
  final bool showDelete;
  final String? statusLabel;

  const TodoCardWidget({
    super.key,
    required this.title,
    this.time,
    this.project,
    this.date,
    this.isDone = false,
    this.isActive = false,
    this.onToggleDone,
    this.onDelete,
    this.showDelete = true,
    this.statusLabel,
  });

  @override
  State<TodoCardWidget> createState() => _TodoCardWidgetState();
}

class _TodoCardWidgetState extends State<TodoCardWidget> {
  late bool _isDoneLocal;

  @override
  void initState() {
    super.initState();
    _isDoneLocal = widget.isDone;
  }

  void _handleToggle() {
    setState(() => _isDoneLocal = !_isDoneLocal);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (widget.onToggleDone != null) widget.onToggleDone!();
    });
  }

  @override
  void didUpdateWidget(covariant TodoCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDone != widget.isDone) {
      _isDoneLocal = widget.isDone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> projectIcons = {
      "Work": Icons.work,
      "Study": Icons.school,
      "Personal": Icons.person,
      "Food": Icons.fastfood,
      "Sport": Icons.sports,
      "Music": Icons.headphones,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.statusLabel != null)
          RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 20),
              child: Text(
                widget.statusLabel!,
                style: const TextStyle(
                  color: Customcolors.bluegrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.3,
                ),
              ),
            ),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: widget.isActive ? Customcolors.bluewidget : Customcolors.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _handleToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _isDoneLocal ? Customcolors.bluewidget : Customcolors.textSecondary,
                        width: 2,
                      ),
                      color: _isDoneLocal ? Customcolors.bluewidget : Customcolors.transparant,
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isDoneLocal ? 1.0 : 0.0,
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Customcolors.background,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.isActive ? Customcolors.background : Customcolors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: _isDoneLocal ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (widget.project != null || widget.date != null)
                        Wrap(
                          spacing: 8,
                          children: [
                            if (widget.project != null)
                              Chip(
                                avatar: Icon(
                                  projectIcons[widget.project] ?? Icons.folder,
                                  size: 16,
                                  color: Customcolors.bluewidget,
                                ),
                                label: Text(
                                  widget.project!,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: Customcolors.grey300,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                            if (widget.date != null)
                              Chip(
                                avatar: const Icon(Icons.calendar_today, size: 16, color: Customcolors.green),
                                label: Text(
                                  widget.date!,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: Customcolors.green50,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                          ],
                        ),
                      if (widget.time != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          widget.time!,
                          style: TextStyle(
                            color: widget.isActive ? Customcolors.grey300 : Customcolors.grey600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.showDelete && widget.onDelete != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.delete, color: widget.isActive ? Customcolors.background : Customcolors.redAccent),
                    onPressed: widget.onDelete,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
