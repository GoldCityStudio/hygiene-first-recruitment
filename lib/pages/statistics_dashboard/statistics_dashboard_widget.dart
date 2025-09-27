import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fl_chart/fl_chart.dart';
import '/models/statistics_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StatisticsDashboardWidget extends StatefulWidget {
  const StatisticsDashboardWidget({Key? key}) : super(key: key);

  static String get routeName => 'statistics_dashboard';
  static String get routePath => '/statistics';

  @override
  _StatisticsDashboardWidgetState createState() => _StatisticsDashboardWidgetState();
}

class _StatisticsDashboardWidgetState extends State<StatisticsDashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> _statistics = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print('StatisticsDashboard - initState called');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print('StatisticsDashboard - post frame callback');
      if (mounted) {
        _loadStatistics();
      }
    });
  }

  @override
  void dispose() {
    print('StatisticsDashboard - dispose called');
    super.dispose();
  }

  Future<void> _loadStatistics() async {
    print('StatisticsDashboard - _loadStatistics started');
    if (!mounted) {
      print('StatisticsDashboard - widget not mounted, returning');
      return;
    }

    setState(() {
      print('StatisticsDashboard - setting loading state to true');
      _isLoading = true;
    });

    try {
      print('Loading statistics...');
      
      final activeJobs = await StatisticsModel.getTotalActiveJobs();
      print('Active jobs: $activeJobs');
      
      final totalApplications = await StatisticsModel.getTotalApplications();
      print('Total applications: $totalApplications');
      
      final statusDistribution = await StatisticsModel.getApplicationStatusDistribution();
      print('Status distribution: $statusDistribution');
      
      final categoryDistribution = await StatisticsModel.getJobCategoryDistribution();
      print('Category distribution: $categoryDistribution');
      
      final salaryDistribution = await StatisticsModel.getSalaryRangeDistribution();
      print('Salary distribution: $salaryDistribution');
      
      final locationDistribution = await StatisticsModel.getJobLocationDistribution();
      print('Location distribution: $locationDistribution');
      
      final applicationTrends = await StatisticsModel.getApplicationTrends();
      print('Application trends: $applicationTrends');

      setState(() {
        _statistics = {
          'activeJobs': activeJobs,
          'totalApplications': totalApplications,
          'statusDistribution': statusDistribution,
          'categoryDistribution': categoryDistribution,
          'salaryDistribution': salaryDistribution,
          'locationDistribution': locationDistribution,
          'applicationTrends': applicationTrends,
        };
        _isLoading = false;
      });
      print('Statistics loaded successfully');
    } catch (e, stackTrace) {
      print('Error loading statistics: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('StatisticsDashboard - build called, isLoading: $_isLoading');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text(
          '統計數據',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadStatistics,
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewCards(),
                    SizedBox(height: 24),
                    _buildApplicationStatusChart(),
                    SizedBox(height: 24),
                    _buildJobCategoriesChart(),
                    SizedBox(height: 24),
                    _buildSalaryDistributionChart(),
                    SizedBox(height: 24),
                    _buildLocationDistributionChart(),
                    SizedBox(height: 24),
                    _buildApplicationTrendsChart(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildOverviewCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard(
          '活躍職位',
          _statistics['activeJobs']?.toString() ?? '0',
          Icons.work,
          Colors.blue,
        ),
        _buildStatCard(
          '總申請數',
          _statistics['totalApplications']?.toString() ?? '0',
          Icons.description,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: FlutterFlowTheme.of(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: color,
                    fontSize: 24,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationStatusChart() {
    final statusData = _statistics['statusDistribution'] as Map<String, int>? ?? {};
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '申請狀態分佈',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: statusData.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '${entry.key}\n${entry.value}',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCategoriesChart() {
    final categoryData = _statistics['categoryDistribution'] as Map<String, int>? ?? {};
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '職位類別分佈',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: categoryData.values.isEmpty ? 10 : categoryData.values.reduce((a, b) => a > b ? a : b).toDouble(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= categoryData.length) return Text('');
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              categoryData.keys.elementAt(value.toInt()),
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  barGroups: categoryData.entries.map((entry) {
                    return BarChartGroupData(
                      x: categoryData.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: Colors.blue,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryDistributionChart() {
    final salaryData = _statistics['salaryDistribution'] as Map<String, int>? ?? {};
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '薪資分佈',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: salaryData.values.isEmpty ? 10 : salaryData.values.reduce((a, b) => a > b ? a : b).toDouble(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= salaryData.length) return Text('');
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              salaryData.keys.elementAt(value.toInt()),
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  barGroups: salaryData.entries.map((entry) {
                    return BarChartGroupData(
                      x: salaryData.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: Colors.green,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDistributionChart() {
    final locationData = _statistics['locationDistribution'] as Map<String, int>? ?? {};
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '地區分佈',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: locationData.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '${entry.key}\n${entry.value}',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationTrendsChart() {
    final trendsData = _statistics['applicationTrends'] as Map<String, int>? ?? {};
    final sortedDates = trendsData.keys.toList()..sort();
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '申請趨勢 (最近30天)',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= sortedDates.length) return Text('');
                          final date = sortedDates[value.toInt()];
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              date.substring(5), // Show only MM-DD
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: sortedDates.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          trendsData[entry.value]?.toDouble() ?? 0,
                        );
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 