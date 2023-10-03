import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/presentation/widgets/remaining_time_widget.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this._request, {super.key});

  final Request _request;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${_request.service.name} service",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 52.0,
            child: RemainingTimeWidget(request: _request),
          ),
        ],
      ),
    );
  }
}
