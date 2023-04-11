--���̺� ����
drop table C_BBSC CASCADE CONSTRAINTS;
drop table BBSC CASCADE CONSTRAINTS;
drop table C_BBSH CASCADE CONSTRAINTS;
drop table BBSH CASCADE CONSTRAINTS;
drop table PET_NOTE CASCADE CONSTRAINTS;
drop table PET_INFO CASCADE CONSTRAINTS;
drop table HOSPITAL_INFO CASCADE CONSTRAINTS;
drop table HOSPITAL_DATA CASCADE CONSTRAINTS;
drop table HMEMBER CASCADE CONSTRAINTS;
drop table MEMBER CASCADE CONSTRAINTS;
drop table CODE CASCADE CONSTRAINTS;
drop table UPLOADFILE CASCADE CONSTRAINTS;

--����������
drop sequence C_BBSC_CC_ID_SEQ;
drop sequence BBSC_BBSC_ID_seq;
drop sequence C_BBSH_HC_ID_SEQ;
drop sequence BBSH_BBSH_ID_seq;
drop sequence  PET_NOTE_NOTE_NUM_seq;
drop sequence PET_INFO_PET_NUM_seq;
drop sequence HOSPITAL_INFO_H_NUM_seq;
drop sequence UPLOADFILE_UPLOADFILE_ID_SEQ; 



