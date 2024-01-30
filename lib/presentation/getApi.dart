import 'package:crud_bloc_api/logic/getcubit/get_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetApi extends StatefulWidget {
  const GetApi({super.key, req});

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  @override
  void initState() {
    context.read<GetApiCubit>().getData();
    super.initState();
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetApiCubit, GetApiState>(
              builder: (context, state) {
                if (state is GetApiLoading) {
                  const CircularProgressIndicator();
                } else if (state is GetApiError) {
                  const Text("Get Failed to Load Data");
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var data = state.datamodel?[index];
                    return ListTile(
                      title: Text(data?.email ?? ""),
                      subtitle: Text(data?.password ?? ""),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              onTap: () {
                                _bottomSheetUpdate(context, index);
                              },
                              child: const Icon(Icons.mode_edit_outline)),
                          InkWell(
                              onTap: () {
                                _bottomSheetDelete(context, index);
                              },
                              child: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  },
                  itemCount: state.datamodel?.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bottomSheet(context);
          },
          child: const Icon(Icons.add)),
    );
  }

  _bottomSheet(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add User Email and Password'),
        content: const Text('.....'),
        actions: [
          BlocBuilder<GetApiCubit, GetApiState>(
            builder: (context, state) {
              if (state is GetApiLoading) {
                const CircularProgressIndicator();
              }
              return Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Email*"),
                        validator: (val) {
                          RegExp emailRegex = RegExp(
                            r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(val.toString())) {
                            return "Email is not correct in format";
                          }
                          if (val == null || val.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                        controller: emailcontroller,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Password*"),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please Enter valid password";
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              context.read<GetApiCubit>().postData(
                                  emailcontroller.text,
                                  passwordcontroller.text);
                              context.read<GetApiCubit>().getData();
                            }
                          },
                          child: const Text('Save User'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }

  _bottomSheetDelete(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: const Text("Do you want to delete"), actions: [
              BlocBuilder<GetApiCubit, GetApiState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<GetApiCubit>().deleteUser(
                                state.datamodel![index].id.toString());
                            Navigator.pop(context);
                          },
                          child: const Text("Yes")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"))
                    ],
                  );
                },
              )
            ]));
  }

  _bottomSheetUpdate(BuildContext context, int index) {
      final user = context.read<GetApiCubit>().state.datamodel![index];

     emailcontroller.text = user.email.toString();
  passwordcontroller.text = user.password.toString();
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('Update User'),
          content: const Text('.....'),
          actions: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Email *", ),
                      controller: emailcontroller,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Password *"),
                      controller: passwordcontroller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<GetApiCubit, GetApiState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<GetApiCubit>().updateUser(
                                  state.datamodel![index].id.toString(),
                                  emailcontroller.text,
                                  passwordcontroller.text);
                              Navigator.pop(context);

                              context.read<GetApiCubit>().getData();
                            },
                            child: const Text('update User'),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                )),
          ]),
    );
  }
}
