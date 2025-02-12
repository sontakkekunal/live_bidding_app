import 'package:dealer_caryanam/Model/questions_model.dart';
import 'package:intl/intl.dart';

class ImpDocModel {
  late int inspectionReportId;
  late int userId;
  late int beadingCarId;
  late String registrationDate;
  late String rto;
  late String fitnessUpto;
  late String cnglpgfitmentInRC;
  late dynamic nocstatus;
  late String rcavailability;
  late String mismatchInRC;
  late String rtonocissued;
  late String insuranceType;
  late String noClaimBonus;
  late String underHypothecation;
  late String loanStatus;
  late String roadTaxPaid;
  late String partipeshiRequest;
  late String duplicateKey;
  late String chassisNumberEmbossing;
  late String manufacturingDate;

  DateFormat inputFormat = DateFormat("MM/dd/yyyy");
  DateFormat outputFormat = DateFormat("yyyy-MM-dd");

  ImpDocModel(
      {required this.inspectionReportId,
      required this.userId,
      required this.beadingCarId,
      required this.registrationDate,
      required this.rto,
      required this.fitnessUpto,
      required this.cnglpgfitmentInRC,
      required this.nocstatus,
      required this.rcavailability,
      required this.mismatchInRC,
      required this.rtonocissued,
      required this.insuranceType,
      required this.noClaimBonus,
      required this.underHypothecation,
      required this.loanStatus,
      required this.roadTaxPaid,
      required this.partipeshiRequest,
      required this.duplicateKey,
      required this.chassisNumberEmbossing,
      required this.manufacturingDate});

  ImpDocModel.fromJson(Map<String, dynamic> json) {
    inspectionReportId = json['inspectionReportId'];
    userId = json['userId'];
    beadingCarId = json['beadingCarId'];
    registrationDate = json['registrationDate'];
    rto = json['rto'];
    fitnessUpto = json['fitnessUpto'];
    cnglpgfitmentInRC = json['cnglpgfitmentInRC'];
    nocstatus = json['nocstatus'];
    rcavailability = json['rcavailability'];
    mismatchInRC = json['mismatchInRC'];
    rtonocissued = json['rtonocissued'];
    insuranceType = json['insuranceType'];
    noClaimBonus = json['noClaimBonus'];
    underHypothecation = json['underHypothecation'];
    loanStatus = json['loanStatus'];
    roadTaxPaid = json['roadTaxPaid'];
    partipeshiRequest = json['partipeshiRequest'];
    duplicateKey = json['duplicateKey'];
    chassisNumberEmbossing = json['chassisNumberEmbossing'];
    manufacturingDate = json['manufacturingDate'];
  }

  List<QuestionsModel> getImpDocSq() {
    return <QuestionsModel>[
      QuestionsModel(question: 'RC Availability', answer: rcavailability),
      QuestionsModel(question: 'Mismatch in RC', answer: mismatchInRC),
      QuestionsModel(question: 'RTO NOC Issued', answer: rtonocissued),
      QuestionsModel(question: 'Insurance Type', answer: insuranceType),
      QuestionsModel(question: 'No Claim Bonus', answer: noClaimBonus),
      QuestionsModel(
          question: 'Under Hypothecation', answer: underHypothecation),
      QuestionsModel(question: 'Road Tax Paid', answer: roadTaxPaid),
      QuestionsModel(question: 'Partipeshi Request', answer: partipeshiRequest),
      QuestionsModel(question: 'Duplicate Key', answer: duplicateKey),
      QuestionsModel(
          question: 'Chassis Number Embossing', answer: chassisNumberEmbossing),
      QuestionsModel(question: 'Manufacturing Date', answer: manufacturingDate),
      QuestionsModel(question: 'Registration Date', answer: registrationDate),
      QuestionsModel(question: 'RTO', answer: rto),
      QuestionsModel(question: 'Fitness Upto', answer: fitnessUpto),
      QuestionsModel(
          question: 'CNG/LPG Fitment in RC', answer: cnglpgfitmentInRC)
    ];
  }

  Map<String, dynamic> toJsonAddInspector() {
    print(registrationDate);
    print(manufacturingDate);
    print(fitnessUpto);

    final Map<String, dynamic> data = <String, dynamic>{};
    //data['inspectionReportId'] = inspectionReportId;
    data['userId'] = userId;
    data['beadingCarId'] = beadingCarId;

    data['registrationDate'] =
        outputFormat.format(inputFormat.parse(registrationDate));
    data['rto'] = rto;
    data['fitnessUpto'] = outputFormat.format(inputFormat.parse(fitnessUpto));
    data['cnglpgfitmentInRC'] = cnglpgfitmentInRC;
    //data['nocstatus'] = nocstatus;
    data['rcavailability'] = rcavailability;
    data['mismatchInRC'] = mismatchInRC;
    data['rtonocissued'] = rtonocissued;
    data['insuranceType'] = insuranceType;
    data['noClaimBonus'] = noClaimBonus;
    data['underHypothecation'] = underHypothecation;
    data['loanStatus'] = loanStatus;

    data['roadTaxPaid'] = roadTaxPaid;
    data['partipeshiRequest'] = partipeshiRequest;

    data['duplicateKey'] = duplicateKey;
    data['chassisNumberEmbossing'] = chassisNumberEmbossing;
    data['manufacturingDate'] =
        outputFormat.format(inputFormat.parse(manufacturingDate));
    return data;
  }
}
