import '../../models/contactDepartment.dart';
import 'package:flutter/material.dart';
import '../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class DepartmentSelectionDialog extends StatefulWidget {
  final MainModel model;

  DepartmentSelectionDialog(this.model);

  @override
  State<StatefulWidget> createState() => new _DepartmentSelectionDialogState();
}

class _DepartmentSelectionDialogState extends State<DepartmentSelectionDialog> {
  /// this is useful for filtering purpose
  TextEditingController controllerdepartment = new TextEditingController();
  List<ContactDepartment> _allDepartment;
  List<ContactDepartment> _searchedDepartments = [];

  @override
  Widget build(BuildContext context) => new SimpleDialog(
        title: new Column(
          children: <Widget>[
            new TextField(
              autocorrect: false,
              controller: controllerdepartment,
              decoration:
                  new InputDecoration(prefixIcon: new Icon(Icons.search)),
              onChanged: _filterElements,
            ),
          ],
        ),
        children: <Widget>[
          ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
            Widget content;
            if (widget.model.allDeparments.length > 0 &&
                !widget.model.isLoading) {
              _allDepartment = widget.model.allDeparments;
              content = new
              Container(
                height: MediaQuery.of(context).size.height-20,
                width: MediaQuery.of(context).size.width-10,
                child: _searchedDepartments.length != 0 ||
                        controllerdepartment.text.isNotEmpty
                    ? new ListView.builder(
                        itemCount: _searchedDepartments.length,
                        itemBuilder: (context, i) {
                          return _buildListDepartment(_searchedDepartments[i]);
                        },
                      )
                    : new ListView.builder(
                        itemCount: _allDepartment.length,
                        itemBuilder: (context, index) {
                          return _buildListDepartment(_allDepartment[index]);
                        },
                      ),
              );
            } else if (widget.model.isLoading) {
              content = Center(child: CircularProgressIndicator());
            }
            return content;
          }),
        ],
      );

  Widget _buildOption(ContactDepartment e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: new Icon(
                Icons.account_balance,
                size: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              e.tendonvi,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListDepartment(ContactDepartment contactDepartment) {
    return (Card(
        child: new Column(children: <Widget>[
      new ListTile(
        onTap: () => _selectItem(contactDepartment.madinhdanh),
        //leading: Icon(Icons.account_balance,size:15),

        title: new Text(
          contactDepartment.tendonvi,
          style: new TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),

    ])));
  }

  @override
  void initState() {
    if (widget.model.allDeparments.length == 0) {
      widget.model.fetchContactDepartments();
    }
    _allDepartment = widget.model.allDeparments;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toLowerCase();
    setState(() {
      _searchedDepartments = _allDepartment
          .where((e) => e.tendonvi.toLowerCase().contains(s))
          .toList();
    });
  }

  void _selectItem( String madinhdanh) {
    Navigator.pop(context, madinhdanh);
  }
}
