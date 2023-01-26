import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function selectfilters;
  final Map<String, bool> filtersSelcted;

  FiltersScreen(this.filtersSelcted, this.selectfilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _GlutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  initState() {
    _GlutenFree = widget.filtersSelcted['gluten'];
    _lactoseFree = widget.filtersSelcted['lactose'];
    _vegetarian = widget.filtersSelcted['vegetarian'];
    _vegan = widget.filtersSelcted['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subtitle, bool currentvalue, Function updatevalue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentvalue,
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> selectedfliters = {
                'gluten': _GlutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.selectfilters(selectedfliters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  'Gluten-Free', 'Includes only gluten-free meals', _GlutenFree,
                  (newvalue) {
                setState(() {
                  _GlutenFree = newvalue;
                });
              }),
              buildSwitchListTile('Lavtose-Free',
                  'Includes only lactose-free meals', _lactoseFree, (newvalue) {
                setState(() {
                  _lactoseFree = newvalue;
                });
              }),
              buildSwitchListTile(
                  'Vegetarian', 'Includes only Vegetarian meals', _vegetarian,
                  (newvalue) {
                setState(() {
                  _vegetarian = newvalue;
                });
              }),
              buildSwitchListTile('Vegan', 'Includes only Vegan meals', _vegan,
                  (newvalue) {
                setState(() {
                  _vegan = newvalue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
