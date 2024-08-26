import 'package:assessment/components/signout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final ScrollController scrollController;

  ProfileScreen({required this.scrollController});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'User Name';
      _email = prefs.getString('email') ?? 'user@example.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.22;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: radius * 0.5,
                    backgroundColor: const Color.fromARGB(255, 202, 202, 202),
                    child: Icon(Icons.person,
                        size: radius * 0.6, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _name ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _email ?? '',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ])
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 168, 168, 168),
          shape: const CircleBorder(),
          tooltip: "Sign Out",
          child: const Image(
            height: 20,
            width: 20,
            image: AssetImage('assets/on-off-button.png'),
          ),
          onPressed: () {
            Provider.of<SignOut>(context, listen: false).logout(context);
          }),
    );
  }
}
