import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pdfx/pdfx.dart';
import 'legal_model.dart';
export 'legal_model.dart';

class LegalWidget extends StatefulWidget {
  const LegalWidget({
    super.key,
    String? route,
  }) : this.route = route ?? '';

  final String route;

  static String routeName = 'legal';
  static String routePath = 'legal';

  @override
  State<LegalWidget> createState() => _LegalWidgetState();
}

class _LegalWidgetState extends State<LegalWidget> {
  late LegalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LegalModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'legal'});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('LEGAL_chevron_left_rounded_ICN_ON_TAP');
              logFirebaseEvent('IconButton_navigate_back');
              context.pop();
            },
          ),
          title: Text(
            widget.route == 'EST' ? '服務條款' : '合法的',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (widget.route == 'PP')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Html(
                      data:
                          '<h1>隱私權政策</h1>\n<p>最後更新：2024 年 4 月 1 日</p>\n<p>本隱私權政策描述了我們在您使用服務時收集、使用和揭露您的資訊的政策和程序，並告訴您您的隱私權權利以及法律如何保護您。\n<p>我們使用您的個人資料來提供和改善服務。使用本服務，即表示您同意依照本隱私權政策收集和使用資訊。 </p>\n<h2>解釋與定義</h2>\n<h3>解釋</h3>\n<p>首字母大寫的單字具有以下條件下定義的含義。下列定義無論以單數或複數出現，均具有相同的意義。\n<h3>定義</h3>\n<p>就本隱私權政策而言：</p>\n<ul>\n<li>\n<p><strong>帳戶</strong>是指為您建立的用於存取我們的服務或部分服務的唯一帳戶。\n</li>\n<li>\n<p><strong>關聯公司</strong>是指控制一方、受一方控製或與一方受共同控制的實體，其中"控制"指擁有50%或以上有權選舉董事或其他管理權的股份、股權或其他證券。\n</li>\n<li>\n<p><strong>應用程式</strong>是指本公司提供的軟體程式 JobConnect Zambia。\n</li>\n<li>\n<p><strong>公司</strong>（在本協議中稱為「本公司」、「我們」或「我們的」）是指 Recursive Tech Solutions Limited，Palm Drive Chelston。\n</li>\n<li>\n<p><strong>國家</strong>指的是：尚比亞</p>\n</li>\n<li>\n<p><strong>設備</strong>是指任何可以存取服務的設備，例如電腦、手機或數位平板電腦。\n</li>\n<li>\n<p><strong>個人資料</strong>是與已識別或可識別的個人相關的任何資訊。\n</li>\n<li>\n<p><strong>服務</strong>是指應用程式。\n</li>\n<li>\n<p><strong>服務提供者</strong>是指代表公司處理資料的任何自然人或法人。指公司僱用的為促進服務、代表公司提供服務、執行與服務相關的服務或協助公司分析服務使用情況的第三方公司或個人。\n</li>\n<li>\n<p><strong>使用數據</strong>是指自動收集的數據，無論是透過使用服務產生的，還是來自服務基礎設施本身（例如，頁面存取的持續時間）。\n</li>\n<li>\n<p><strong>您</strong>是指存取或使用服務的個人，或公司，或該個人代表其存取或使用服務的其他法律實體（如適用）。\n</li>\n</ul>\n<h2>收集並使用您的個人資訊</h2>\n<h3>收集的資料類型</h3>\n<h4>個人資料</h4>\n<p>在使用我們的服務時，我們可能會要求您向我們提供某些可用於聯絡或識別您的個人識別資訊。個人識別資訊可能包括但不限於：</p>\n<ul>\n<li>\n<p>電子郵件地址</p>\n</li>\n<li>\n<p>名字和姓氏</p>\n</li>\n<li>\n<p>電話號碼</p>\n</li>\n<li>\n<p>使用資料</p>\n</li>\n</ul>\n<h4>使用資料</h4>\n<p>使用服務時會自動收集使用資料。\n<p>使用資料可能包括您的裝置的網際網路通訊協定位址（例如 IP 位址）、瀏覽器類型、瀏覽器版本、您造訪的我們服務的頁面、您造訪的時間和日期、在這些頁面上花費的時間、唯一裝置識別碼和其他診斷資料等資訊。\n<p>當您透過行動裝置存取服務時，我們可能會自動收集某些訊息，包括但不限於您使用的行動裝置類型、您的行動裝置唯一ID、您的行動裝置的IP位址、您的行動作業系統、您使用的行動網路瀏覽器類型、唯一裝置識別碼和其他診斷資料。\n<p>當您造訪我們的服務或透過行動裝置存取服務時，我們也可能收集您的瀏覽器所傳送的資訊。\n<h4>使用應用程式時收集的資訊</h4>\n<p>在使用我們的應用程式時，為了提供我們的應用程式的功能，我們可能會在您事先許可的情況下收集：</p>\n<ul>\n<li>來自您裝置的相機和照片庫的圖片和其他資訊</li>\n</ul>\n<p>我們使用這些資訊來提供我們的服務的功能，改進和客製化我們的服務。這些資訊可能會上傳至公司的伺服器和/或服務提供者的伺服器，或者可能只是儲存在您的裝置上。\n<p>您可以隨時透過裝置設定啟用或停用對此資訊的存取。\n<h3>使用您的個人資料</h3>\n<p>本公司可能將個人資料用於以下目的：</p>\n<ul>\n<li>\n<p><strong>為了證明',
                      onLinkTap: (url, _, __) => launchURL(url!),
                    ),
                  ),
                if (widget.route == 'TCS')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Html(
                      data:
                          '<h2><strong>Terms and Conditions</strong></h2>\n\n<p>Welcome to JobConnect Zambia!</p>\n\n<p>These terms and conditions outline the rules and regulations for the use of Recursive Tech Solutions\'s Application, located at https://recursivetechsol.com/.</p>\n\n<p>By accessing this application we assume you accept these terms and conditions. Do not continue to use JobConnect Zambia if you do not agree to take all of the terms and conditions stated on this page.</p>\n\n<p>The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: \"Client\", \"You\" and \"Your\" refers to you, the person log on this application and compliant to the Company\'s terms and conditions. \"The Company\", \"Ourselves\", \"We\", \"Our\" and \"Us\", refers to our Company. \"Party\", \"Parties\", or \"Us\", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client\'s needs in respect of provision of the Company\'s stated services, in accordance with and subject to, prevailing law of zm. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.</p>\n\n<h3><strong>Cookies</strong></h3>\n\n<p>We employ the use of cookies. By accessing JobConnect Zambia, you agreed to use cookies in agreement with the Recursive Tech Solutions\'s Privacy Policy. </p>\n\n<p>Most interactive applications use cookies to let us retrieve the user\'s details for each visit. Cookies are used by our application to enable the functionality of certain areas to make it easier for people visiting our application. Some of our affiliate/advertising partners may also use cookies.</p>\n\n<h3><strong>License</strong></h3>\n\n<p>Unless otherwise stated, Recursive Tech Solutions and/or its licensors own the intellectual property rights for all material on JobConnect Zambia. All intellectual property rights are reserved. You may access this from JobConnect Zambia for your own personal use subjected to restrictions set in these terms and conditions.</p>\n\n<p>You must not:</p>\n<ul>\n    <li>Republish material from JobConnect Zambia</li>\n    <li>Sell, rent or sub-license material from JobConnect Zambia</li>\n    <li>Reproduce, duplicate or copy material from JobConnect Zambia</li>\n    <li>Redistribute content from JobConnect Zambia</li>\n</ul>\n\n<p>This Agreement shall begin on the date hereof.</p>\n\n<p>Parts of this application offer an opportunity for users to post and exchange opinions and information in certain areas of the application. Recursive Tech Solutions does not filter, edit, publish or review Comments prior to their presence on the application. Comments do not reflect the views and opinions of Recursive Tech Solutions,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Recursive Tech Solutions shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this application.</p>\n\n<p>Recursive Tech Solutions reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.</p>\n\n<p>You warrant and represent that:</p>\n\n<ul>\n    <li>You are entitled to post the Comments on our application and have all necessary licenses and consents to do so;</li>\n    <li>The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;</li>\n    <li>The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy</li>\n    <li>The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.</li>\n</ul>\n\n<p>You hereby grant Recursive Tech Solutions a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.</p>\n\n<h3><strong>Hyperlinking to our Content</strong></h3>\n\n<p>The following organizations may link to our Application without prior written approval:</p>\n\n<ul>\n    <li>Government agencies;</li>\n    <li>Search engines;</li>\n    <li>News organizations;</li>\n    <li>Online directory distributors may link to our Application in the same manner as they hyperlink to the Applications of other listed businesses; and</li>\n    <li>System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Application.</li>\n</ul>\n\n<p>These organizations may link to our home page, to publications or to other Application information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the',
                      onLinkTap: (url, _, __) => launchURL(url!),
                    ),
                  ),
                if (widget.route == 'EST')
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: PdfViewPinch(
                      controller: PdfControllerPinch(
                        document: PdfDocument.openAsset('assets/pdfs/自僱人士服務協議(2025).pdf'),
                      ),
                      builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                        options: const DefaultBuilderOptions(),
                        documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
                        pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
                        errorBuilder: (_, error) => Center(child: Text(error.toString())),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
