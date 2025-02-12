import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../Model/about_us_model.dart';
import '../Model/car_verify_model.dart';
import '../Model/questions_model.dart';
part 'local_data_controller.g.dart';

final List<QuestionsModel> freqAskedQuestionsList = [
  QuestionsModel(
      question: 'When and Where I can take text drive?',
      answer:
          'You can schedule a home test drive for this Autocar assured car at any date and time you find convenient using our test drive booking form.Your assigned Autocar Relationship Manager will then reach out to you and make sure all the details of your preferred car are made available to you before arriving at your home on the selected date & time for the test drive.'),
  QuestionsModel(
      question: 'What benefits CaryanamIndia give us?',
      answer:
          'Accessing helpful tips and advice on maintaining a second hand car. hassle-free-trade-in program for your current vehicle.'),
  QuestionsModel(
      question: 'How do I book a car of my choice',
      answer:
          'You can book a car. If you complete the purchase of the vehicle within the holding period, the deposit will be applied towards the purchase otherwise the booking amount will be refunded back to you and the booking cancelled.'),
  QuestionsModel(
      question: 'Is replacement option available?',
      answer:
          'Absolutely yes, replacement option is available and hassle-free-trade-in program for your current vehicle.'),
  QuestionsModel(
      question: 'Will CaryanamIndia give us history of vehicle?',
      answer:
          'Yes, We verify important details such as ownership history, accident records, and maintenance records.'),
  QuestionsModel(
      question: 'Will CaryanamIndia help me with car finance ?',
      answer:
          'Absolutely, buyers can choose to avail financing through Autocar wherein we would get the loan processed through our finance partners. Our established partnerships help us process loans faster and get our customers better interest rates. Depending on your credit worthiness, you can avail used car loans through Autocar at interest rates as low as 12.99% compared to the market rates of 14-16%.'),
  QuestionsModel(
      question: 'Will CaryanamIndia give us extended warranty?',
      answer:
          'Protect your investment with our extended warranty options. Get peace of mind knowing that your second-hand car is covered against unexpected repairs.')
];

final List<AboutUsModel> aboutUsList = [
  AboutUsModel(
      title: 'World-class Cars | Our Mission',
      descp:
          'At CaryanamIndia, our mission is to provide a seamless and trustworthy platform for buying and selling second-hand cars. We strive to make the car buying experience convenient, transparent, and enjoyable for every customer.'),
  AboutUsModel(
      title: 'Your world-class SecondHand Cars here',
      descp:
          'At SecondHandCars, we are passionate about providing high-quality, reliable second-hand cars to our customers. With years of experience in the automotive industry, we understand the importance of trust, transparency, and customer satisfaction.'),
  AboutUsModel(
      title: 'Who We Are',
      descp:
          'CaryanamIndia is a team of passionate car enthusiasts dedicated to revolutionizing the way people buy and sell used cars. With years of experience in the automotive industry, our team brings expertise, integrity, and innovation to every aspect of our business.'),
  AboutUsModel(title: 'What We Offer', list: [
    QuestionsModel(
        question: 'Wide Selection:',
        answer:
            'We offer a diverse range of second-hand cars, including sedans, SUVs, trucks, and more, to suit every budget and preference.'),
    QuestionsModel(
        question: 'Quality Assurance:',
        answer:
            'Every car listed on our platform undergoes a thorough inspection process to ensure its quality and reliability.'),
    QuestionsModel(
        question: 'Transparent Transactions:',
        answer:
            'We believe in transparency and honesty. Our listings provide detailed information about each car, including its history, condition, and pricing.'),
    QuestionsModel(
        question: 'Exceptional Customer Service:',
        answer:
            'Our dedicated team of customer service representatives is here to assist you at every step of the car buying process. Whether you have questions about a listing or need guidance, we are here to help.')
  ]),
  AboutUsModel(title: 'Why Choose Us', list: [
    QuestionsModel(
        question: 'Trustworthiness: ',
        answer:
            'We prioritize integrity and trust in all our interactions. You can rely on us for fair pricing, accurate listings, and honest advice.'),
    QuestionsModel(
        question: 'Convenience: ',
        answer:
            'Our user-friendly platform makes it easy to browse, compare, and purchase cars from the comfort of your home.'),
    QuestionsModel(
        question: 'Peace of Mind: ',
        answer:
            'With our quality assurance process and customer support, you can buy with confidence, knowing that you are getting a dependable vehicle backed by exceptional service.')
  ]),
  AboutUsModel(
      title:
          'Thank you for choosing SecondHandCars for all your automotive needs. We look forward to serving you!'),
  AboutUsModel(title: 'It’s a whole big world in here. Come on in.')
];

