import 'package:bankease/src.old/model/service_request.dart';
import 'package:bankease/src.old/viewmodels/request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
      ),
      child: StreamBuilder<List<ServiceRequest>>(
          stream: Provider.of<RequestViewModel>(context).requests,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("No Pending Request"));
            }

            List<ServiceRequest> requests = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                ),
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //   RequestDetailScreen.routeName,
                    //   arguments: tickets[i],
                    // );
                  },
                  child: const Text("Place holder"),
                  // child: RequestItem(
                  //   requests[i],
                  // ),
                ),
              ),
              itemCount: requests.length,
            );
          }),
    );
  }
}
