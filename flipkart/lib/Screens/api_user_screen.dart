import 'package:flutter/material.dart';
import 'package:my_first_app/api_services/user_service.dart';

class ApiUserScreen extends StatefulWidget {
  const ApiUserScreen({super.key});

  @override
  State<ApiUserScreen> createState() => _ApiUserScreenState();
}

class _ApiUserScreenState extends State<ApiUserScreen> {
  final service = UserService();
  @override
  void initState() {
    super.initState();
    service.getUsersApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API User Screen'),
      ),
    );
  }
}
