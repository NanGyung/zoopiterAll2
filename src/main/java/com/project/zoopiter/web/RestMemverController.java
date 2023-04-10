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
}
