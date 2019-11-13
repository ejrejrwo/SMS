package com.boot.finalpro.mypage.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SendEmail {
	
	public SendEmail() {
		// TODO Auto-generated constructor stub
	}
	
	public void senamail(String email, String cernumber) {
	
	  log.info("email, cernumber" + email + cernumber);
		
      String host     = "smtp.naver.com";
      final String user   = "gdw0923@naver.com";
	  final String password  = "THRKW6HEHEJM";
	
	  String to = email;
	  
	  // Get the session object
	  Properties props = new Properties();
	  props.put("mail.smtp.host", host);
	  props.put("mail.smtp.auth", "true");
	
	  /*
	   
	    Session session = Session.getDefaultInstance(props, new Authenticator() {
		  protected PasswordAuthentication getPasswordAuthentication() {
			  return new PasswordAuthentication(user, password);
		  }
	  });
	    
	   */
	  
	  Session session = Session.getInstance(props, new Authenticator() {
		  protected PasswordAuthentication getPasswordAuthentication() {
			  return new PasswordAuthentication(user, password);
		  }
	  });
	
	  // Compose the message
	  try {
		  
		  MimeMessage message = new MimeMessage(session);
		  message.setFrom(new InternetAddress(user));
		  message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		
		  // Subject
		  message.setSubject("[finalProject] 비밀번호 찾기 인증 번호입니다.");
		   
		  // Text
		  message.setText("4자리 숫자를 입력해주세요 : " + cernumber);
		
		  // send the message
		  Transport.send(message);
		  System.out.println("message sent successfully...");
	
	  } catch (MessagingException e) {
		  e.printStackTrace();
	  }
		
	}

}
