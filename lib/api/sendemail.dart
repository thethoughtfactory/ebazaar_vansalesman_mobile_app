
import 'package:enough_mail/enough_mail.dart';
import 'dart:io';
import 'package:enough_mail/smtp/smtp_exception.dart';



String userName = 'support@ebazaar.ae';
String password = 'Support@2021';
String domain = 'thethoughtfactory.ae';
bool isPopServerSecure = true;
String smtpServerHost = 'mail.$domain';
int smtpServerPort = 587;
//int smtpServerPort = 465;
bool isSmtpServerSecure = false;


Future<void> smtpExample(Requestemailupdate body) async {
  print (".......");
  final client = SmtpClient('thethoughtfactory.ae',isLogEnabled: true);
  print (".......:${client}");

  try {
    await client.connectToServer(smtpServerHost, smtpServerPort,
        isSecure: isSmtpServerSecure);
    try{await client.ehlo();} on HandshakeException catch(e){print(e);}

    print (".......");
    if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
      try{      await client.authenticate(userName, password, AuthMechanism.plain); print ("..............");
      }catch(e){print('SMTP failed with $e');}
      print('plain');
    } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
      await client.authenticate(userName, password, AuthMechanism.login);
      print('login');
    } else {
      return;
    }
    final builder = MessageBuilder.prepareMultipartAlternativeMessage();
    builder.from = [MailAddress('eBazaar.ae', 'support@ebazzar.ae')];
    builder.to = [MailAddress('Your name',body.receiver),MailAddress('Your name', 'banuvijai@gmail.com')];


    // builder.to = [MailAddress('Your Name', 'banuvijai@gmail.com')];
    builder.subject = body.subject;
    builder.addTextPlain(body.message);
    final mimeMessage = builder.buildMimeMessage();
    final sendResponse = await client.sendMessage(mimeMessage);
    print('message sent: ${sendResponse.isOkStatus}');
  } on SmtpException catch (e) {
    print('SMTP failed with $e');
  }
}

class Requestemailupdate{
  String receiver;
  String message;
  String subject;
  Requestemailupdate({this.message, this.receiver, this.subject});
}