package com.project.zoopiter.web;

<<<<<<< HEAD
=======
import com.project.zoopiter.domain.entity.PetInfo;
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
import com.project.zoopiter.domain.member.svc.PetInfoSVC;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage/pet")
@RequiredArgsConstructor
public class PetInfoController {
  private final PetInfoSVC petInfoSVC;
// 등록 pet_reg
<<<<<<< HEAD
  // 등록화면
  @GetMapping("/pet_reg")
  public String saveInfo(){
//    PetInfo petInfo = new PetInfo();
//    String save = petInfoSVC.saveInfo(petInfo);
    return "/mypage/mypage_pet_reg";
=======
  // 등록양식
  @GetMapping("/pet_reg")
  public String saveInfo(){
    PetInfo petInfo = new PetInfo();
    String save = petInfoSVC.saveInfo(petInfo);

    return "mypage_pet_reg";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }
  // 등록처리
//  PetInfo saveInfo(PetInfo petInfo);
  @PostMapping("/pet_reg")
  public String save(){
<<<<<<< HEAD
    return "redirect:/mypage/pet/{id}/detail";
=======
    return "redirect:/mypage/pet/{id}/mypage_pet_reg";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }

  // 조회
  @GetMapping("/{id}/detail")
  public String findInfo(){
<<<<<<< HEAD
    return "/mypage/pet_modify";
=======
    return "../static/html/pet_modify";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }

// 수정 pet_modify > 메인으로 이동(보호자정보페이지)
//  int updateInfo (Long PetNum, PetInfo petInfo);
  // 수정양식
  @GetMapping("/{id}/edit")
  public String updateInfo(){
<<<<<<< HEAD
    return "/mypage/pet_modify";
=======
    return "../static/html/pet_modify";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }

  // 수정
  @PostMapping("/{id}/edit")
  public String update(){
<<<<<<< HEAD
    return "redirect:/mypage/pet/{id}/edit";
=======
    return "redirect:/mypage/pet_modify";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }

  // 삭제 > 메인으로 이동(보호자정보페이지)
//  int deleteInfo(Long PetNum);
  @GetMapping("{id}/del")
  public String deleteInfo(){
<<<<<<< HEAD
    return "redirect:/mypage/pet";
=======
    return "redirect:/mypage_main";
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
  }

  // 목록 > ?
//  List<PetInfo> findInfo();
  @GetMapping
  public String findAll(){
    return "/mypage/mypage_main";
  }
}
