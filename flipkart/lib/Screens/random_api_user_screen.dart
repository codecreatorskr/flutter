import 'package:flutter/material.dart';
import 'package:my_first_app/api_services/random_user_services.dart';
import 'package:my_first_app/models/random_models.dart';

class RandomUserScreen extends StatefulWidget {
  const RandomUserScreen({super.key});

  @override
  State<RandomUserScreen> createState() => _RandomUserScreenState();
}

class _RandomUserScreenState extends State<RandomUserScreen> {
  final service = RandomUserServices();

  RandomUser? user;

  bool isLoading = true;

  late String changeValue;
  late String changeTitle;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    service.getRandomUserApis().then((value) {
      user = value;
      isLoading = false;
      changeValue =
          '${user!.name.title}  ${user!.name.first}  ${user!.name.title}';
      changeTitle = 'Hi, My name is';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: const Center(
          child: Text(
            'Api Users',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : user == null
                ? const Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : RefreshIndicator(
                    // displacement: MediaQuery.of(context).size.height / 2,
                    // edgeOffset: 30,
                    color: Colors.cyan,
                     onRefresh: () {
                      return getUser();
                      // return Future.delayed(const Duration(seconds: 2)).then(
                      //   (value) => getUser(),
                      // );
                    },
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) => Column(
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      NetworkImage(user!.images.large),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 182),
                                  child: GestureDetector(
                                    onTap: () {
                                      getUser();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 60,
                                      color: const Color.fromARGB(187, 0, 0, 0),
                                      child: const Center(
                                        child: Text(
                                          'New',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              changeTitle,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              changeValue,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                  color: Colors.grey,
                                  highlightColor: Colors.green,
                                  iconSize: 35,
                                  onPressed: () {
                                    changeTitle = 'Hi, My name is';

                                    changeValue =
                                        '${user!.name.title}  ${user!.name.first}  ${user!.name.title}';
                                    setState(() {});
                                  },
                                  icon:
                                      const Icon(Icons.emoji_emotions_outlined),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                  color: Colors.grey,
                                  highlightColor: Colors.green,
                                  iconSize: 35,
                                  onPressed: () {
                                    changeTitle = 'My birthday is';
                                    changeValue = user!.dateOfBirth.date;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                  color: Colors.grey,
                                  highlightColor: Colors.green,
                                  iconSize: 35,
                                  onPressed: () {
                                    changeTitle = 'My Address is';

                                    changeValue =
                                        '${user!.address.street.name}  ${user!.address.city}  ${user!.address.state}  ${user!.address.country}';
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.location_on_outlined),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                  color: Colors.grey,
                                  highlightColor: Colors.green,
                                  iconSize: 35,
                                  onPressed: () {
                                    changeTitle = 'My Phone number is';
                                    changeValue = user!.phone;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.call),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                  color: Colors.grey,
                                  highlightColor: Colors.green,
                                  iconSize: 35,
                                  onPressed: () {
                                    changeTitle = 'My Id is';
                                    changeValue = user!.id.name;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.credit_card_outlined),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

//➡️➡️➡️➡️➡️➡️➡️➡️Random Api used in fututre builder
// import 'package:flutter/material.dart';
// import 'package:my_first_app/api_services/random_user_services.dart';
// import 'package:my_first_app/models/random_models.dart';

// class RandomUserScreen extends StatefulWidget {
//   const RandomUserScreen({super.key});

//   @override
//   State<RandomUserScreen> createState() => _RandomUserScreenState();
// }

// class _RandomUserScreenState extends State<RandomUserScreen> {
//   final service = RandomUserServices();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   service.getRandomUserApis();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Center(
//         child: Text(
//           'Api Users',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       )),
//       body: FutureBuilder(
//         future: service.getRandomUserApis(),
//         builder: (BuildContext context, AsyncSnapshot<RandomUser?> snapshot) {
//           return !snapshot.hasData
//               ? const Center(child: CircularProgressIndicator())
//               : snapshot.hasError && snapshot.data == null
//                   ? const Text('Something went wrong')
//                   : Column(
//                       children: [
//                         const SizedBox(height: 30),
//                         Stack(
//                           children: [
//                             Center(
//                               child: CircleAvatar(
//                                 radius: 100,
//                                 backgroundImage:
//                                     NetworkImage(snapshot.data!.images.large),
//                               ),
//                             ),
//                             Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 182),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                     height: 35,
//                                     width: 60,
//                                     color: const Color.fromARGB(187, 0, 0, 0),
//                                     child: const Center(
//                                       child: Text(
//                                         'New',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Text(
//                           'Hi, My name is',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Center(
//                           child: Text(
//                             '${snapshot.data!.name.title}  ${snapshot.data!.name.first}  ${snapshot.data!.name.title}',
//                             style: const TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               color: Colors.grey,
//                               highlightColor: Colors.green,
//                               iconSize: 35,
//                               onPressed: () {
//                                 const Text(
//                                   'Hi, My name is',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w500),
//                                 );
//                                 Center(
//                                   child: Text(
//                                     '${snapshot.data!.name.title}  ${snapshot.data!.name.first}  ${snapshot.data!.name.title}',
//                                     style: const TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.emoji_emotions_outlined),
//                             ),
//                             IconButton(
//                               color: Colors.grey,
//                               highlightColor: Colors.green,
//                               iconSize: 35,
//                               onPressed: () {},
//                               icon: const Icon(Icons.calendar_today),
//                             ),
//                             IconButton(
//                               color: Colors.grey,
//                               highlightColor: Colors.green,
//                               iconSize: 35,
//                               onPressed: () {},
//                               icon: const Icon(Icons.location_on_outlined),
//                             ),
//                             IconButton(
//                               color: Colors.grey,
//                               highlightColor: Colors.green,
//                               iconSize: 35,
//                               onPressed: () {},
//                               icon: const Icon(Icons.call),
//                             ),
//                             IconButton(
//                               color: Colors.grey,
//                               highlightColor: Colors.green,
//                               iconSize: 35,
//                               onPressed: () {},
//                               icon: const Icon(Icons.lock),
//                             ),
//                           ],
//                         )
//                       ],
//                     );
//         },
//       ),
//     );
//   }
// }
