import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem, int) onUpdate;
  final GroceryItem? originalItem;
  final int index;
  final bool isUpdating;

  static MaterialPage page({
    GroceryItem? item,
    int index = -1,
    required Function(GroceryItem) onCreate,
    required Function(GroceryItem, int) onUpdate,
  }) {
    return MaterialPage(
        name: FooderlichPages.groceryItemDetails,
        key: ValueKey(FooderlichPages.groceryItemDetails),
        child: GroceryItemScreen(
          index: index,
          onCreate: onCreate,
          onUpdate: onUpdate,
          originalItem: item,
        ));
  }

  const GroceryItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem,
      this.index = -1})
      : isUpdating = (originalItem != null),
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
  Color currentColor = Colors.pink;
  int currentSliderValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      nameController.text = originalItem.name;
      name = originalItem.name;
      currentSliderValue = originalItem.quantity;
      importance = originalItem.importance;
      currentColor = originalItem.color;
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
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: nameController.text,
                importance: importance,
                color: currentColor,
                quantity: currentSliderValue,
                date: DateTime(
                  dueDate.year,
                  dueDate.month,
                  dueDate.day,
                  timeOfDay.hour,
                  timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(groceryItem, widget.index);
              } else {
                widget.onCreate(groceryItem);
              }
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
            const SizedBox(height: 10.0),
            buildColorPicker(context),
            const SizedBox(height: 10.0),
            buildQuantityField(),
            GroceryTile(
                item: GroceryItem(
                    id: 'previewMode',
                    name: name,
                    importance: importance,
                    color: currentColor,
                    quantity: currentSliderValue,
                    date: DateTime(dueDate.year, dueDate.month, dueDate.day,
                        dueDate.hour, dueDate.minute)))
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
            cursorColor: currentColor,
            decoration: InputDecoration(
              hintText: 'E.g. Apples, Banana, 1 Bag of salt',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: currentColor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: currentColor),
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

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
            child: const Text('Select'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        // 6
                        onColorChanged: (color) {
                          setState(() => currentColor = color);
                        },
                      ),
                      actions: [
                        TextButton(
                            child: const Text('Save'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            }),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(width: 16.0),
            Text(
              currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
            inactiveColor: currentColor.withOpacity(0.5),
            activeColor: currentColor,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: currentSliderValue.toInt().toString(),
            value: currentSliderValue.toDouble(),
            onChanged: (double newValue) {
              setState(() {
                currentSliderValue = newValue.toInt();
              });
            })
      ],
    );
  }
}
