package com.project.zoopiter.web;

import com.project.zoopiter.domain.common.mail.MailService;
import com.project.zoopiter.domain.member.svc.MemberSVC;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {

  private final MemberSVC memberSVC;
  private final MailService ms;

  //회원가입약관동의
  @GetMapping("/join")
  public String clauseForm(){
    return "member/member_join";
  }

  //회원가입 양식
  @GetMapping("/add")
  public String joinForm1(){
    return "member/member_signup";
  }

  //회원가입처리
//  @PostMapping("/add")
//  public String join(@Valid @ModelAttribute JoinForm joinForm, BindingResult bindingResult){
//    Member member = new Member();
//    member.setUserId(joinForm.getUserId());
//    member.setUserPw(joinForm.getUserPw());
//    member.setUserNick(joinForm.getUserNick());
//    member.setGubun(joinForm.getGubun());
//    member.setUserEmail(joinForm.getUserEmail());
//
//    memberSVC.save(member);
//    return "member/member_joinSuccess";
//  }

  //병원회원 가입 양식
  @GetMapping("/add2")
  public String joinForm2(){
    return "member/member_signup2";
  }
//
//  @RequestMapping("/findPW")
//  public String findPWForm(@ModelAttribute FindPWForm findPWForm){
//    return "member/member_login";
//  }
//
//  @PostMapping("/")
//  public String findPW(
//      @Valid @ModelAttribute FindPWForm findPWForm,
//      BindingResult bindingResult,
//      HttpServletRequest request,
//      Model model
//  ){
//
//    log.info("findPWForm={}",findPWForm);
//
//    if(bindingResult.hasErrors()){
//      return "/";
//    }
//
//    //1) 입력받은 email, id와 같은 회원 찾기
//    boolean isExist = memberSVC.isExistByEmailAndId(findPWForm.getEmail(),findPWForm.getUserId());
//    if(!isExist){
//      return "/";
//    }
//
//    //2) 인증 번호 생성
//    Random random = new Random();
//    int checkNum = random.nextInt(8888888) + 111111;
//    log.info("checkNum={}",checkNum);
//
//    //3) 인증번호 메일로 발송
//    String subject = "인증번호 전송";
//
//    //로그인 주소
//    StringBuilder url = new StringBuilder();
//    url.append("http://" + request.getServerName());
//    url.append(":" + request.getServerPort());
//    url.append(request.getContextPath());
//    url.append("/login");
//
//    //메일본문내용
//    StringBuilder sb = new StringBuilder();
//    sb.append("<!DOCTYPE html>");
//    sb.append("<html lang='ko'>");
//    sb.append("<head>");
//    sb.append("  <meta charset='UTF-8'>");
//    sb.append("  <meta name='viewport' content='width=device-width, initial-scale=1.0'>");
//    sb.append("  <title>인증번호 발송</title>");
//    sb.append("</head>");
//    sb.append("<body>");
//    sb.append("  <h1>인증번호 확인 메일</h1>");
//    sb.append("  <p>아래 인증번호로 인증해주세요 :)</p>");
//    sb.append("  <p>인증번호 :" + checkNum + "</p>");
//    sb.append("</body>");
//    sb.append("</html>");
//
//    ms.sendMail(findPWForm.getEmail(), subject, sb.toString());
//
//    model.addAttribute("info", "회원 이메일로 인증번호가 발송되었습니다.");
//
//    return "/";
//  }


}
