import 'package:flutter/material.dart';

Future<bool?> alertEditSuccessMessage(BuildContext context) async {
  // Show the dialog and wait for the result
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Are you sure you want to edit?",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Return true when "Yes" is pressed
                  },
                  child: const Text('Yes'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false when "No" is pressed
                  },
                  child: const Text('No'),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );

  // Return the result from the dialog
  return result; // This will return true, false, or null based on user input
}

void alertEditOk(context) {
  showDialog<bool?>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Successfully updated data",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Return true when "Yes" is pressed

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/', // Replace with your login route
                      (Route<dynamic> route) =>
                          false, // Remove all routes from the stack
                    );
                  },
                  child: const Text('Yes'),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

void alertEditUnSuccessMessage(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Unable to update information !\n Try again!",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print("del");
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Yes'),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

void alertDeleteSuccessMessage(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Successfully deleted data !",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print("del");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/', // Replace with your login route
                      (Route<dynamic> route) =>
                          false, // Remove all routes from the stack
                    );
                  },
                  child: const Text('Yes'),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

void alertDeleteUnSuccessMessage(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "The data has not been deleted!",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print("del");
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Yes'),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

void alertCreateSuccessMessage(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Successful data insertion !",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print("del");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/', // Replace with your login route
                      (Route<dynamic> route) =>
                          false, // Remove all routes from the stack
                    );
                  },
                  child: const Text('Yes'),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

void alertCreateUnSuccessMessage(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xFF383434),
      title: const Text(
        "Unable to add information ! \n Try again!",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Margin between buttons
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print("del");
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Yes'),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
