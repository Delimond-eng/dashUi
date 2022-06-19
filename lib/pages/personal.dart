// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dashui/models/personal.dart';
import 'package:dashui/services/db_helper.dart';
import 'package:dashui/widgets/custom_page.dart';
import 'package:dashui/widgets/input.dart';
import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  const Personal({Key key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Personals> personals = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var persons = await DbHelper.listPersonals();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Home | Personal",
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60.0,
                        width: constraint.maxWidth,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "Personals management",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputText(
                                  icon: Icons.assignment,
                                  title: "Personal Name",
                                  hintText: "Please fill this field !",
                                  errorText: "Personal name is required",
                                  controller: _txtName,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                InputText(
                                  icon: Icons.calendar_view_day_outlined,
                                  title: "Personal Year ago",
                                  hintText: "Please fill this field !",
                                  errorText: "Age of personal required",
                                  controller: _txtAge,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 60.0,
                                  width: constraint.maxWidth,
                                  child: RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    splashColor: Colors.pink[200],
                                    elevation: 10.0,
                                    onPressed: () async {
                                      Personals person = Personals(
                                        name: "Gaston",
                                        age: 12,
                                      );
                                      print(person.toMap());
                                    },
                                    child: const Text(
                                      "CREATE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  color: Colors.white,
                  child: personals.isEmpty
                      ? const Center(
                          child: Text(
                            "List empty",
                            style: TextStyle(color: Colors.pink),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: personals
                                .map(
                                  (data) => Row(
                                    children: [
                                      Flexible(
                                        child: PersonalCard(
                                          data: data,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PersonalCard extends StatelessWidget {
  final Personals data;
  const PersonalCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.withOpacity(.2),
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Personal name",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "${data.name} ",
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w900,
                fontSize: 18.0),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            "Personal year ago",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "${data.age}",
            style: const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