final List<QuestionsModel> privacyPolicyList = [
  QuestionsModel(
      question: 'Our Commitment to You',
      answer:
          '''At CaryanamIndia, your privacy is a top priority. Your privacy is at the core of the way we design and build the services and products you know and love, so that you can fully trust them and focus on building meaningful connections.\n\nWe appreciate that you put your trust in us when you provide us with your information and we do not take this lightly.\n\nWe do not compromise with your privacy. We design all of our products and services with your privacy in mind. We involve experts from various fields, including legal, security, engineering, product design and others to make sure that no decision is taken without respect for your privacy.\n\nWe strive to be transparent in the way we process your data. Because we use many of the same online services you do, we know that insufficient information and overly complicated language are common issues in privacy policies. We take the exact opposite approach: we have written our Privacy Policy and related documents in plain language. We actually want you to read our policies and understand our privacy practices!\n\nWe work hard to keep your information secure. We have teams dedicated to keeping your data safe and secure. We constantly update our security practices and invest in our security efforts to enhance the safety of your information.'''),
  QuestionsModel(
      question: 'Privacy Policy',
      answer:
          '''Welcome to CaryanamIndia’s Privacy Policy. Thank you for taking the time to read it.\n\nWe appreciate that you trust us with your information and we intend to always keep that trust. This starts with making sure you understand the information we collect, why we collect it, how it is used and your choices regarding your information. This Policy describes our privacy practices in plain language, keeping legal and technical jargon to a minimum.\n\n\t1. Who We Are \n\t2. Where This Privacy Policy Applies \n\t3. Information We Collect \n\t4. Cookies And Other Similar Data Collection Technologies \n\t5. How We Use Information \n\t6. How We Share Information \n\t7. How We Protect Your Information \n\t8. How Long We Retain Your Information \n\t9. Privacy Policy Changes \n\t10. How To Contact Us'''),
  QuestionsModel(
      question: '1. Who We Are',
      answer:
          'The company that is responsible for your information under this Privacy Policy (the “data controller”) is:'),
  QuestionsModel(
      question: '2. Where This Privacy Policy Applies',
      answer:
          'This Privacy Policy applies to websites, apps, events and other services operated by CaryanamIndia. For simplicity, we refer to all of these as our “services” in this Privacy Policy.'),
  QuestionsModel(
      question: '3. Information We Collect',
      answer:
          '''We collect basic profile details and the training you use our services, for example access logs, as well as information from third parties, like when you access our services through a social media account. If you want additional info, we go into more detail below.

When you participate in surveys or focus groups, you give us your insights into our products and services, responses to our questions and testimonials.
When you choose to participate in our promotions, events or contests, we collect the information that you use to register or enter.
If you contact our customer care team, we collect the information you give us during the interaction. Sometimes, we monitor or record these interactions for training purposes and to ensure a high quality of service.
If you ask us to communicate with or otherwise process information of other people (for example, if you ask us to send an email on your behalf to one of your friends), we collect the information about others that you give us in order to complete your request.
When you take classes, we collect your attendance
When you take tests, we collect your performance
Of course, we also process your chats with other users as well as the content you publish, as part of the operation of the services.

Information we receive from others

In addition to the information you provide us directly, we receive information about you from others, including:

Other Users Other users may provide information about you as they use our services. For instance, we may collect information about you from other users if they contact us about you.
Social Media You may be able to use your social media login (such as Facebook Login) to create and log into your CaryanamIndia account. This saves you from having to remember yet another user name and password and allows you to share some information from your social media account with us.
Other Partners We may receive info about you from other social networking platforms or from our partners, for instance where CaryanamIndia ads are published on a partner’s websites and platforms (in which case they may pass along details on a campaign’s success).

Information collected when you use our services

When you use our services, we collect information about which features you’ve used, how you’ve used them and the devices you use to access our services. See below for more details:

Usage Information We collect information about your activity on our services, for instance how you use them (e.g., date and time you logged in, features you’ve been using, searches, clicks and pages which have been shown to you, referring web page address, advertising that you click on) and how you interact with other users (e.g., users you connect and interact with, time and date of your exchanges, number of messages you send and receive).

Device information We collect information from and about the device(s) you use to access our services, including:

hardware and software information such as IP address, device ID and type, device-specific and apps settings and characteristics, app crashes, advertising IDs (such as Google’s AAID and Apples IDFA, both of which are randomly generated numbers that you can reset by going into your device’ settings), browser type, version and language, operating system, time zones, identifiers associated with cookies or other technologies that may uniquely identify your device or browser (e.g., IMEI/UDID and MAC address);
information on your wireless and mobile network connection, like your service provider and signal strength;
information on device sensors such as accelerometers, gyroscopes and compasses.'''),
  QuestionsModel(
      question: '4. Cookies and Other Similar Data Collection Technologies',
      answer:
          '''We use and may allow others to use cookies and similar technologies (e.g., web beacons, pixels) to recognize you and/or your device(s). We use cookie related information (such as authenticating you, remembering your preferences and settings, analyzing site traffic and trends, delivering and measuring the effectiveness of advertising campaigns, allowing you to use social features) and how you can better control their use, through your browser settings and other tools.

Some web browsers (including Safari, Internet Explorer, Firefox and Chrome) have a “Do Not Track” (“DNT”) feature that tells a website that a user does not want to have his or her online activity tracked. If a website that responds to a DNT signal receives a DNT signal, the browser can block that website from collecting certain information about the browser’s user. Not all browsers offer a DNT option and DNT signals are not yet uniform. For this reason, many businesses, including CaryanamIndia, do not currently respond to DNT signals. '''),
  QuestionsModel(
      question: '5. How We Use Information',
      answer:
          '''The main reason we use your information is to deliver and improve our services. Additionally, we use your info to help keep you safe and to provide you with advertising that may be of interest to you. Read on for a more detailed explanation of the various reasons we use your information, together with practical examples.

To improve our services and develop new ones, we

Administer focus groups and surveys
Conduct research and analysis of users’ behavior to improve our services and content (for instance, we may decide to change the look and feel or even substantially modify a given feature based on users’ behavior)
Develop new features and services (for example, we may decide to build a new interests-based feature further to requests received from users).

To prevent, detect and fight fraud or other illegal or unauthorized activities

Address ongoing or alleged misbehavior on and off-platform
Perform data analysis to better understand and design countermeasures against these activities
Retain data related to fraudulent activities to prevent against recurrences

To ensure legal compliance

Comply with legal requirements
Assist law enforcement
Enforce or exercise our rights, for example our Terms

To process your information as described above, we rely on the following legal bases:

Provide our service to you: Most of the time, the reason we process your information is to perform the contract that you have with us. For instance, as you go about using our service to build meaningful connections, we use your information to maintain your account and your profile, to make it viewable to other users and recommend other users to you.
Legitimate interests: We may use your information where we have legitimate interests to do so. For instance, we analyze users’ behavior on our services to continuously improve our offerings, we suggest offers we think might interest you, and we process information for administrative, fraud detection and other legal purposes.
Consent: From time to time, we may ask for your consent to use your information for certain specific reasons. You may withdraw your consent at any time by contacting us at the address provided at the end of this Privacy Policy.'''),
  QuestionsModel(
      question: '6. How We Share Information',
      answer:
          '''Since our goal is to help you make meaningful connections, the main sharing of users’ information is, of course, with other users. We also share some users’ information with service providers and partners who assist us in operating the services, with other Match Group companies and, in some cases, legal authorities. Read on for more details about how your information is shared with others.

With our service providers and partners

We use third parties to help us operate and improve our services. These third parties assist us with various tasks, including data hosting and maintenance, analytics, customer care, marketing, advertising, payment processing and security operations.

We may also share information with partners who distribute and assist us in advertising our services. For instance, we may share limited information on you in hashed, non-human readable form to advertising partners.

We follow a strict vetting process prior to engaging any service provider or working with any partner. All of our service providers and partners must agree to strict confidentiality obligations.

For corporate transactions

We may transfer your information if we are involved, whether in whole or in part, in a merger, sale, acquisition, divestiture, restructuring, reorganization, dissolution, bankruptcy or other change of ownership or control.

When required by law

We may disclose your information if reasonably necessary: (i) to comply with a legal process, such as a court order, subpoena or search warrant, government / law enforcement investigation or other legal requirements; (ii) to assist in the prevention or detection of crime (subject in each case to applicable law); or (iii) to protect the safety of any person.

To enforce legal rights

We may also share information: (i) if disclosure would mitigate our liability in an actual or threatened lawsuit; (ii) as necessary to protect our legal rights and legal rights of our users, business partners or other interested parties; (iii) to enforce our agreements with you; and (iv) to investigate, prevent, or take other action regarding illegal activity, suspected fraud or other wrongdoing.

With your consent or at your request

We may ask for your consent to share your information with third parties. In any such case, we will make it clear why we want to share the information.

We may use and share non-personal information (meaning information that, by itself, does not identify who you are such as device information, general demographics, general behavioral data, geolocation in de-identified form), as well as personal information in hashed, non-human readable form, under any of the above circumstances.

We want you to be aware of your privacy rights. Here are a few key points to remember:

Updating your information. If you believe that the information we hold about you is inaccurate or that we are no longer entitled to use it and want to request its rectification, deletion or object to its processing, please contact us at asif.attar@caryanam.in
For your protection and the protection of all of our users, we may ask you to provide proof of identity before we can answer the above requests.

Keep in mind, we may reject requests for certain reasons, including if the request is unlawful or if it may infringe on trade secrets or intellectual property or the privacy of another user. If you wish to receive information relating to another user, such as a copy of any messages you received from him or her through our service, the other user will have to contact our Privacy Officer to provide their written consent before the information is released.

Also, we may not be able to accommodate certain requests to object to the processing of personal information, notably where such requests would not allow us to provide our service to you anymore. For instance, we cannot provide our service if we do not have your date of birth.

Uninstall. You can stop all information collection by an app by uninstalling it using the standard uninstall process for your device. If you uninstall the app from your mobile device, the unique identifier associated with your device will continue to be stored. If you reinstall the application on the same mobile device, we will be able to re-associate this identifier to your previous transactions and activities.
Accountability. In certain countries, including in the European Union, you have a right to lodge a complaint with the appropriate data protection authority if you have concerns about how we process your personal information. The data protection authority you can lodge a complaint with notably may be that of your habitual residence, where you work or where we are established.'''),
  QuestionsModel(
      question: '7. How We Protect Your Information',
      answer:
          '''We work hard to protect you from unauthorized access to or alteration, disclosure or destruction of your personal information. As with all technology companies, although we take steps to secure your information, we do not promise, and you should not expect, that your personal information will always remain secure.

We regularly monitor our systems for possible vulnerabilities and attacks and regularly review our information collection, storage and processing practices to update our physical, technical and organizational security measures.

We may suspend your use of all or part of the services without notice if we suspect or detect any breach of security. If you believe that your account or information is no longer secure, please notify us immediately on asif.attar@caryanam.in'''),
  QuestionsModel(
      question: '8. How Long We Retain Your Information',
      answer:
          '''We keep your personal information only as long as we need it for legitimate business and as permitted by applicable law. To protect the safety and security of our users on and off our services, we implement a safety retention window of three months following account deletion. During this period, account information will be retained although the account will of course not be visible on the services anymore.

In practice, we delete or anonymize your information upon deletion of your account (following the safety retention window) or after two years of continuous inactivity, unless:

1. We must keep it to comply with applicable law (for instance, some “traffic data” is kept for one year to comply with statutory data retention obligations);
2. We must keep it to evidence our compliance with applicable law (for instance, records of consents to our Terms, Privacy Policy and other similar consents are kept for five years);
3. There is an outstanding issue, claim or dispute requiring us to keep the relevant information until it is resolved; or
4. The information must be kept for our legitimate business interests, such as fraud prevention and enhancing users safety and security. For example, information may need to be kept to prevent a user who was banned for unsafe behavior or security incidents from opening a new account.

Keep in mind that even though our systems are designed to carry out data deletion processes according to the above guidelines, we cannot promise that all data will be deleted within a specific time frame due to technical constraints.'''),
  QuestionsModel(
      question: '9. Privacy Policy Changes',
      answer:
          'Because we’re always looking for new and innovative ways to help you build meaningful connections, this policy may change over time. We will notify you before any material changes take effect so that you have time to review the changes.'),
  QuestionsModel(
      question: '10. How to Contact Us',
      answer:
          '''If you have questions about this Privacy Policy, here’s how you can reach us:

Online: asif.attar@caryanam.in

By phone: 7755994123''')
];

