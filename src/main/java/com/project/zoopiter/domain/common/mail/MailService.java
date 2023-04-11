package com.project.zoopiter.domain.common.mail;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MailService {

  private final JavaMailSender mailSender;
  private SimpleMailMessage simpleMessage = new SimpleMailMessage();

  @Value("${spring.mail.username}")
  private String from; // 송신자


  /**
   * 메일전송
   * @param to 수신자
   * @param subject 제목
   * @param body 본문
   */
  public void sendMail(String to, String subject, String body){
    MimeMessage message = mailSender.createMimeMessage();

    try {
      MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
      messageHelper.setSubject(subject); //메일 제목
      messageHelper.setTo(to);					 //메일 수신자
      messageHelper.setFrom(from);			 //메일 발송자
      messageHelper.setText(body,true);  //메일 본문
      mailSender.send(message);					 //메일 발송

    } catch (MessagingException e) {
      e.printStackTrace();
    }
  }

  /**
   * 고정 메세지 보낼경우
   * @param message : 본문
   */
  public void sendSimpleMail(String message) {
    simpleMessage.setText(message);
    mailSender.send(simpleMessage);

  }

}
