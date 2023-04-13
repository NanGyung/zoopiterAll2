package com.project.zoopiter.domain.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UploadFile {
  private Long uploadfileId;      //  UPLOADFILE_ID   NUMBER(10,0) --파일 아이디(내부관리용)
  private String code;            //  CODE   VARCHAR2(11 BYTE) --분류 코드(커뮤니티: F0101, 병원후기: F0102, 회원프로필: F0103)
  private Long rid;               //  RID   NUMBER(10,0) --참조번호 --해당 첨부파일이 첨부된 게시글의 순번
  private String store_filename;  //  STORE_FILENAME   VARCHAR2(50 BYTE) --보관파일명
  private String upload_filename; //  UPLOAD_FILENAME   VARCHAR2(50 BYTE) --업로드파일명
  private String fsize;           //  FSIZE   VARCHAR2(45 BYTE) --파일크기
  private String ftype;           //  FTYPE   VARCHAR2(50 BYTE) --파일유형
  private LocalDateTime cdate;    //  CDATE   TIMESTAMP(6) --작성일
  private LocalDateTime udate;    //  UDATE   TIMESTAMP(6) --수정일
}
