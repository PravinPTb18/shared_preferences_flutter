import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  /// variable to hold the data
  String? storedData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// read the data as page gets loaded
    getStoredData();
  }

  getStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    /// to read the value from key name and to store it in variable, if it is null show another string
    storedData =
        prefs.getString('stored-data') ?? "Display the stored data here...";

    /// to change the state when function is called
    setState(() {});
  }

  saveAndUpdateStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    /// to save the value using key name as stored-data
    /// checking the condition if controller is not empty else empty value will be set
    if (controller.text.isNotEmpty) {
      /// passing the controller value to store the data in preferences
      prefs.setString('stored-data', controller.text.toString());
    }

    ///again calling this function to display the updated and saved data
    getStoredData();
    setState(() {});
  }

  deleteStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    /// to delete the data using key-name as stored-data
    prefs.remove('stored-data');

    /// calling this function to update the deleted value
    getStoredData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// displaying the value which is stored using shared preference
            Text(
              storedData.toString(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Enter your data here",
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(16.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(16.0))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
                onPressed:
                    saveAndUpdateStoredData, // calling the function to save the data
                child: const Text("Save the data")),
            ElevatedButton(
                onPressed:
                    saveAndUpdateStoredData, // calling the function to update  the data
                child: const Text("Update the data")),
            ElevatedButton(
                onPressed:
                    deleteStoredData, // calling the function to delete the data
                child: const Text("Delete the data"))
          ],
        ),
      ),
    );
  }
}