final List<QuestionsModel> cookiePolicyList = [
  QuestionsModel(
      question: 'Introduction',
      answer:
          '''CaryanamIndia is committed to protecting your privacy. We aim to provide trustworthy, industry-leading products and services so that you can focus on building meaningful connections. Our approach to privacy is to provide you with clear information about our data practices. That’s why we have tried to keep legal and technical jargon to a minimum.

This Cookie Policy explains what cookies are, what types of cookies are placed on your device when you visit our website and how we use them.

This Cookie Policy does not address how we deal with your personal information generally.'''),
  QuestionsModel(
      question: 'What are cookies?',
      answer:
          '''Cookies are small text files that are sent to or accessed from your web browser or your device’s memory. A cookie typically contains the name of the domain (internet location) from which the cookie originated, the “lifetime” of the cookie (i.e., when it expires) and a randomly generated unique number or similar identifier. A cookie also may contain information about your device, such as user settings, browsing history and activities conducted while using our services.'''),
  QuestionsModel(
      question: 'Are there different types of cookies?',
      answer: '''First-party and third-party cookies

There are first-party cookies and third-party cookies. First-party cookies are placed on your device directly by us. For example, we use first-party cookies to adapt our website to your browser’s language preferences and to better understand your use of our website. Third-party cookies are placed on your device by our partners and service providers. For example, we use third-party cookies to measure user numbers on our website or to enable you to share content with others across social media platforms.

Session and persistent cookies

There are session cookies and persistent cookies. Session cookies only last until you close your browser. We use session cookies for a variety of reasons, including to learn more about your use of our website during one single browser session and to help you to use our website more efficiently. Persistent cookies have a longer lifespan and are not automatically deleted when you close your browser. These types of cookies are primarily used to help you quickly sign-in to our website again and for analytical purposes.'''),
  QuestionsModel(
      question: 'What about other tracking technologies, like web beacons?',
      answer:
          '''Other technologies such as web beacons (also called pixel tags or clear gifs), tracking URLs or software development kits (SDKs) are used for similar purposes. Web beacons are tiny graphics files that contain a unique identifier that enable us to recognize when someone has visited our service or opened an email that we have sent them. Tracking URLs are custom-generated links that help us understand where the traffic to our web pages comes from. SDKs are small pieces of code included in apps, which function like cookies and web beacons.

For simplicity, we also refer to these technologies as “cookies” in this Cookie Policy.'''),
  QuestionsModel(
      question: 'What do we use cookies for?',
      answer:
          '''Like all providers of online services, we use cookies to provide, secure and improve our services, including by remembering your preferences, recognizing you when you visit our website and personalizing and tailoring ads to your interests. To accomplish these purposes, we also may link information from cookies with other personal information we hold about you.

When you visit our website, some or all of the following types of cookies may be set on your device.

Essential website cookies:
These cookies are strictly necessary to provide you with services available through our website and to use some of its features, such as access to secure areas.

Analytics cookies: These cookies help us understand how our website is being used, how effective marketing campaigns are, and help us customize and improve our websites for you.

Advertising cookies:
These cookies are used to make advertising messages more relevant to you. They perform functions like preventing the same ad from continuously reappearing, ensuring that ads are properly displayed for advertisers, selecting advertisements that are based on your interests and measuring the number of ads displayed and their performance, such as how many people clicked on a given ad.

Social networking cookies:
These cookies are used to enable you to share pages and content that you find interesting on our website through third-party social networking and other websites. These cookies may also be used for advertising purposes too.'''),
  QuestionsModel(
      question: 'How can you control cookies?',
      answer:
          '''There are several cookie management options available to you. Please note that changes you make to your cookie preferences may make browsing our website a less satisfying experience. In some cases, you may even find yourself unable to use all or part of our site.'''),
  QuestionsModel(
      question: 'Browser and devices controls',
      answer:
          '''Some web browsers provide settings that allow you to control or reject cookies or to alert you when a cookie is placed on your computer. The procedure for managing cookies is slightly different for each internet browser. You can check the specific steps in your particular browser help menu.

You also may be able to reset device identifiers by activating the appropriate setting on your mobile device. The procedure for managing device identifiers is slightly different for each device. You can check the specific steps in the help or settings menu of your particular device.'''),
  QuestionsModel(
      question: 'Interest-based advertising tools',
      answer:
          '''You can opt out of seeing online interest-based advertising from participating companies through the Digital Advertising Alliance, the Interactive Digital Advertising Alliance or Appchoices (apps only).

Opting out does not mean you will not see advertising - it means you won’t see personalized advertising from the companies that participate in the opt-out programs. Also, if you delete cookies on your device after you opted out, you will need to opt-out again.'''),
  QuestionsModel(
      question: 'Social Cookies',
      answer:
          '''To allow you to share content on social media, some features of this website use social media plug-ins (e.g., Twitter™ “Share to Twitter” or LinkedIn™ “in” buttons or Facebook). Depending on your social media account settings, we automatically receive information from the social media platform when you use the corresponding button on our website.

To learn more about social media cookies, we suggest you refer to your social media platform’s cookie policy and privacy policy.'''),
  QuestionsModel(
      question: 'Adobe Flash Player™ Flash cookies',
      answer:
          '''Adobe Flash Player™ is an application for viewing and interacting with dynamic content using the Flash platform. Flash (and similar applications) use a technology akin to cookies to memorize parameters, preferences and uses of this content. However, Adobe Flash Player manages this information and your choices via an interface separate from that supplied by your browser.

If your terminal is likely to display content developed using the Flash platform, we suggest you access your Flash cookie management tools directly via https://www.adobe.com.

Google™ Cookies

Stuff Google Wants to Make Sure You Know about Google’s Data Collection Technology

Google™ Maps API Cookies

Some features of our website and some CaryanamIndia services rely on the use of Google™ Maps API Cookies. Such cookies will be stored on your device.

When browsing this website and using the services relying on Google™ Maps API cookies, you consent to the storage, collection of such cookies on your device and to the access, usage and sharing by Google of the data collected thereby.

Google™ manages the information and your choices pertaining to Google™ Maps API Cookies via an interface separate from that supplied by your browser. For more information, please see https://www.google.com/policies/technologies/cookies/.'''),
  QuestionsModel(
      question: 'Google Analytics',
      answer:
          '''We use Google Analytics, which is a Google service that uses cookies and other data collection technologies to collect information about your use of the website and services in order to report website trends.

You can opt out of Google Analytics by visiting www.google.com/settings/ads or by downloading the Google Analytics opt-out browser add-on at https://tools.google.com/dlpage/gaoptout.'''),
  QuestionsModel(
      question: 'How to contact us?',
      answer:
          '''If you have questions about this Cookie Policy, here’s how you can reach us:

Online: asif.attar@caryanam.in

By phone: 7755994123''')
];

