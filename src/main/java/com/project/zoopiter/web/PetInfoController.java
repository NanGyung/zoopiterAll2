package com.project.zoopiter.web;

import com.project.zoopiter.domain.member.svc.PetInfoSVC;
import com.project.zoopiter.web.login.SaveInfo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pet")
@RequiredArgsConstructor
public class PetInfoController {
  private final PetInfoSVC petInfoSVC;
// 등록 pet_reg
  // 등록양식
  @GetMapping("/pet_reg")
  public String saveInfo(Model model){
//    PetInfo petInfo = new PetInfo();
//    String save = petInfoSVC.saveInfo(petInfo);
    model.addAttribute("saveInfo", new SaveInfo());
    return "/mypage/mypage_pet_reg";
  }
  // 등록처리
//  PetInfo saveInfo(PetInfo petInfo);
  @PostMapping("/pet_reg")
  public String save(@ModelAttribute SaveInfo saveInfo){
    return "redirect:/mypage/pet/{id}/mypage_pet_reg";
  }

  // 조회
  @GetMapping("/{id}/detail")
  public String findInfo(){
    return "../static/html/pet_modify";
  }

// 수정 pet_modify > 메인으로 이동(보호자정보페이지)
//  int updateInfo (Long PetNum, PetInfo petInfo);
  // 수정양식
  @GetMapping("/{id}/edit")
  public String updateInfo(){
    return "../static/html/pet_modify";
  }

  // 수정
  @PostMapping("/{id}/edit")
  public String update(){
    return "redirect:/mypage/pet_modify";
  }

  // 삭제 > 메인으로 이동(보호자정보페이지)
//  int deleteInfo(Long PetNum);
  @GetMapping("{id}/del")
  public String deleteInfo(){
    return "redirect:/mypage_main";
  }

  // 목록 > ?
//  List<PetInfo> findInfo();
  @GetMapping
  public String findAll(){
    return "/mypage/mypage_main";
  }
}
