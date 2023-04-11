package com.project.zoopiter.web;

<<<<<<< HEAD
import com.project.zoopiter.domain.member.svc.MemberSVC;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
=======
import com.project.zoopiter.domain.entity.Member;
import com.project.zoopiter.domain.member.svc.MemberSVC;
import com.project.zoopiter.web.form.JoinForm;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {

  private final MemberSVC memberSVC;

  //회원가입약관동의
  @GetMapping("/join")
<<<<<<< HEAD
  public String clauseForm(){
=======
  public String clauseForm(Model model){
    model.addAttribute("joinForm",new JoinForm());
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
    return "member/member_join";
  }

  //회원가입 양식
  @GetMapping("/add")
<<<<<<< HEAD
  public String joinForm1(){
=======
  public String joinForm(Model model){
    model.addAttribute("joinForm",new JoinForm());
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
    return "member/member_signup";
  }

  //회원가입처리
<<<<<<< HEAD
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
=======
  @PostMapping("/add")
  public String join(@Valid @ModelAttribute JoinForm joinForm, BindingResult bindingResult){
    Member member = new Member();
    member.setUserId(joinForm.getUserId());
    member.setUserPw(joinForm.getUserPw());
    member.setUserNick(joinForm.getUserNick());
    member.setGubun(joinForm.getGubun());
    member.setUserEmail(joinForm.getUserEmail());

    memberSVC.save(member);
    return "member/member_joinSuccess";
  }

  //병원회원 가입 양식
  @GetMapping("/add2")
  public String joinForm2(Model model){
    model.addAttribute("joinForm",new JoinForm());
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
    return "member/member_signup2";
  }
}