final List<String> list1 = [
  "Ok",
  "Repainted",
  "Dented",
  "Scratched",
  "Rusted",
  "Repaired",
  "Damaged",
  "Faded"
];
final List<String> list2 = ["Ok", "Replaced", "Damaged"];
final List<String> list3 = [
  "Ok",
  "Scratched",
  "Repaired",
  "Damaged",
];
final List<String> list4 = [
  "Ok",
  "Scratched",
  "Repaired",
  "Damaged",
  "Not Working"
];
final List<String> list5 = [
  "Ok",
  "NotWorking",
  "Damaged",
  "Missing",
  "Mirror Broken/Cracked"
];
final List<String> list7 = [
  "Ok",
  "Repainted",
  "Dented",
  "Scratched",
  "Rusted",
  "Repaired",
  "Damaged",
];
final List<String> list8 = [
  "Repainted",
  "Dented",
  "Scratched",
  "Rusted",
  "Repaired",
  "Damaged",
  "Broken",
  "OneSide"
];
final List<String> list9 = [
  "Ok",
  "Repainted",
  "Dented",
  "Scratched",
  "Rusted",
  "Repaired",
  "Damaged",
  "Faded",
  "Replaced"
];
final List<String> list10 = [
  "Ok",
  "Repainted",
  "Dented",
  "Scratched",
  "Rusted",
  "Repaired",
  "Damaged",
  "Faded",
  "Sealent Broken"
];
final List<String> list11 = ["Ok", "Torn", "Worn Out"];
final List<String> list12 = ["Not Working", "Ok", "Damaged"];
final List<String> list6 = ["ok-69-85%", "Not Ok 22-38%", "Damaged"];

