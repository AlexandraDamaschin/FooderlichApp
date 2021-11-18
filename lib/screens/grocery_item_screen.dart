import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final nameController = TextEditingController();
  String name = '';
  Importance importance = Importance.low;
  DateTime dueDate = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  Color color = Colors.pink;
  int currentSliderValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      nameController.text = originalItem.name;
      name = originalItem.name;
      currentSliderValue = originalItem.quantity;
      importance = originalItem.importance;
      color = originalItem.color;
      final date = originalItem.date;
      timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      dueDate = date;
    }

    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO 24: Add callback handler
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(),
            buildTimeField(context),
            // TODO 17: Add color picker
            // TODO 18: Add slider
            // TODO: 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
            controller: nameController,
            cursorColor: color,
            decoration: InputDecoration(
              hintText: 'E.g. Apples, Banana, 1 Bag of salt',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: color),
              ),
            ))
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selected: importance == Importance.low,
              onSelected: (selected) {
                setState(() {
                  importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: importance == Importance.medium,
              onSelected: (selected) {
                setState(() {
                  importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: importance == Importance.high,
              onSelected: (selected) {
                setState(() {
                  importance = Importance.high;
                });
              },
            )
          ],
        )
      ],
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5));
                setState(() {
                  if (selectedDate != null) {
                    dueDate = selectedDate;
                  }
                });
              },
            )
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(dueDate)),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
                child: const Text('Select'),
                onPressed: () async {
                  final time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  setState(() {
                    if (time != null) {
                      timeOfDay = time;
                    }
                  });
                })
          ],
        ),
        Text(timeOfDay.format(context)),
      ],
    );
  }

  // TODO: Add buildColorPicker()

  // TODO: Add buildQuantityField()

}
