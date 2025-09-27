import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/jobs_record.dart';
import '/backend/schema/applications_record.dart';

class StatisticsModel {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get total count of active jobs
  static Future<int> getTotalActiveJobs() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: 'active')
        .get();
    return snapshot.size;
  }

  // Get total applications count
  static Future<int> getTotalApplications() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('applications')
        .get();
    return snapshot.size;
  }

  // Get applications per job
  static Future<Map<String, int>> getApplicationsPerJob() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('applications')
        .get();
    
    Map<String, int> applicationsPerJob = {};
    for (var doc in snapshot.docs) {
      final jobRef = (doc.data() as Map<String, dynamic>)['job_ref'] as DocumentReference?;
      if (jobRef != null) {
        final jobId = jobRef.id;
        applicationsPerJob[jobId] = (applicationsPerJob[jobId] ?? 0) + 1;
      }
    }
    return applicationsPerJob;
  }

  // Get application status distribution
  static Future<Map<String, int>> getApplicationStatusDistribution() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('applications')
        .get();
    
    Map<String, int> statusDistribution = {};
    for (var doc in snapshot.docs) {
      final status = (doc.data() as Map<String, dynamic>)['status'] as String? ?? 'Pending';
      statusDistribution[status] = (statusDistribution[status] ?? 0) + 1;
    }
    return statusDistribution;
  }

  // Get job category distribution
  static Future<Map<String, int>> getJobCategoryDistribution() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: 'active')
        .get();
    
    Map<String, int> categoryDistribution = {};
    for (var doc in snapshot.docs) {
      final categories = (doc.data() as Map<String, dynamic>)['category_refs'] as List<dynamic>?;
      if (categories != null) {
        for (var category in categories) {
          final categoryRef = category as DocumentReference;
          final categoryId = categoryRef.id;
          categoryDistribution[categoryId] = (categoryDistribution[categoryId] ?? 0) + 1;
        }
      }
    }
    return categoryDistribution;
  }

  // Get salary range distribution
  static Future<Map<String, int>> getSalaryRangeDistribution() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: 'active')
        .get();
    
    Map<String, int> salaryRanges = {
      '0-10000': 0,
      '10001-20000': 0,
      '20001-30000': 0,
      '30001-40000': 0,
      '40001+': 0
    };

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final maxSalary = (data['salary_maximum'] as num?)?.toDouble() ?? 0;
      
      if (maxSalary <= 10000) {
        salaryRanges['0-10000'] = (salaryRanges['0-10000'] ?? 0) + 1;
      } else if (maxSalary <= 20000) {
        salaryRanges['10001-20000'] = (salaryRanges['10001-20000'] ?? 0) + 1;
      } else if (maxSalary <= 30000) {
        salaryRanges['20001-30000'] = (salaryRanges['20001-30000'] ?? 0) + 1;
      } else if (maxSalary <= 40000) {
        salaryRanges['30001-40000'] = (salaryRanges['30001-40000'] ?? 0) + 1;
      } else {
        salaryRanges['40001+'] = (salaryRanges['40001+'] ?? 0) + 1;
      }
    }
    return salaryRanges;
  }

  // Get location distribution of jobs
  static Future<Map<String, int>> getJobLocationDistribution() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: 'active')
        .get();
    
    Map<String, int> locationDistribution = {};
    for (var doc in snapshot.docs) {
      final location = (doc.data() as Map<String, dynamic>)['location'] as String? ?? 'Unknown';
      locationDistribution[location] = (locationDistribution[location] ?? 0) + 1;
    }
    return locationDistribution;
  }

  // Get application trends over time (last 30 days)
  static Future<Map<String, int>> getApplicationTrends() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final QuerySnapshot snapshot = await _firestore
        .collection('applications')
        .where('time_created', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();
    
    Map<String, int> dailyTrends = {};
    for (var doc in snapshot.docs) {
      final timeCreated = (doc.data() as Map<String, dynamic>)['time_created'] as Timestamp?;
      if (timeCreated != null) {
        final date = timeCreated.toDate().toString().split(' ')[0];
        dailyTrends[date] = (dailyTrends[date] ?? 0) + 1;
      }
    }
    return dailyTrends;
  }

  // Get company-specific metrics
  static Future<Map<String, dynamic>> getCompanyMetrics(String companyRef) async {
    final jobsSnapshot = await _firestore
        .collection('jobs')
        .where('company_ref', isEqualTo: companyRef)
        .get();
    
    final applicationsSnapshot = await _firestore
        .collection('applications')
        .where('company_ref', isEqualTo: companyRef)
        .get();
    
    return {
      'total_jobs': jobsSnapshot.size,
      'total_applications': applicationsSnapshot.size,
      'active_jobs': jobsSnapshot.docs.where((doc) => 
        JobsRecord.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>).status == 'active'
      ).length,
    };
  }

  // Get applicant success rate
  static Future<double> getApplicantSuccessRate(String applicantRef) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('applications')
        .where('applicant_ref', isEqualTo: applicantRef)
        .get();
    
    if (snapshot.size == 0) return 0.0;
    
    int successfulApplications = 0;
    for (var doc in snapshot.docs) {
      final application = ApplicationsRecord.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
      if (application.status == 'accepted') {
        successfulApplications++;
      }
    }
    
    return successfulApplications / snapshot.size;
  }
} 