-------
--�ڵ�
-------
create table code(
    code_id     varchar2(10),       --�ڵ�
    decode      varchar2(30),       --�ڵ��
    discript    clob,               --�ڵ弳��
    pcode_id    varchar2(10),       --�����ڵ�
    useyn       char(1) default 'Y',            --��뿩�� (���:'Y',�̻��:'N')
    cdate       timestamp default systimestamp,         --�����Ͻ�
    udate       timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű
alter table code add Constraint code_code_id_pk primary key (code_id);

--��������
alter table code modify decode constraint code_decode_nn not null;
alter table code modify useyn constraint code_useyn_nn not null;
alter table code add constraint code_useyn_ck check(useyn in ('Y','N'));

--���õ����� of code
insert into code (code_id,decode,pcode_id,useyn) values ('M01','ȸ������',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0101','�Ϲ�','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('H0101','����','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A1','������','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P01','��������',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0101','������','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0102','���� ��','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0103','���� ��','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('P0104','���� �Ϸ�','P01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B01','�Խ���',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0101','�����ı�','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0102','Ŀ�´�Ƽ','B01','Y');
commit;

------------
--���ε� ����
------------
CREATE TABLE UPLOADFILE(
  UPLOADFILE_ID             NUMBER,          --���� ���̵�(���ΰ�����)
  CODE                      varchar2(11),    --�з� �ڵ�(Ŀ�´�Ƽ: F0101, �����ı�: F0102, ȸ��������: F0103)
  RID                       varchar2(10),    --������ȣ --�ش� ÷�������� ÷�ε� �Խñ��� ����
  STORE_FILENAME            varchar2(50),    --�������ϸ�
  UPLOAD_FILENAME           varchar2(50),    --���ε����ϸ�
  FSIZE                     varchar2(45),    --����ũ�� 
  FTYPE                     varchar2(50),    --��������
  CDATE                     timestamp default systimestamp, --�ۼ���
  UDATE                     timestamp default systimestamp  --������
);
--�⺻Ű����
alter table UPLOADFILE add Constraint UPLOADFILE_UPLOADFILE_ID_pk primary key (UPLOADFILE_ID);
--�ܷ�Ű
alter table UPLOADFILE add constraint  UPLOADFILE_CODE_fk
    foreign key(CODE) references CODE(CODE_ID);

--��������
alter table UPLOADFILE modify CODE constraint UPLOADFILE_CODE_nn not null;
alter table UPLOADFILE modify RID constraint UPLOADFILE_RID_nn not null;
alter table UPLOADFILE modify STORE_FILENAME constraint UPLOADFILE_STORE_FILENAME_nn not null;
alter table UPLOADFILE modify UPLOAD_FILENAME constraint UPLOADFILE_UPLOAD_FILENAME_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence UPLOADFILE_UPLOADFILE_ID_SEQ;

--���õ����� of UPLOADFILE
insert into UPLOADFILE (UPLOADFILE_ID, CODE , RID, STORE_FILENAME, UPLOAD_FILENAME, FSIZE,FTYPE)
 values(UPLOADFILE_UPLOADFILE_ID_SEQ.NEXTVAL, 'B0102', '001', 'F0101.png', 'Ŀ�´�Ƽ�̹���÷��1.png','100','image/png');

COMMIT;

--���̺� ���� Ȯ��
DESC UPLOADFILE;

-------
--ȸ��
-------
create table member (
    USER_ID                varchar2(20),   --�α� ���̵�
    USER_PW                varchar2(20),   --�α� ��й�ȣ
    USER_NICK              varchar2(30),   --��Ī
    USER_EMAIL             varchar2(40),  --�̸���
    GUBUN                  varchar2(10) default 'M0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    USER_PHOTO             BLOB,           --����
    USER_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
    USER_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table member add Constraint member_user_id_pk primary key (user_id);
--�ܷ�Ű
alter table member add constraint member_gubun_fk
    foreign key(gubun) references code(code_id);

--��������
alter table member add constraint member_user_email_uk unique (user_email);
alter table member modify user_pw constraint member_user_pw_nn not null;
alter table member modify user_nick constraint member_user_nick_nn not null;
alter table member modify user_email constraint member_user_email_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

desc member;

--���õ����� of MEMBER
insert into member (USER_ID , USER_PW, USER_NICK, USER_EMAIL, GUBUN)
    values('test1', 'test1234', '��Ī1', 'test1@gamil.com', 'M0101');

commit;

-------
--����ȸ��
-------
create table hmember (
    H_ID                   varchar2(20),   --�α� ���̵�
    H_PW                   varchar2(20),   --�α� ��й�ȣ
    H_NAME                 varchar2(52),   --���� ��ȣ��
    H_EMAIL                varchar2(40),   --�̸���
    H_TEL                  varchar2(30),   --���� ����ó
    H_TIME                 clob,           --����ð�
    H_INFO                 varchar2(60),   --���ǽü�����
    H_ADDINFO              varchar2(60),   --������Ÿ����
    H_PLIST                varchar2(40),   --���ᵿ��
    GUBUN                  varchar2(10) default 'H0101',    --ȸ������(����,�Ϲ�) �Ϲ�ȸ�� �����ڵ� M0101, ����ȸ�� �����ڵ� H0101
    H_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
    H_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table hmember add Constraint hmember_h_id_pk primary key (h_id);
--�ܷ�Ű
alter table hmember add constraint hmember_gubun_fk
    foreign key(gubun) references code(code_id);

--��������
alter table hmember add Constraint hmember_h_email unique (h_email);
alter table hmember modify h_pw constraint hmember_h_pw_nn not null;
alter table hmember modify h_email constraint hmember_h_email_nn not null;
alter table hmember modify h_name constraint hmember_h_name_nn not null;

--���� ������ OF HMEMBER
insert into HMEMBER (H_ID , H_PW, H_NAME, H_EMAIL, H_TEL, H_TIME, H_INFO, H_ADDINFO, H_PLIST, GUBUN)
    values(
    'htest1',
    'htest1234',
    '���� ��������',
    'htest1@gamil.com',
    '211-3375',
    '������	���� 9:30~���� 7:00
    ȭ����	���� 9:30~���� 7:00
    ������
    (�ĸ���)
    ���� 9:30~���� 7:00
    �ð��� �޶��� �� ����
    �����	���� 9:30~���� 7:00
    �ݿ���	���� 9:30~���� 7:00
    �����	���� 9:30~���� 4:00
    �Ͽ���	�޹���',
    '����, ���� ���ͳ�, �ݷ����� ����',
    '������, ������ ���� �����Դϴ�!',
    '������, ������',
    'H0101');

--���̺� ���� Ȯ��
desc hmember;
commit;

-------------------
-- �������� ����������
-------------------
CREATE TABLE hospital_data(
   hd_id              NUMBER(4)                         --�������� �����͹�ȣ
  ,hd_code            NUMBER(7)                         --������ġ��ü�ڵ�
  ,hd_manage          VARCHAR2(13)                      --������ȣ
  ,hd_perdate         DATE                              --���㰡����
  ,hd_statuscode      NUMBER(1)                         --�������±����ڵ�
  ,hd_satusname       VARCHAR2(23)                      --�������¸�
  ,hd_detailcode      NUMBER(4)                         --�󼼿��������ڵ�
  ,hd_detailname      VARCHAR2(13)                       --�󼼿������¸�
  ,hd_tel             VARCHAR2(30)                      --��������ȭ
  ,hd_address_general VARCHAR2(200)                      --�����ּ�
  ,hd_address_road    VARCHAR2(200)                     --���θ��ּ�
  ,hd_address_roadnum NUMBER(7)                         --���θ�������ȣ
  ,hd_name            VARCHAR2(52)                      --������
  ,hd_adit_date       VARCHAR2(22)                      --������������
  ,hd_adit_gubun      CHAR(1) DEFAULT 'I'               --�����Ͱ��ű���(���ŵ�: U, ���žȵ�: I)
  ,hd_adit_resdate    VARCHAR2(22)                      --�����Ͱ�������
  ,hd_lng             NUMBER                            --��ǥ(x)
  ,hd_lat             NUMBER                            --��ǥ(y)
);
--�⺻Ű����
alter table hospital_data add Constraint hospital_data_hd_id_pk primary key (hd_id);
--��������
alter table hospital_data modify hd_code constraint hospital_data_hd_code_nn not null;
alter table hospital_data modify hd_manage constraint hospital_data_hd_manage_nn not null;
alter table hospital_data modify hd_perdate constraint hospital_data_hd_perdate_nn not null;
alter table hospital_data modify hd_statuscode constraint hospital_data_hd_statuscode_nn not null;
alter table hospital_data modify hd_satusname constraint hospital_data_hd_satusname_nn not null;
alter table hospital_data modify hd_detailcode constraint hospital_data_hd_detailcode_nn not null;
alter table hospital_data modify hd_detailname constraint hospital_data_hd_detailname_nn not null;
alter table hospital_data modify hd_name constraint hospital_data_hd_name_nn not null;
alter table hospital_data modify hd_adit_date constraint hospital_data_hd_adit_date_nn not null;
alter table hospital_data modify hd_adit_gubun constraint hospital_data_hd_adit_gubun_nn not null;
alter table hospital_data modify hd_adit_resdate constraint hospital_data_hd_adit_resdate_nn not null;
alter table hospital_data modify hd_lng constraint hospital_data_hd_lng_nn not null;
alter table hospital_data modify hd_lat constraint hospital_data_hd_lat_nn not null;

alter table hospital_data add constraint hospital_data_hd_adit_gubun_ck check(hd_adit_gubun in ('U','I'));

--���õ����� of HOSPITAL_DATA : ��������������(���, �λ�).sql ������ ��� insert �ؾ���

--���̺� ���� Ȯ��
desc HOSPITAL_DATA;
commit;



------------
--��������
------------
CREATE TABLE hospital_info(
  H_NUM              NUMBER,         --����
  HD_ID              NUMBER(4),      --�������� �����͹�ȣ
  H_ID               varchar2(20),   --����ȸ�� ���̵�
  H_NAME             varchar2(52),   --���� ��ȣ��
  H_TEL              VARCHAR2(30),   --���� ����ó
  H_PLIST            varchar2(40),   --���ᵿ��
  H_TIME             clob,           --����ð�
  H_INFO             varchar2(60),   --���ǽü�����
  H_ADDINFO          varchar2(60),   --������Ÿ����
  H_IMG              BLOB,           --�����̹���
  H_CREATE_DATE       timestamp default systimestamp,         --�����Ͻ�
  H_UPDATE            timestamp default systimestamp          --�����Ͻ�
);
--�⺻Ű����
alter table HOSPITAL_INFO add Constraint HOSPITAL_INFO_H_NUM_pk primary key (H_NUM);
--�ܷ�Ű
alter table HOSPITAL_INFO add constraint  HOSPITAL_INFO_H_ID_fk
    foreign key(H_ID) references hmember(H_ID);
alter table HOSPITAL_INFO add constraint  HOSPITAL_INFO_HD_ID_fk
    foreign key(HD_ID) references hospital_data(HD_ID);

--��������
alter table HOSPITAL_INFO modify H_ID constraint HOSPITAL_INFO_H_ID_nn not null;
alter table HOSPITAL_INFO modify H_NAME constraint HOSPITAL_INFO_H_NAME_nn not null;
alter table HOSPITAL_INFO modify H_CREATE_DATE constraint HOSPITAL_INFO_H_CREATE_DATE_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence HOSPITAL_INFO_H_NUM_seq;

--------  �Ʒ� ���õ����� ���� ���� hospital_data ���õ����� ���� �����ؾ���!!!!  ----------
--���õ����� of hospital_info
insert into hospital_info (H_NUM , HD_ID, H_ID, H_NAME, H_TEL, H_PLIST, H_TIME, H_INFO, H_ADDINFO)
    values(
    hospital_info_h_num_seq.nextval, 
    5400, 
    'htest1', 
    '���� ��������', 
    '211-3375', 
    '������, ������', 
    '������	���� 9:30~���� 7:00
    ȭ����	���� 9:30~���� 7:00
    ������
    (�ĸ���)
    ���� 9:30~���� 7:00
    �ð��� �޶��� �� ����
    �����	���� 9:30~���� 7:00
    �ݿ���	���� 9:30~���� 7:00
    �����	���� 9:30~���� 4:00
    �Ͽ���	�޹���', 
    '����, ���� ���ͳ�, �ݷ����� ����',
    '������, ������ ���� �����Դϴ�!'
    );


COMMIT;
--���̺� ���� Ȯ��
DESC HOSPITAL_INFO;

------------
--�ݷ����� ����
------------
CREATE TABLE PET_INFO(
  PET_NUM            NUMBER,         --����
  USER_ID            varchar2(20),   --�Ϲ�ȸ�� ���̵�
  PET_IMG            BLOB,           --�ݷ����� ����
  PET_NAME           varchar2(40),   --�ݷ����� �̸�
  PET_TYPE           VARCHAR2(20),   --�ݷ����� ǰ��
  PET_GENDER         CHAR(1) default 'M',   --�ݷ����� ����(��: M, ��: F)
  PET_BIRTH          DATE,           --�ݷ����� ����
  PET_YN             CHAR(1) default 'N',       --�߼�ȭ ����(�Ϸ�: Y, �̿Ϸ�: N)
  PET_DATE           DATE,           --�Ծ���
  PET_VAC            VARCHAR2(15) default 'p0101',   
  --�������� ����(������(P0101), ���� ��(P0102), ���� ��(P0103), ���� �Ϸ�(P0104))
  PET_INFO           VARCHAR2(60)    --��Ÿ����
);
--�⺻Ű����
alter table PET_INFO add Constraint PET_INFO_PET_NUM_pk primary key (PET_NUM);
--�ܷ�Ű
alter table PET_INFO add constraint  PET_INFO_USER_ID_fk
    foreign key(USER_ID) references member(USER_ID);
alter table PET_INFO add constraint  PET_INFO_PET_VAC_fk
    foreign key(PET_VAC) references  code(code_id);

--��������
alter table PET_INFO modify USER_ID constraint PET_INFO_USER_ID_nn not null;
alter table PET_INFO modify PET_NAME constraint PET_INFO_PET_NAME_nn not null;
alter table PET_INFO modify PET_VAC constraint PET_INFO_PET_VAC_nn not null;
alter table PET_INFO modify PET_GENDER constraint PET_INFO_PET_GENDER_nn not null;

alter table PET_INFO add constraint PET_INFO_PET_YN_ck check(PET_YN in ('Y','N'));
alter table PET_INFO add constraint PET_INFO_PET_GENDER_ck check(PET_GENDER in ('M','F'));
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence PET_INFO_PET_NUM_seq;

--���̺� ���� Ȯ��
DESC PET_INFO;

--���õ����� of PET_INFO
insert into PET_INFO (PET_NUM , USER_ID, PET_NAME, PET_TYPE, PET_GENDER, PET_BIRTH, PET_YN, PET_DATE, PET_VAC)
    values(
    PET_INFO_PET_NUM_seq.nextval, 
    'test1', 
    '�ݷ�����1', 
    '������', 
    'F', 
    '2022-01-01', 
    'Y', 
    '2022-03-01', 
    'P0104'
    );

COMMIT;


------------
--�Ƿ��ø
------------
CREATE TABLE PET_NOTE(
  NOTE_NUM            NUMBER,         --����
  USER_ID            varchar2(20),   --�Ϲ�ȸ�� ���̵�
  PET_NAME           varchar2(40),   --�ݷ����� �̸�
  PET_IMG            BLOB,           --�ݷ����� ����
  PET_TYPE           VARCHAR2(20),   --�ݷ����� ǰ��
  PET_GENDER         CHAR(1) default 'M',   --�ݷ����� ����(��: M, ��: F)
  PET_BIRTH          DATE,           --�ݷ����� ����
  PET_YN             CHAR(1),        --�߼�ȭ ����(�Ϸ�: Y, �̿Ϸ�: N)
  PET_INFO           varchar2(60),   --��Ÿ����
  PET_WEIG           number,         --�ݷ����� ������
  PET_H_CHECK        DATE,           --���� �湮��¥
  PET_H_NAME         VARCHAR2(52),   --�湮�� �����̸�
  PET_H_TEACHER       VARCHAR2(10),   --�����ǻ�
  PET_REASON         VARCHAR2(60),  --������������
  PET_STMP           VARCHAR2(60),  --���� ����
  PET_SIGNICE        VARCHAR2(60),  --���ǻ���
  PET_NEXTDATE       DATE,           --���� ������
  PET_VAC            VARCHAR2(15) default 'p0101',   
  --�������� ����(������(P0101), ���� ��(P0102), ���� ��(P0103), ���� �Ϸ�(P0104))
  PET_DATE           VARCHAR2(15),  --�ۼ� ��¥(Ķ���� ���ó�¥)
  PET_EDITDATE       VARCHAR2(15)   --���� ��¥
);
--�⺻Ű����
alter table PET_NOTE add Constraint PET_NOTE_NOTE_NUM_pk primary key (NOTE_NUM);
--�ܷ�Ű
alter table PET_NOTE add constraint  PET_NOTE_USER_ID_fk
    foreign key(USER_ID) references member(USER_ID);
alter table PET_NOTE add constraint  PET_NOTE_PET_VAC_fk
    foreign key(PET_VAC) references  code(code_id);

--��������
alter table PET_NOTE modify USER_ID constraint PET_NOTE_USER_ID_nn not null;
alter table PET_NOTE modify PET_H_CHECK constraint PET_NOTE_PET_H_CHECK_nn not null;
alter table PET_NOTE modify PET_NAME constraint PET_NOTE_PET_NAME_nn not null;
alter table PET_NOTE modify PET_DATE constraint PET_NOTE_PET_DATE_nn not null;
alter table PET_NOTE modify PET_EDITDATE constraint PET_NOTE_PET_EDITDATE_nn not null;
alter table PET_NOTE add constraint PET_NOTE_PET_YN_ck check(PET_YN in ('Y','N'));
alter table PET_NOTE add constraint PET_NOTE_PET_GENDER_ck check(PET_GENDER in ('M','F'));
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence PET_NOTE_NOTE_NUM_seq;

--���õ����� of PET_NOTE 
insert into PET_NOTE (
    NOTE_NUM , USER_ID, PET_NAME, PET_TYPE, PET_GENDER, PET_BIRTH, PET_YN, PET_WEIG, PET_H_CHECK, 
    PET_H_NAME, PET_H_TEACHER, PET_REASON, PET_STMP, PET_SIGNICE,PET_DATE, PET_NEXTDATE, PET_VAC, PET_EDITDATE)
    values(
    PET_NOTE_NOTE_NUM_seq.nextval, 
    'test1', 
    '�ݷ�����1', 
    '������', 
    'F', 
    '2022-01-01', 
    'Y', 
    4,
    '2023-03-02',
    '���� ��������',
    'ȫ�浿',
    '�������',
    '�ȱ�������',
    '���м��븦 �Ű�����',
    '2023-04-01',
    '2023-04-01',
    'P0104',
    '2023-04-03'
    );
COMMIT;
--���̺� ���� Ȯ��
DESC PET_NOTE;

------------
--�Խ���: �����ı�
------------
CREATE TABLE BBSH(
  BBSH_ID            NUMBER,          --�Խñ� ��ȣ(����)
  BH_TITLE           varchar2(150),   --�� ����
  BH_CONTENT         clob,            --�� ����
  PET_TYPE           varchar2(20),    --�ݷ����� ǰ��
  BH_ATTACH          BLOB,            --÷������
  BH_HNAME           VARCHAR2(52),    --�����̸�
  BH_HIT             NUMBER default 0,--��ȸ��
  BH_GUBUN           VARCHAR2(15) default 'B0101',      --�Խ��� ����(�����ı�: B0101, Ŀ�´�Ƽ: B0102)
  USER_NICK          varchar2(30),    --�Ϲ�ȸ�� �г���
  BH_CDATE           timestamp default systimestamp,   --�ۼ���
  BH_UDATE           timestamp default systimestamp    --������ 
);
--�⺻Ű����
alter table BBSH add Constraint BBSH_BBSH_ID_pk primary key (BBSH_ID);
--�ܷ�Ű
alter table BBSH add constraint  BBSH_BH_GUBUN_fk
    foreign key(BH_GUBUN) references  code(code_id);

--��������
alter table BBSH modify BH_TITLE constraint BBSH_BH_TITLE_nn not null;
alter table BBSH modify BH_CONTENT constraint BBSH_BH_CONTENT_nn not null;
alter table BBSH modify USER_NICK constraint BBSH_USER_NICK_nn not null;
alter table BBSH modify BH_HIT constraint BBSH_BH_HIT_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���


--������ ����
create sequence BBSH_BBSH_ID_seq;

--���õ����� of BBSH
insert into BBSH (BBSH_ID , BH_TITLE, BH_CONTENT, PET_TYPE, BH_HNAME, BH_GUBUN, USER_NICK)
    values(BBSH_BBSH_ID_seq.nextval, '�����ı�����1', '�����ı⺻��1', '������', '���� ��������', 'B0101','��Ī1');

COMMIT;

--���̺� ���� Ȯ��
DESC BBSH;

------------
--���: �����ı�
------------
CREATE TABLE C_BBSH(
  HC_ID              NUMBER,          --��� ��ȣ(����)
  BBSH_ID            NUMBER,          --�Խñ� ��ȣ
  HC_CONTENT         varchar2(1500),  --��� ����
  USER_NICK          varchar2(30),    --�Ϲ�ȸ�� �г���
  BH_CDATE           timestamp default systimestamp,   --�ۼ���
  BH_UDATE           timestamp default systimestamp    --������ 
);
--�⺻Ű����
alter table C_BBSH add Constraint C_BBSH_HC_ID_pk primary key (HC_ID);
--�ܷ�Ű
alter table C_BBSH add constraint  C_BBSH_BBSH_ID_fk
    foreign key(BBSH_ID) references BBSH(BBSH_ID);

--��������
alter table C_BBSH modify BBSH_ID constraint C_BBSH_BBSH_ID_nn not null;
alter table C_BBSH modify HC_CONTENT constraint C_BBSH_HC_CONTENT_nn not null;
alter table C_BBSH modify USER_NICK constraint C_BBSH_USER_NICK_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence C_BBSH_HC_ID_SEQ;

--���õ����� of C_BBSH
insert into C_BBSH (HC_ID, BBSH_ID , HC_CONTENT, USER_NICK) values(C_BBSH_HC_ID_SEQ.nextval, 1,'�����ı���1', '��Ī1');

COMMIT;

--���̺� ���� Ȯ��
DESC C_BBSH;

------------
--�Խ���: Ŀ�´�Ƽ
------------
CREATE TABLE BBSC(
  BBSC_ID            NUMBER,              --�Խñ� ��ȣ(����)
  BC_TITLE           varchar2(150),       --�� ����
  BC_CONTENT         clob,                --�� ����
  PET_TYPE           varchar2(20),        --�ݷ����� ǰ��
  BC_ATTACH          BLOB,                --÷������
  BC_HIT             NUMBER  default 0,   --��ȸ��
  BC_LIKE            NUMBER  default 0,   --���ƿ��
  BC_PUBLIC          CHAR(1) default 'N', --�Խñ� ��������(����: Y, �����: N)
  BC_GUBUN           VARCHAR2(15) default 'B0102',      --�Խ��� ����(�����ı�: B0101, Ŀ�´�Ƽ: B0102)
  USER_NICK          varchar2(30),        --�Ϲ�ȸ�� �г���
  BC_CDATE           timestamp default systimestamp,   --�ۼ���
  BC_UDATE           timestamp default systimestamp    --������ 
);
--�⺻Ű����
alter table BBSC add Constraint BBSC_BBSC_ID_pk primary key (BBSC_ID);
--�ܷ�Ű
alter table BBSC add constraint  BBSC_BC_GUBUN_fk
    foreign key(BC_GUBUN) references code(code_id);
    
--��������
alter table BBSC modify BC_TITLE constraint BBSC_BC_TITLE_nn not null;
alter table BBSC modify BC_CONTENT constraint BBSC_BC_CONTENT_nn not null;
alter table BBSC modify BC_HIT constraint BBSC_BC_HIT_nn not null;
alter table BBSC modify BC_LIKE constraint BBSC_BC_LIKE_nn not null;
alter table BBSC modify BC_PUBLIC constraint BBSC_BC_PUBLIC_nn not null;
alter table BBSC modify USER_NICK constraint BBSC_USER_NICK_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence BBSC_BBSC_ID_seq;

--���õ����� of BBSC
insert into BBSC (BBSC_ID , BC_TITLE, BC_CONTENT, PET_TYPE, BC_PUBLIC, BC_GUBUN, USER_NICK)
    values(BBSC_BBSC_ID_seq.nextval, 'Ŀ�´�Ƽ����1', 'Ŀ�´�Ƽ����1', '������', 'N', 'B0102', '��Ī1');

COMMIT;

--���̺� ���� Ȯ��
DESC BBSC;

------------
--���: Ŀ�´�Ƽ
------------
CREATE TABLE C_BBSC(
  CC_ID              NUMBER,          --��� ��ȣ(����)
  BBSC_ID            NUMBER,          --�Խñ� ��ȣ
  CC_CONTENT         varchar2(1500),  --��� ����
  USER_NICK          varchar2(30),    --�Ϲ�ȸ�� �г���
  CC_CDATE           timestamp default systimestamp,   --�ۼ���
  CC_UDATE           timestamp default systimestamp    --������ 
);
--�⺻Ű����
alter table C_BBSC add Constraint C_BBSC_CC_ID_pk primary key (CC_ID);
--�ܷ�Ű
alter table C_BBSC add constraint  C_BBSC_BBSC_ID_fk
    foreign key(BBSC_ID) references BBSC(BBSC_ID);

--��������
alter table C_BBSC modify BBSC_ID constraint C_BBSC_BBSC_ID_nn not null;
alter table C_BBSC modify CC_CONTENT constraint C_BBSC_CC_CONTENT_nn not null;
alter table C_BBSC modify USER_NICK constraint C_BBSC_USER_NICK_nn not null;
-- not null ���������� add ��� modify ���ɹ� ���

--������ ����
create sequence C_BBSC_CC_ID_SEQ;

--���õ����� of C_BBSC
insert into C_BBSC (CC_ID, BBSC_ID , CC_CONTENT, USER_NICK) values(C_BBSC_CC_ID_SEQ.nextval, 1, 'Ŀ�´�Ƽ���1', '��Ī1');

COMMIT;

--���̺� ���� Ȯ��
DESC C_BBSC;