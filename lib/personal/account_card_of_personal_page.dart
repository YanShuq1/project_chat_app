import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 40.0),
      leading: const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: CircleAvatar(
          radius: 20.0,
          backgroundImage: AssetImage('images/image_drawer.png'),
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(left: 40.0),
        child: Text('我真的不彳亍'),
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(left: 40.0),
        child: Text('账号: ''Y15767792195'),
      ),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_2_outlined),
          Icon(Icons.chevron_right_outlined),
        ],
      ),
      onTap: (){
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
