package com.project.zoopiter.web;

import com.project.zoopiter.domain.bbsc.svc.BbscSVC;
import com.project.zoopiter.domain.common.code.Code;
import com.project.zoopiter.domain.common.code.CodeDAO;
import com.project.zoopiter.domain.common.file.svc.UploadFileSVC;
import com.project.zoopiter.domain.entity.Bbsc;
import com.project.zoopiter.web.form.AddForm;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Controller
@RequestMapping("/bbsc")
@RequiredArgsConstructor
public class BbscController {

    private final BbscSVC bbscSvc;
    private final CodeDAO codeDAO;
    private final UploadFileSVC uploadFileSVC;


    //게시판 코드,디코드 가져오기
    @ModelAttribute("classifier")
    public List<Code> classifier(){
        return codeDAO.code("B01");
    }

    //  게시판 타이틀 얻기
    @ModelAttribute("bbsTitle")
    public Map<String,String> bbsTitle(){
        List<Code> codes = codeDAO.code("B01");
        Map<String,String> btitle = new HashMap<>();
        for (Code code : codes) {
            btitle.put(code.getCode(), code.getDecode());
        }
        return btitle;
    }


    //쿼리스트링 카테고리 읽기, 없으면 ""반환
    private String getCategory(Optional<String> category) {
        String cate = category.isPresent()? category.get():"";
        log.info("category={}", cate);
        return cate;
    }

    // 작성 양식
    @GetMapping("/add")
    public String addForm(
        Model model,
        @RequestParam(required = false)Optional<String> category,
        HttpSession session
        )
    {

        String cate = getCategory(category);

        LoginMember loginMember = (LoginMember)session.getAttribute(SessionConst.LOGIN_MEMBER);

        AddForm addForm = new AddForm();
        addForm.setUserNick(loginMember.getUserNick());
        model.addAttribute("addForm",addForm);
        model.addAttribute("category",cate);


        return "community/board_com-add";
    }

    // 작성 처리
    @PostMapping("/add")
    public String addWrite(
        @ModelAttribute AddForm addForm,
        @RequestParam(required = false) Optional<String> category,
        BindingResult bindingResult,
        HttpSession session,
        RedirectAttributes redirectAttributes
    ) throws IOException {
        log.info("addForm={}",addForm);

        if(bindingResult.hasErrors()){
            log.info("add/bindingResult={}",bindingResult);
            return "community/board_com-add";
        }

        String cate = getCategory(category);

        Bbsc bbsc = new Bbsc();
        BeanUtils.copyProperties(addForm, bbsc);

        //세션 가져오기
        LoginMember loginMember = (LoginMember)session.getAttribute(SessionConst.LOGIN_MEMBER);
        //세션 정보가 없으면 로그인페이지로 이동
        if(loginMember == null){
            return "redirect:/login";
        }

        //세션에서 닉네임 가져오기
        bbsc.setUserNick(loginMember.getUserNick());

        //글번호
        Long originId = 0l;
        originId = bbscSvc.saveWrite(bbsc);

        redirectAttributes.addAttribute("id", originId);
        redirectAttributes.addAttribute("category",cate);

//        //파일첨부유무
//        if(addForm.getFiles().size() == 0){
//            originId = bbscSvc.saveWrite(bbsc);
//        }else{
//            originId == bbscSvc.saveWriteFile(bbsc, addForm.getFiles());
//        }




        return "";
    }


    // 커뮤니티 게시판 목록
    @GetMapping("/list")
    public String listForm(){
        return "community/board_com";
    }





}
