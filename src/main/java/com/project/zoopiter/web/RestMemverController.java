package com.project.zoopiter.web;

import com.project.zoopiter.domain.member.svc.MemberSVC;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController // @Controller + @ResponseBody
@RequiredArgsConstructor
@RequestMapping("/api/members")
public class RestMemverController {

    private final MemberSVC memberSVC;

    //회원닉네임 체크
    @ResponseBody
    @GetMapping("/nickname")
    public RestResponse<Object> isExistNick(@RequestParam("nickname") String nickname){
        log.info("nickname={}",nickname);
        RestResponse<Object> res = null;

        //아이디 검증
        boolean exist = memberSVC.isExistNick(nickname);
        res = RestResponse.createRestResponse("00","성공", exist);

        return res;
    }

    //회원아이디 체크
    @ResponseBody
    @GetMapping("/id")
    public RestResponse<Object> isExistId(@RequestParam("id") String id){
        log.info("id={}",id);
        RestResponse<Object> res = null;

        //아이디 검증
        boolean exist = memberSVC.isExistId(id);
        res = RestResponse.createRestResponse("00","성공", exist);

        return res;
    }

    //회원이메일 체크
    @ResponseBody
    @GetMapping("/email")
    public RestResponse<Object> isExistEmail(@RequestParam("email") String email){
        log.info("email={}",email);
        RestResponse<Object> res = null;

        //아이디 검증
        boolean exist = memberSVC.isExistEmail(email);
        res = RestResponse.createRestResponse("00","성공", exist);

        return res;
    }
}