@riverpod
class GetListOfPage extends _$GetListOfPage {
  final List<List<CarVerifyModel>> _listOfPage = [
    [
      CarVerifyModel(
          name: 'Exterior Panel',
          docMatch: 'Exterior',
          carPartList: [
            CarPartModel(
                name: 'Bonnet / Hood', matchKey: 'BonnetHood', options: list1),
            CarPartModel(
                name: 'Right Door Front',
                matchKey: 'RightDoorFront',
                options: list1),
            CarPartModel(
                name: 'Left Door Front',
                matchKey: 'LeftDoorFront',
                options: list1),
            CarPartModel(
                name: 'Right Fender', matchKey: 'RightFender', options: list1),
            CarPartModel(
                name: 'Left Quarter Panel',
                matchKey: 'LeftQuarterPanel',
                options: list1),
            CarPartModel(
                name: 'Right Quarter Panel',
                matchKey: 'RightQuarterPanel',
                options: list1),
            CarPartModel(name: 'Roof', matchKey: 'Roof', options: list1),
            CarPartModel(
                name: 'Dicky Door', matchKey: 'DickyDoor', options: list1),
            CarPartModel(
                name: 'Left Door Rear',
                matchKey: 'LeftDoorRear',
                options: list1),
            CarPartModel(
                name: 'Right Door Rear',
                matchKey: 'RightDoorRear',
                options: list1),
            CarPartModel(
                name: 'Left Fender', matchKey: 'LeftFender', options: list1),
          ]),
      CarVerifyModel(
          name: 'Windshield And Lights',
          docMatch: 'Exterior',
          carPartList: [
            CarPartModel(
                name: 'Windshield', matchKey: 'Windshield', options: list2),
            CarPartModel(
                name: 'Front Windshield',
                matchKey: 'FrontWindshield',
                options: list2),
            CarPartModel(
                name: 'Rear Windshield',
                matchKey: 'RearWindshield',
                options: [...list2, 'Dented']),
            CarPartModel(name: 'Light', matchKey: 'Light', options: list3),
            CarPartModel(
                name: 'Front Bumper', matchKey: 'FrontBumper', options: list1),
            CarPartModel(
                name: 'Rear Bumper', matchKey: 'RearBumper', options: list1),
            CarPartModel(
                name: 'LHS Headlight',
                matchKey: 'LHSHeadlight',
                options: list4),
            CarPartModel(
                name: 'RHS Headlight',
                matchKey: 'RHSHeadlight',
                options: list4),
            CarPartModel(
                name: 'LHS Taillight',
                matchKey: 'LHSTaillight',
                options: list4),
            CarPartModel(
                name: 'RHS Taillight',
                matchKey: 'RHSTaillight',
                options: list4),
            CarPartModel(name: 'LHS ORVM', matchKey: 'LHSORVM', options: list5),
            CarPartModel(name: 'RHS ORVM', matchKey: 'RHSORVM', options: list5),
          ]),
      CarVerifyModel(name: 'Tyres', docMatch: 'Exterior', carPartList: [
        CarPartModel(
            name: 'LHS Front Tyre', matchKey: 'LHSFrontTyre', options: list6),
        CarPartModel(
            name: 'RHS Front Tyre', matchKey: 'RHSFrontTyre', options: list6),
        CarPartModel(
            name: 'LHS Rear Tyre', matchKey: 'LHSRearTyre', options: list6),
        CarPartModel(
            name: 'RHS Rear Tyre', matchKey: 'RHSRearTyre', options: list6),
        CarPartModel(name: 'Spare Tyre', matchKey: 'SpareTyre', options: list6),
      ]),
      CarVerifyModel(
          name: 'Other Components',
          docMatch: 'Exterior',
          carPartList: [
            CarPartModel(
                name: 'Head Light Support',
                matchKey: 'HeadLightSupport',
                options: list7),
            CarPartModel(
                name: 'Radiator Support',
                matchKey: 'RadiatorSupport',
                options: list7),
            CarPartModel(
                name: 'Alloy Wheel', matchKey: 'AlloyWheel', options: list7),
            CarPartModel(
                name: 'CarPoolingon',
                matchKey: 'CarPoolingon',
                options: ["On Side", "NoPooling"]),
            CarPartModel(
                name: 'LHS Running Border',
                matchKey: 'LHSRunningBorder',
                options: list8),
            CarPartModel(
                name: 'RHS Running Border',
                matchKey: 'RHSRunningBorder',
                options: list8),
            CarPartModel(
                name: 'Upper Cross Member',
                matchKey: 'UpperCrossMember',
                options: list8),
          ]),
      CarVerifyModel(name: 'Structure', docMatch: 'Exterior', carPartList: [
        CarPartModel(name: 'Cowl Top', matchKey: 'CowlTop', options: list1),
        CarPartModel(name: 'Boot Floor', matchKey: 'BootFloor', options: list1),
        CarPartModel(
            name: 'Right Apron LEG', matchKey: 'RightApronLEG', options: list9),
        CarPartModel(
            name: 'Left Apron LEG', matchKey: 'LeftApronLEG', options: list9),
        CarPartModel(
            name: 'Right Apron', matchKey: 'RightApron', options: list9),
        CarPartModel(name: 'Left Apron', matchKey: 'LeftApron', options: list9),
        CarPartModel(
            name: 'Left Pillar', matchKey: 'LeftPillar', options: list10),
        CarPartModel(
            name: 'Left Pillar A', matchKey: 'LeftPillarA', options: list10),
        CarPartModel(
            name: 'Left Pillar B', matchKey: 'LeftPillarB', options: list10),
        CarPartModel(
            name: 'Left Pillar C', matchKey: 'LeftPillarC', options: list10),
        CarPartModel(
            name: 'Right Pillar', matchKey: 'RightPillar', options: list10),
        CarPartModel(
            name: 'Right Pillar A', matchKey: 'RightPillarA', options: list10),
        CarPartModel(
            name: 'Right Pillar B', matchKey: 'RightPillarB', options: list10),
        CarPartModel(
            name: 'Right Pillar C', matchKey: 'RightPillarC', options: list10),
      ]),
    ],
    [
      CarVerifyModel(name: 'Interior', docMatch: 'Interior', carPartList: [
        CarPartModel(
            name: 'Leather Seat', matchKey: 'LeatherSeat', options: list11),
        CarPartModel(
            name: 'Odometer',
            matchKey: 'Odometer',
            options: ['Ok', 'Tempered', 'Not Tempered']),
        CarPartModel(
            name: 'Cabin Floor',
            matchKey: 'CabinFloor',
            options: ['Ok', 'Dented', 'Rusted']),
        CarPartModel(name: 'Dashboard', matchKey: 'Dashboard', options: list7),
      ]),
    ],
    [
      CarVerifyModel(name: 'Engine', docMatch: 'Engine', carPartList: [
        CarPartModel(name: 'Engine', matchKey: 'Engine', options: [
          "Ok",
          "Misfiring",
          "Long crack due to weak Compression",
          "Permissible blow- by on idle",
          "Fuel leaking from injector",
          "MIL light glowing",
          "RPM Fluctuating",
          "Over Heating"
        ]),
        CarPartModel(
            name: 'Engine Mounting',
            matchKey: 'EngineMounting',
            options: ["Ok", "Loose", "Tight", "Excess Vibration"]),
        CarPartModel(name: 'Engine Sound', matchKey: 'EngineSound', options: [
          "Ok",
          "Minor sound",
          "No engine sound",
          "Critical sound",
          "No Blow-by"
        ]),
        CarPartModel(name: 'Exhaust Smoke', matchKey: 'Exhaustsmoke', options: [
          "Ok",
          "Black",
          "Blue",
          "Silencer assembly Damaged and Create Noise"
        ]),
        CarPartModel(
            name: 'Gearbox',
            matchKey: 'Gearbox',
            options: ["Ok", "Abnormal Noise", "Oil leakage", "Shifting-Hard"]),
        CarPartModel(
            name: 'Engine Oil',
            matchKey: 'Engineoil',
            options: ["Low Level", "Leakage", "Deteriorated"]),
        CarPartModel(name: 'Battery', matchKey: 'Battery', options: [
          "Ok",
          "Weak",
          "jump",
          'start',
          'Dead',
          'Acid',
          'leakage'
        ]),
        CarPartModel(
            name: 'Coolant',
            matchKey: 'Coolant',
            options: ['Low Level', 'Leakage', 'Deteriorated']),
        CarPartModel(
            name: 'Clutch',
            matchKey: 'Clutch',
            options: ['Ok', 'Slipping', 'Hard', 'Spongy']),
      ]),
    ],
    [
      CarVerifyModel(name: 'AC', docMatch: 'AC', carPartList: [
        CarPartModel(
            name: 'AC Cooling',
            matchKey: 'ACCooling',
            options: ['Ok', 'Ineffective', 'Not Working', 'Misfiring']),
        CarPartModel(
            name: 'Heater',
            matchKey: 'Heater',
            options: ['Ok', 'Ineffective', 'Not Working']),
        CarPartModel(
            name: 'Climate Control AC',
            matchKey: 'ClimateControlAC',
            options: ['Ok', 'Ineffective', 'Not Working', 'Misfiring']),
        CarPartModel(
            name: 'Ac Vent', matchKey: 'AcVent', options: ['Ok', 'Damaged']),
      ]),
    ],
    [
      CarVerifyModel(name: 'Electricals', docMatch: 'Eletrical', carPartList: [
        CarPartModel(
            name: 'Four Power Windows',
            matchKey: 'FourPowerWindows',
            options: list12),
        CarPartModel(
            name: 'Air Bag Features',
            matchKey: 'AirBagFeatures',
            options: list12),
        CarPartModel(
            name: 'Music System', matchKey: 'MusicSystem', options: list12),
        CarPartModel(
            name: 'Sunroof',
            matchKey: 'Sunroof',
            options: ['Not Working', 'NA', 'Damaged']),
        CarPartModel(
            name: 'ABS',
            matchKey: 'ABS',
            options: ['Ok', 'Not Working', 'NA', 'Damaged']),
        CarPartModel(
            name: 'Interior Parking Sensor',
            matchKey: 'InteriorParkingSensor',
            options: list12),
        CarPartModel(
            name: 'Electrical Wiring',
            matchKey: 'Electricalwiring',
            options: list12),
      ]),
    ],
    [
      CarVerifyModel(name: 'Steering', docMatch: 'Steering', carPartList: [
        CarPartModel(
            name: 'Steering',
            matchKey: 'Steering',
            options: ['Ok', 'Abnormal Noise', 'Hard']),
        CarPartModel(name: 'Brake', matchKey: 'Brake', options: [
          'Ok',
          'Noisy',
          'Hard Noise',
          'Not Working',
        ]),
        CarPartModel(
            name: 'Suspension',
            matchKey: 'Suspension',
            options: ['Ok', 'Abnormal Noise', 'Weak', 'Not Working']),
      ]),
    ],
    [
      CarVerifyModel(
          name: 'Important documents',
          docMatch: 'None',
          carPartList: [
            CarPartModel(
                name: 'RC Availability', matchKey: '', options: ['Yes', 'No']),
            CarPartModel(
                name: 'Mismatch in RC',
                matchKey: '',
                options: ['No mismatch', 'mismatch']),
            CarPartModel(
                name: 'RTO NOC Issued', matchKey: '', options: ['Yes', 'No']),
            CarPartModel(name: 'Insurance Type', matchKey: '', options: [
              'Zero Depreciation',
              'Comprehensive',
              '3rd Party',
              'Insurance Expired'
            ]),
            CarPartModel(
                name: 'No Claim Bonus', matchKey: '', options: ['Yes', 'No']),
            CarPartModel(name: 'Loan Status', matchKey: '', options: [
              'Paid/Closed',
              'Unpaid/Pending',
            ]),
            CarPartModel(
                name: 'Under Hypothecation',
                matchKey: '',
                options: ['Yes', 'No']),
            CarPartModel(name: 'Road Tax Paid', matchKey: '', options: [
              'OTT',
              'LTT',
            ]),
            CarPartModel(
                name: 'Partipeshi Request',
                matchKey: '',
                options: ['Yes', 'No']),
            CarPartModel(
                name: 'Duplicate Key', matchKey: '', options: ['Yes', 'No']),
            CarPartModel(
                name: 'Chassis Number Embossing',
                matchKey: '',
                options: [
                  'Ok',
                  'Floor Laminated',
                  'Rusted',
                  'Repunched',
                  'Not Traceable'
                ]),
            CarPartModel(
                name: 'CNG/LPG Fitment in RC',
                matchKey: '',
                options: ['Select', 'No mismatch', 'mismatch'])
          ]),
    ]
  ];
  @override
  List<List<CarVerifyModel>> build() {
    return _listOfPage;
  }

  void reset() {
    state = _listOfPage;
  }
}

@riverpod
List<QuestionsModel> getCookiePolicy(ref) {
  return cookiePolicyList;
}

@riverpod
List<QuestionsModel> getPrivacyPolicy(ref) {
  return privacyPolicyList;
}

@riverpod
List<AboutUsModel> getAboutUsData(ref) {
  return aboutUsList;
}

@riverpod
List<QuestionsModel> getFreqQuestion(ref) {
  return freqAskedQuestionsList;
}
