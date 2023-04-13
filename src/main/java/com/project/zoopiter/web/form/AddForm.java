package com.project.zoopiter.web.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
public class AddForm {
  @NotBlank
  private String bcGubun; //카테고리

  @NotBlank
  private String userNick;  //닉네임

  @NotBlank
  private String bcTitle; //제목

  @NotBlank
  private String bcContent; //본문

  @NotBlank
  private String petType;   //펫태그


  private List<MultipartFile> files;  // 첨부파일
}
