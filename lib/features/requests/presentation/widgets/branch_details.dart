import 'package:bankease/features/requests/domain/entities/branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchDetails extends StatelessWidget {
  const BranchDetails({Key? key, required this.branch}) : super(key: key);

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: ExpansionTile(
        title: _buildTitle(),
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Institute:', branch.institute),
                _buildDetailRow('Branch:', branch.branch),
                _buildDetailRow('City:', branch.city),
                _buildDetailRow('Address:',
                    '${branch.address}, ${branch.postalCode}, ${branch.province}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          branch.institute,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          branch.branch,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
