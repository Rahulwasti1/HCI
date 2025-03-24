import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/providers/auth_provider.dart';
import 'package:hci/providers/energy_provider.dart';
import 'package:hci/screens/main/add_room_screen.dart';
import 'package:hci/widgets/energy_chart.dart';
import 'package:hci/widgets/room_usage_card.dart';
import 'package:hci/widgets/time_frame_selector.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load energy data when screen initializes
    _loadData();
  }

  void _loadData() {
    // Use Future.microtask to avoid calling setState during build
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<EnergyProvider>(context, listen: false).loadEnergyData();
    });
  }

  String _getTimeFrameDescription(String timeFrame) {
    final now = DateTime.now();
    switch (timeFrame) {
      case 'Daily':
        return DateFormat('MMMM d, yyyy').format(now);
      case 'Weekly':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d').format(weekEnd)}';
      case 'Yearly':
        return now.year.toString();
      case 'Monthly':
      default:
        return DateFormat('MMMM yyyy').format(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final energyProvider = Provider.of<EnergyProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: energyProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => energyProvider.loadEnergyData(),
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            constraints.maxHeight - 32, // Account for padding
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User greeting and profile
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.primaryLight,
                                    backgroundImage: authProvider
                                                .user?.profileImage !=
                                            null
                                        ? NetworkImage(
                                            authProvider.user!.profileImage!)
                                        : null,
                                    child:
                                        authProvider.user?.profileImage == null
                                            ? const Icon(
                                                Icons.person,
                                                color: AppColors.primary,
                                              )
                                            : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.waving_hand,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Hello!',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        authProvider.user?.name ??
                                            'Rahul Wasti',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined),
                                onPressed: () {
                                  // Show notifications
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Energy usage card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryDark
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(
                                    102, // 0.4 * 255 = 102
                                    AppColors.primary.red,
                                    AppColors.primary.green,
                                    AppColors.primary.blue,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Time period description
                                Text(
                                  _getTimeFrameDescription(
                                      energyProvider.selectedTimeFrame),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Energy usage header
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Energy Usage',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${energyProvider.currentEnergyUsage.toStringAsFixed(1)} kWH',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Est. Cost',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rs.${energyProvider.currentEstimatedCost.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Time frame selector
                                TimeFrameSelector(
                                  selectedTimeFrame:
                                      energyProvider.selectedTimeFrame,
                                  onTimeFrameSelected: (timeFrame) {
                                    energyProvider.setTimeFrame(timeFrame);
                                  },
                                ),
                                const SizedBox(height: 20),
                                // Energy chart
                                EnergyChart(
                                  usageData: energyProvider.getFilteredUsage(),
                                  timeFrame: energyProvider.selectedTimeFrame,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Consumption by rooms
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Consumption By Rooms',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Show all rooms
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'See All',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Room usage cards - single column layout
                          energyProvider.energyData != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: energyProvider
                                      .energyData!.roomUsage.length,
                                  itemBuilder: (context, index) {
                                    final room = energyProvider
                                        .energyData!.roomUsage[index];
                                    return RoomUsageCard(
                                      roomUsage: room,
                                      onTap: () {
                                        // Navigate to room details
                                      },
                                    );
                                  },
                                )
                              : const SizedBox(),

                          // Add Room Button
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddRoomScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                          0x33FFFFFF), // White with 20% opacity (0x33)
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Add Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      ),
    );
  }
}
