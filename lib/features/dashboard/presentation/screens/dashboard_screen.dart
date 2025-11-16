import 'package:bus_pos/features/authentication/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_pos/common/widgets/loading_overlay.dart';
import 'package:bus_pos/features/dashboard/presentation/components/quick_action_card.dart';
import 'package:bus_pos/features/dashboard/presentation/components/summary_section.dart';
import 'package:bus_pos/features/dashboard/providers/dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        final provider = Provider.of<DashboardProvider>(context, listen: false);
        SessionProvider sessionProvider = Provider.of<SessionProvider>(
          context,
          listen: false,
        );
        String operatorId = sessionProvider.user?.id ?? "operator123";
        provider.loadAll(context, operatorId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        final state = provider.state;

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const QuickActionCard(),

                  SummarySection(
                    totalBookings: state.bookings.length,
                    totalPayments: state.paymentsCount,
                    totalParcels: state.parcelBookings.length,
                  ),
                ],
              ),
            ),

            LoadingOverlay(
              isLoading: provider.isLoading,
              message: "Loading dashboard...",
              onCancel: () {},
            ),
          ],
        );
      },
    );
  }
}
