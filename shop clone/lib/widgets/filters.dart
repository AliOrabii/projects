import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  RangeValues rangevals = const RangeValues(100, 1500);
  String _dropdownvalue = 'Select Category';
  bool? checklist1 = false;
  bool? checklist2 = false;
  bool? checklist3 = false;
  bool? checklist4 = false;

  Widget CheckboxLTile(
    bool? checkList,
    String title,
  ) {
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        child: Card(
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple.shade800,
            value: checkList,
            onChanged: (newval) {
              setState(() {
                checkList = newval;
              });
            },
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  final items = const [
    DropdownMenuItem(
        value: 'Select Category',
        enabled: false,
        child: Text('Select Category')),
    DropdownMenuItem(value: 'Top', child: Text('Top')),
    DropdownMenuItem(value: 'Pants', child: Text('Pants')),
    DropdownMenuItem(value: 'Shoes', child: Text('Shoes')),
    DropdownMenuItem(value: 'jacket', child: Text('jacket')),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 50;
    return TextButton.icon(
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          constraints: BoxConstraints(
            minWidth: width,
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                RangeLabels labels = RangeLabels(
                    rangevals.start.toString(), rangevals.end.toString());
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  height: MediaQuery.of(context).size.height * 0.7,
                  color: const Color.fromARGB(255, 247, 245, 245),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: RangeSlider(
                          values: rangevals,
                          activeColor: Colors.deepPurple.shade800,
                          min: 100,
                          max: 1500,
                          onChanged: (value) {
                            setState(
                              () {
                                rangevals = value;
                              },
                            );
                          },
                        ),
                      ),
                      IntrinsicWidth(
                        stepWidth: 300,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'From :',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(69, 39, 160, 1),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.black),
                              ),
                              child: Text(
                                double.parse(labels.start).toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Text(
                              'To :',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(69, 39, 160, 1),
                                  fontWeight: FontWeight.w800),
                            ),
                            Container(
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.black),
                              ),
                              child: Text(
                                double.parse(labels.end).toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 23,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          runSpacing: -2,
                          children: [
                            CheckboxLTile(checklist1, 'Top'),
                            CheckboxLTile(checklist2, 'Pants'),
                            CheckboxLTile(checklist3, 'Jackets'),
                            CheckboxLTile(checklist4, 'Shoes'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width - 20,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple.shade700),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      icon: Icon(
        Icons.filter_list_outlined,
        size: 26,
        color: Theme.of(context).primaryColor,
      ),
      label: const Text(
        'Filter',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
