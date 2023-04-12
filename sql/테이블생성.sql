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
insert into code (code_id,decode,pcode_id,useyn) values ('F01','÷������',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('F0101','Ŀ�´�Ƽ','F01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('F0102','�����ı�','F01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('F0103','ȸ��������','F01','Y');

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
 values(UPLOADFILE_UPLOADFILE_ID_SEQ.NEXTVAL, 'F0101', '001', 'F0101.png', 'Ŀ�´�Ƽ�̹���÷��1.png','100','image/png');

COMMIT;

--���̺� ���� Ȯ��
DESC UPLOADFILE;

-------
--ȸ��
-------
create table member (
    USER_ID                varchar2(20),   --�α� ���̵�
    USER_PW                varchar2(20),   --�α� ��й�ȣ
    USER_NICK              varchar2(60),   --��Ī
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
    H_NAME                 varchar2(60),   --���� ��ȣ��
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
-- �������������� ���� 
--�� 1
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (4558,3370000,'3.37E+17',to_date('2018-12-31', 'YYYY-MM-DD'),2,'�޾�',1,'�޾�','051-862-1188','�λ걤���� ������ ������ 574-21����','�λ걤���� ������ ��������� 18-6 (������)',47544,'�ַθ󵿹�����','2020-03-04 16:58','U','2020-03-06 2:40',388659.1921,188856.4934);
--�� 2
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (4879,3730000,'3.73E+17',to_date('2018-11-05', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �ﵿ�� ���Ḯ 818����','��걤���� ���ֱ� �ﵿ�� �ﵿ�� 751, 2��',44956,'�ﵿ���հ��ິ����ǰ','2020-04-21 16:15','U','2020-04-23 2:40',395577.8315,226753.4671);
--�� 3
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (5400,3690000,'3.69E+17',to_date('2019-03-05', 'YYYY-MM-DD'),1,'����/����',0,'����','211-3375','��걤���� �߱� ���ܵ� 214-1����','��걤���� �߱� ������ 581 (���ܵ�)',44493,'���� ��������','2019-03-05 19:37','I','2019-03-07 2:21',412557.1053,232481.4145);
--�� 4
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (5407,3330000,'3.33E+17',to_date('2019-04-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051-715-2228','�λ걤���� �ؿ�뱸 �쵿 1124-26���� �ؿ�뼾�Ҹ޵�Į����','�λ걤���� �ؿ�뱸 �ؿ��� 369, �ؿ�뼾�Ҹ޵�Į���� (�쵿)',48062,'������ ��������','2019-04-16 7:36','I','2019-04-18 2:20',394690.1278,187760.6973);
--�� 5
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (5415,3300000,'3.30E+17',to_date('2019-04-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-529-2991','�λ걤���� ������ �ȶ��� 299-3����','�λ걤���� ������ ��Ĵ�� 435 (�ȶ���)',47791,'�������յ�������','2019-05-07 14:04','U','2019-05-09 2:40',391745.0539,190618.1055);
--�� 6
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (5434,3310000,'3.31E+17',to_date('2019-05-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-626-5050','�λ걤���� ���� ��ȣ�� 164����','�λ걤���� ���� ��ȣ�� 68, 2�� (��ȣ��)',48523,'W�����ǷἾ��','2019-07-10 10:09','U','2019-07-12 2:40',392358.2446,182741.2944);
--�� 7
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (5462,3380000,'3.38E+17',to_date('2019-04-02', 'YYYY-MM-DD'),1,'����/����',0,'����','051-756-0075','�λ걤���� ������ ���ȵ� 174-5����','�λ걤���� ������ ������ 125, 1�� (���ȵ�)',48299,'�ٴٵ�������','2019-04-02 14:26','I','2019-04-04 2:20',392768.419,185787.102);
--�� 8
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6040,3320000,'3.32E+17',to_date('2019-05-15', 'YYYY-MM-DD'),1,'����/����',0,'����','513619975','�λ걤���� �ϱ� ȭ���� 2275-2���� �뼺����','�λ걤���� �ϱ� ȭ����� 20, �뼺���� 101ȣ (ȭ����)',46527,'��굿������','2019-05-15 9:13','I','2019-05-17 2:20',382914.8557,194677.2367);
--�� 9
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6046,3330000,'3.33E+17',to_date('2019-06-07', 'YYYY-MM-DD'),1,'����/����',0,'����','051-702-5575','�λ걤���� �ؿ�뱸 �µ� 1295-4���� ���̵�����','�λ걤���� �ؿ�뱸 ��õ�� 114, 1�� (�µ�)',48079,'���̾�����������','2019-06-07 11:11','I','2019-06-09 2:21',398045.8303,188344.0893);
--�� 10
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6066,3370000,'3.37E+17',to_date('2019-08-22', 'YYYY-MM-DD'),1,'����/����',0,'����','051-862-8275','�λ걤���� ������ ���굿 1123-22����','�λ걤���� ������ �߾Ӵ�� 1133, 1�� (���굿)',47523,'�������ǷἾ��','2019-09-06 14:10','U','2019-09-08 2:40',389442.3042,189713.7665);
--�� 11
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6076,3290000,'3.29E+17',to_date('2019-09-18', 'YYYY-MM-DD'),1,'����/����',0,'����','051-851-6612,3','�λ걤���� �λ����� ������ 401-11����','�λ걤���� �λ����� ������� 20 (������)',47214,'�Ե������޵��ü���','2020-05-20 9:51','U','2020-05-22 2:40',388296.7178,187645.5045);
--�� 12
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6082,3380000,'3.38E+17',to_date('2019-09-11', 'YYYY-MM-DD'),1,'����/����',0,'����','051-752-6667','�λ걤���� ������ ���ȵ� 118-7���� ȣ��','�λ걤���� ������ ������ 610, ȣ�� 2�� (���ȵ�)',48293,'���̵����ǷἾ��','2019-09-19 10:40','U','2019-09-21 2:40',392541.7262,186591.8417);
--�� 13
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6109,3300000,'3.30E+17',to_date('2022-04-14', 'YYYY-MM-DD'),1,'����/����',0,'����','051-552-5553','�λ걤���� ������ ��õ�� 1434-10','�λ걤���� ������ ��Ĵ��125���� 6(��õ��)',47733,'���굿���ǷἾ��','2023-03-30 16:18','U','2023-04-01 2:40',388853.6162,191635.4637);
--�� 14
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6122,3290000,'3.29E+17',to_date('2012-04-27', 'YYYY-MM-DD'),1,'����/����',0,'����','051-896-7582','�λ걤���� �λ����� ���ߵ� 699 ���߼�Ʈ��������Ʈ','�λ걤���� �λ����� ���߰����� 6, B112ȣ (���ߵ�, ���߼�Ʈ��������Ʈ)',47325,'���ɾ� ��������','2020-10-20 14:43','U','2020-10-22 2:40',384824.6942,185631.7716);
--�� 15
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6123,3290000,'3.29E+17',to_date('2013-02-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-894-5433','�λ걤���� �λ����� ������ 505-6 �Ѽ����󸮽�','�λ걤���� �λ����� ���ߴ�� 754 (������, �Ѽ����󸮽�)',47284,'�̼ҵ�������','2020-10-14 17:59','U','2020-10-16 2:40',387076.9832,186148.6292);
--�� 16
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6124,3290000,'3.29E+17',to_date('2014-04-25', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �λ����� ������ 515-1����','�λ걤���� �λ����� ������66���� 12, 2�� (������)',47287,'���Ƶ�������','2014-07-04 8:57','I','2018-08-31 23:59',387215.3723,186001.5458);
--�� 17
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6125,3290000,'3.29E+17',to_date('2014-12-11', 'YYYY-MM-DD'),1,'����/����',0,'����','051-819-7588','�λ걤���� �λ����� ������ 362-3','�λ걤���� �λ����� ������� 170, B1�� 104ȣ (������)',47306,'��Ÿ��������','2021-04-01 18:09','U','2021-04-03 2:40',388183.0795,185582.6974);
--�� 18
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6126,3290000,'3.29E+17',to_date('2001-07-11', 'YYYY-MM-DD'),1,'����/����',0,'����','518174749','�λ걤���� �λ����� ������ 181-1���� ����������2 104ȣ','�λ걤���� �λ����� ������� 274 (������, ����������2)',47237,'�׸���������','2019-03-06 14:02','U','2019-03-08 2:40',388153.839,186593.5047);
--�� 19
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6127,3290000,'3.29E+17',to_date('2002-03-28', 'YYYY-MM-DD'),1,'����/����',0,'����','818-0251','�λ걤���� �λ����� ��õ�� 1298-114����','�λ걤���� �λ����� ����� 973 (��õ��)',47369,'���㵿������','2019-03-06 13:58','U','2019-03-08 2:40',387270.4939,184486.5043);
--�� 20
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6128,3290000,'3.29E+17',to_date('2003-09-03', 'YYYY-MM-DD'),1,'����/����',0,'����','894-7559','�λ걤���� �λ����� ���ݵ� 186-22����','�λ걤���� �λ����� ���ߴ�� 491 (���ݵ�)',47269,'�������յ�������','2016-12-06 10:28','I','2018-08-31 23:59',384527.589,185689.6138);
--�� 21
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6129,3290000,'3.29E+17',to_date('2016-09-09', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �λ����� ���ߵ� 378-17','�λ걤���� �λ����� ���з� 1, 1,2�� (���ߵ�)',47331,'�硤�ѹ� ���� ������������','2023-02-06 14:12','U','2023-02-08 2:40',385657.4298,185846.0441);
--�� 22
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6130,3290000,'3.29E+17',to_date('2016-11-29', 'YYYY-MM-DD'),1,'����/����',0,'����','051-891-8575','�λ걤���� �λ����� ���ݵ� 198-1 ���ݺ��罺ī��','�λ걤���� �λ����� ���ݿ����� 6 (���ݵ�, ���ݺ��罺ī��)',47269,'������ �����ǷἾ��','2023-03-16 16:46','U','2023-03-18 2:40',384503.5585,185719.3757);
--�� 23
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6131,3290000,'3.29E+17',to_date('2018-03-05', 'YYYY-MM-DD'),1,'����/����',0,'����','518637570','�λ걤���� �λ����� ������ 402-15����','�λ걤���� �λ����� ������� 14, 2�� (������)',47214,'�̺굿������','2019-05-27 9:47','U','2019-05-29 2:40',388307.837,187571.0743);
--�� 24
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6132,3290000,'3.29E+17',to_date('1991-03-20', 'YYYY-MM-DD'),1,'����/����',0,'����','817-4627','�λ걤���� �λ����� ������ 519-16','�λ걤���� �λ����� �߾Ӵ�� 867 (������)',47215,'�λ����յ�������','2022-03-11 18:33','U','2022-03-13 2:40',388229.658,187441.3568);
--�� 25
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6133,3290000,'3.29E+17',to_date('1991-09-30', 'YYYY-MM-DD'),1,'����/����',0,'����','897-7271','�λ걤���� �λ����� �簨�� 430-2����','�λ걤���� �λ����� �簨�� 31-1 (�簨��)',NULL,'�簨��������','2006-05-04 15:53','I','2018-08-31 23:59',385723.1951,186942.4211);
--�� 26
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6134,3290000,'3.29E+17',to_date('1992-08-07', 'YYYY-MM-DD'),1,'����/����',0,'����','865-1782','�λ걤���� �λ����� �ξϵ� 343-86����','�λ걤���� �λ����� ����� 115-1, 1�� (�ξϵ�)',47138,'������������','2019-03-06 16:41','U','2019-03-08 2:40',385983.0378,187138.7365);
--�� 27
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6135,3290000,'3.29E+17',to_date('1994-10-05', 'YYYY-MM-DD'),1,'����/����',0,'����','809-8008','�λ걤���� �λ����� ������ 198-1���� �����ξ����Ʈ','�λ걤���� �λ����� ���Ƿ� 5 (������, �����ξ����Ʈ)',47134,'���ϵ�������','2019-03-06 14:15','U','2019-03-08 2:40',386989.5608,187695.293);
--�� 28
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6136,3290000,'3.29E+17',to_date('1997-08-27', 'YYYY-MM-DD'),1,'����/����',0,'����','896-0075','�λ걤���� �λ����� �ξϵ� 346-15����','�λ걤���� �λ����� ����� 107 (�ξϵ�)',47144,'ȭ�����յ�������','2013-12-27 18:59','I','2018-08-31 23:59',385895.1157,187115.0068);
--�� 29
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6137,3290000,'3.29E+17',to_date('1998-03-26', 'YYYY-MM-DD'),1,'����/����',0,'����','051-802-6637','�λ걤���� �λ����� ������ 584���� 43��6�� �Ű��ݿ�������Ʈ 212�� 1702ȣ','�λ걤���� �λ����� �������298���� 1 (������)',47236,'���λ����յ�������','2015-08-03 9:43','I','2018-08-31 23:59',388131.519,186868.0294);
--�� 30
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6138,3290000,'3.29E+17',to_date('2000-02-12', 'YYYY-MM-DD'),1,'����/����',0,'����','808-0251','�λ걤���� �λ����� ������ 375-15����','�λ걤���� �λ����� ���Ϸ� 155 (������)',47109,'�ְ浿������','2019-03-06 16:35','U','2019-03-08 2:40',386687.952,187580.1977);
--�� 31
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6139,3290000,'3.29E+17',to_date('2007-03-29', 'YYYY-MM-DD'),1,'����/����',0,'����','051-809-8092','�λ걤���� �λ����� ������ 466-19����','�λ걤���� �λ����� ������ 87 (������)',NULL,'���鵿������','2014-05-27 9:42','I','2018-08-31 23:59',387137.7888,186246.3335);
--�� 32
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6140,3290000,'3.29E+17',to_date('2008-01-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-891-7597','�λ걤���� �λ����� �簨�� 351����','�λ걤���� �λ����� ����� 54 (�簨��)',47177,'���嵿������','2017-06-14 10:44','I','2018-08-31 23:59',385375.7191,186974.105);
--�� 33
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6141,3290000,'3.29E+17',to_date('2008-03-28', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �λ����� �簨�� 738-3���� �ƽþƵ������','�λ걤���� �λ����� �簨���� 84, �ƽþƵ������ (�簨��)',47142,'��ġ��������','2019-03-06 13:54','U','2019-03-08 2:40',385544.1799,187289.0732);
--�� 34
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6142,3290000,'3.29E+17',to_date('2008-06-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-805-0975','�λ걤���� �λ����� ������ 273-7����','�λ걤���� �λ����� ���Ϸ� 243-4 (������)',47104,'������������','2019-03-07 10:22','U','2019-03-09 2:40',386485.2482,188439.7318);
--�� 35
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6143,3290000,'3.29E+17',to_date('2011-04-07', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �λ����� ���ݵ� 540-91����','�λ걤���� �λ����� ������ 47 (���ݵ�)',NULL,'�Ű��ݵ�������','2011-04-07 9:36','I','2018-08-31 23:59',384075.6551,185190.6407);
--�� 36
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6144,3290000,'3.29E+17',to_date('2011-08-24', 'YYYY-MM-DD'),1,'����/����',0,'����','518037511','�λ걤���� �λ����� �ξϵ� 93���� �̸�ƮƮ���̴���������','�λ걤���� �λ����� �ùΰ����� 31, �̸�ƮƮ���̴��������� (�ξϵ�)',47192,'���Ͻ�ũ����','2019-03-06 16:49','U','2019-03-08 2:40',386948.9542,186897.0537);
--�� 37
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6407,3700000,'3.70E+17',to_date('2019-11-26', 'YYYY-MM-DD'),1,'����/����',0,'����','529251125','��걤���� ���� ���ŵ� 584-17����','��걤���� ���� ���з� 27 (���ŵ�)',44616,'�̷�Ƶ�������','2019-11-26 15:54','I','2019-11-28 0:23',404499.6276,228871.0183);
--�� 38
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6419,3380000,'3.38E+17',to_date('2019-12-03', 'YYYY-MM-DD'),1,'����/����',0,'����','051-746-7582','�λ걤���� ������ ������ 450-11','�λ걤���� ������ ������ 407-1, 2-3�� (������)',48232,'���ҵ����޵��ü��� ������','2023-01-09 19:26','U','2023-01-11 2:40',392529.9299,187518.1056);
--�� 39
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6443,3330000,'3.33E+17',to_date('2022-03-29', 'YYYY-MM-DD'),1,'����/����',0,'����','051-744-7500','�λ걤���� �ؿ�뱸 �쵿 1459 �۽�Ʈ�μ���','�λ걤���� �ؿ�뱸 �����߾ӷ� 60, 106ȣ (�쵿)',48059,'�ź��� �������� �μ���','2022-04-04 9:14','U','2022-04-06 2:40',393868.6946,188144.7219);
--�� 40
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6449,3290000,'3.29E+17',to_date('2022-02-14', 'YYYY-MM-DD'),1,'����/����',0,'����','051-714-0011','�λ걤���� �λ����� ������ 511-2','�λ걤���� �λ����� ����� 356, 1�� (������)',47207,'���ɾ� �����ǷἾ��','2022-02-15 13:22','I','2022-02-17 0:22',387967.6819,188102.7142);
--�� 41
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6477,3340000,'3.34E+17',to_date('1995-06-14', 'YYYY-MM-DD'),1,'����/����',0,'����','292-3690','�λ걤���� ���ϱ� ������ 472-51����','�λ걤���� ���ϱ� ���Ϸ�142���� 10 (������)',49360,'����������','2017-05-16 9:58','I','2018-08-31 23:59',381739.9946,179100.1466);
--�� 42
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6478,3360000,'3.36E+17',to_date('2004-03-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-901-7434','�λ걤���� ������ ���浿 1833','�λ걤���� ������ ������� 929 (���浿)',46745,'KRA �λ굿������','2023-02-28 12:39','U','2023-03-04 2:40',371094.2857,185672.9879);
--�� 43
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6479,3360000,'3.36E+17',to_date('2012-08-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051)271-8889','�λ걤���� ������ ������ 3239���� ��������Ÿ�� 204','�λ걤���� ������ �������ǽ�Ƽ11�� 74 (������,��������Ÿ�� 204)',NULL,'�������յ�������','2012-08-13 11:51','I','2018-08-31 23:59',373576.0288,177767.8604);
--�� 44
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6480,3360000,'3.36E+17',to_date('2013-06-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-271-7582','�λ걤���� ������ ������ 3238','�λ걤���� ������ �������ǽ�Ƽ11�� 66 (������)',46765,'�������ǽ�Ƽ��������','2020-09-14 14:10','U','2020-09-16 2:40',373495.7945,177766.2244);
--�� 45
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6481,3360000,'3.36E+17',to_date('2013-10-30', 'YYYY-MM-DD'),1,'����/����',0,'����','519017384','�λ걤���� ������ ���浿 1833','�λ걤���� ������ ������� 929 (���浿)',46745,'�����ϵ�������','2023-01-05 17:41','U','2023-01-07 2:40',371094.2857,185672.9879);
--�� 46
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6482,3360000,'3.36E+17',to_date('2016-02-01', 'YYYY-MM-DD'),1,'����/����',0,'����','051-271-8119','�λ걤���� ������ ������ 3239-5','�λ걤���� ������ �������ǽ�Ƽ4�� 69 (������)',46764,'�ؿȵ�������','2020-09-14 14:21','U','2020-09-16 2:40',373568.7516,177628.0327);
--�� 47
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6483,3360000,'3.36E+17',to_date('2016-04-15', 'YYYY-MM-DD'),1,'����/����',0,'����','512914545','�λ걤���� ������ ������ 3442-4','�λ걤���� ������ ��������6�� 234 (������)',46726,'�׿��޵��õ�������','2020-09-14 14:24','U','2020-09-16 2:40',375286.3802,179175.9659);
--�� 48
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6484,3360000,'3.36E+17',to_date('2016-12-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051-204-7588','�λ걤���� ������ ������ 3357-6','�λ걤���� ������ ��������8�� 243 (������)',46726,'������������','2020-09-14 14:26','U','2020-09-16 2:40',374957.7283,179392.3781);
--�� 49
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6485,3360000,'3.36E+17',to_date('2017-09-25', 'YYYY-MM-DD'),1,'����/����',0,'����','519167575','�λ걤���� ������ ������ 3331-7����','�λ걤���� ������ ��������11�� 35, 103�� 105ȣ (������)',46726,'�̷ο������','2019-03-06 13:47','U','2019-03-08 2:40',375206.5906,180094.1179);
--�� 50
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6486,3360000,'3.36E+17',to_date('2018-03-14', 'YYYY-MM-DD'),1,'����/����',0,'����','051-901-7482','�λ걤���� ������ ���浿 1833���� �λ�泲�渶����','�λ걤���� ������ ������� 929, �λ�泲�渶���� (���浿)',46745,'������������','2020-05-26 14:17','U','2020-05-28 2:40',371094.2857,185672.9879);
--�� 51
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6487,3340000,'3.34E+17',to_date('2004-09-23', 'YYYY-MM-DD'),1,'����/����',0,'����','291-4456','�λ걤���� ���ϱ� �ϴܵ� 608-1����','�λ걤���� ���ϱ� �Ͻ��߾ӷ� 296 (�ϴܵ�)',49414,'�ϴܵ�������','2017-05-16 10:00','I','2018-08-31 23:59',378926.782,180039.9103);
--�� 52
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6488,3340000,'3.34E+17',to_date('2005-03-08', 'YYYY-MM-DD'),1,'����/����',0,'����','264-8275','�λ걤���� ���ϱ� �ϴܵ� 617-10����','�λ걤���� ���ϱ� �Ͻ��߾ӷ� 340, 1�� (�ϴܵ�)',49407,'�ϴܿ��Ÿ� �����ǷἾ��','2020-02-28 17:39','U','2020-03-01 2:40',379316.7171,180252.5913);
--�� 53
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6489,3340000,'3.34E+17',to_date('2006-06-20', 'YYYY-MM-DD'),1,'����/����',0,'����','201-0475','�λ걤���� ���ϱ� ������ 262-1����','�λ걤���� ���ϱ� ������� 184 (������)',49338,'�Ѽֵ�������','2013-12-20 13:23','I','2018-08-31 23:59',381944.4684,179879.7156);
--�� 54
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6490,3340000,'3.34E+17',to_date('2006-07-21', 'YYYY-MM-DD'),1,'����/����',0,'����','261-1891','�λ걤���� ���ϱ� �ٴ뵿 1551-39����','�λ걤���� ���ϱ� �ٴ�� 624 (�ٴ뵿)',49503,'����Ʈ��������','2018-05-28 17:20','I','2018-08-31 23:59',379691.4175,174201.2482);
--�� 55
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6491,3340000,'3.34E+17',to_date('2007-02-02', 'YYYY-MM-DD'),1,'����/����',0,'����','266-7582','�λ걤���� ���ϱ� �ٴ뵿 909����','�λ걤���� ���ϱ� �ٴ�� 549 (�ٴ뵿)',49524,'�ٴ뵿������','2017-05-16 10:03','I','2018-08-31 23:59',379768.0509,174910.8576);
--�� 56
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6492,3340000,'3.34E+17',to_date('2008-04-07', 'YYYY-MM-DD'),1,'����/����',0,'����','207-3344','�λ걤���� ���ϱ� ������ 896-17','�λ걤���� ���ϱ� ������� 246-1, 1�� (������)',49341,'������������','2022-08-08 10:57','U','2022-08-10 2:40',381387.2669,179633.5942);
--�� 57
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6493,3400000,'3.40E+17',to_date('2014-10-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-728-0557','�λ걤���� ���屺 ������ ����� 1312-5����','�λ걤���� ���屺 ������ ����� 21',46014,'�� ��������','2014-10-31 8:47','I','2018-08-31 23:59',398018.5917,205092.901);
--�� 58
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6494,3400000,'3.40E+17',to_date('2015-09-01', 'YYYY-MM-DD'),1,'����/����',0,'����','727-7522','�λ걤���� ���屺 ������ ���и� 717-3����','�λ걤���� ���屺 ������ ������ 583',46015,'�ƻ굿���ǷἾ��','2019-01-30 20:18','U','2019-02-01 2:40',397967.1708,204592.4916);
--�� 59
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6495,3400000,'3.40E+17',to_date('2016-05-30', 'YYYY-MM-DD'),1,'����/����',0,'����','051-923-0119','�λ걤���� ���屺 ������ ���и� 713-6���� 202ȣ','�λ걤���� ���屺 ������ ������ 575-3, 2�� 202ȣ (��������Ÿ����)',46015,'�������ѵ�������','2016-05-30 10:53','I','2018-08-31 23:59',397873.6817,204631.5309);
--�� 60
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6496,3400000,'3.40E+17',to_date('2016-08-22', 'YYYY-MM-DD'),1,'����/����',0,'����','051-624-8275','�λ걤���� ���屺 ������ ���θ� 124����','�λ걤���� ���屺 ������ ������ 314',46061,'��˾���������','2016-08-22 16:06','I','2018-08-31 23:59',401451.7659,196278.1034);
--�� 61
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6497,3340000,'3.34E+17',to_date('2008-10-16', 'YYYY-MM-DD'),1,'����/����',0,'����','209-2091','�λ걤���� ���ϱ� �ϴܵ� 1207-1','�λ걤���� ���ϱ� �������� 1240 (�ϴܵ�)',49435,'�λ�߻�����ġ�Ἶ��','2022-04-25 17:34','U','2022-04-27 2:40',377006.9204,180185.0867);
--�� 62
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6498,3250000,'3.25E+17',to_date('1996-06-20', 'YYYY-MM-DD'),1,'����/����',0,'����','246-0473','�λ걤���� �߱� ������5�� 51-7����','�λ걤���� �߱� �ڰ�ġ��47���� 5 (������5��)',48983,'����������','2019-12-03 11:33','U','2019-12-05 2:40',384955.1257,179511.633);
--�� 63
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6499,3250000,'3.25E+17',to_date('1998-01-09', 'YYYY-MM-DD'),1,'����/����',0,'����','241-0103','�λ걤���� �߱� ������5�� 60-0001���� 2��','�λ걤���� �߱� ������ 51, 2�� (������5��)',48983,'������յ�������','2019-03-04 15:11','U','2019-03-06 2:40',385046.215,179539.724);
--�� 64
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6500,3250000,'3.25E+17',to_date('1999-11-01', 'YYYY-MM-DD'),1,'����/����',0,'����','246-7551','�λ걤���� �߱� ������2�� 36-0007���� �� 1����(������4�� 1-2����)','�λ걤���� �߱� ������ 30-1 (������2��)',48954,'�Ǵн���������','2019-03-04 16:13','U','2019-03-06 2:40',385264.539,179559.2188);
--�� 65
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6501,3260000,'3.26E+17',to_date('2001-11-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051-254-2304','�λ걤���� ���� ����ŵ�3�� 490-1����','�λ걤���� ���� ����� 19-1 (����ŵ�3��)',49210,'��ŵ�������','2019-03-06 18:47','U','2019-03-08 2:40',383451.6379,181120.9181);
--�� 66
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6502,3260000,'3.26E+17',to_date('2005-12-08', 'YYYY-MM-DD'),1,'����/����',0,'����','244-5504','�λ걤���� ���� ����ŵ�2�� 368-1����','�λ걤���� ���� ������ 308 (����ŵ�2��)',49217,'�������������','2019-04-12 11:08','U','2019-04-14 2:40',383853.3386,181003.4035);
--�� 67
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6503,3260000,'3.26E+17',to_date('2015-01-12', 'YYYY-MM-DD'),1,'����/����',0,'����','512547744','�λ걤���� ���� �伺��1�� 8-25','�λ걤���� ���� ��ġ������ 257, 1�� (�伺��1��)',49224,'���ڵ�������','2021-07-02 9:41','U','2021-07-04 2:40',384481.3637,179718.936);
--�� 68
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6504,3260000,'3.26E+17',to_date('2018-02-02', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���� ����ŵ�1�� 141-1','�λ걤���� ���� �뿵�� 36 (����ŵ�1��)',49228,'���µ�������','2022-09-22 10:13','U','2022-09-24 2:40',383666.9072,180751.3685);
--�� 69
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6505,3260000,'3.26E+17',to_date('1958-06-01', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���� �伺��1�� 8-43���� 3��4��','�λ걤���� ���� ��ġ������ 253-2 (�伺��1��)',49224,'�߾ӵ�������','2012-02-07 9:13','I','2018-08-31 23:59',384448.8228,179719.3551);
--�� 70
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6506,3260000,'3.26E+17',to_date('1989-06-30', 'YYYY-MM-DD'),1,'����/����',0,'����','051-256-1188','�λ걤���� ���� �伺��5�� 34-3 �ؿ�����1��','�λ걤���� ���� ������ 130 (�伺��5��, �ؿ�����1��)',49246,'��ȣ��������','2022-03-21 17:41','U','2022-03-23 2:40',384325.619,179413.6862);
--�� 71
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6507,3340000,'3.34E+17',to_date('2012-08-21', 'YYYY-MM-DD'),1,'����/����',0,'����','051-205-1017','�λ걤���� ���ϱ� ��õ�� 682���� ��õ����2-1ȣ','�λ걤���� ���ϱ� ��õ�� 32 (��õ��)',49446,'�Ｚ���յ�������','2012-08-21 10:45','I','2018-08-31 23:59',381947.348,178690.0983);
--�� 72
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6508,3340000,'3.34E+17',to_date('2013-07-02', 'YYYY-MM-DD'),1,'����/����',0,'����','291-7900','�λ걤���� ���ϱ� �ϴܵ� 505-8����','�λ걤���� ���ϱ� ������� 511 (�ϴܵ�)',49309,'��µ�������','2017-05-16 10:06','I','2018-08-31 23:59',379149.295,180733.465);
--�� 73
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6509,3340000,'3.34E+17',to_date('2014-12-17', 'YYYY-MM-DD'),1,'����/����',0,'����','051-265-7582','�λ걤���� ���ϱ� �ٴ뵿 37','�λ걤���� ���ϱ� �ټ۷� 36 (�ٴ뵿)',49518,'�����±赿�� ��������','2022-08-18 9:21','U','2022-08-20 2:40',380622.3602,175774.3576);
--�� 74
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6510,3340000,'3.34E+17',to_date('2015-04-27', 'YYYY-MM-DD'),1,'����/����',0,'����','051-204-7576','�λ걤���� ���ϱ� ���� 589-1����','�λ걤���� ���ϱ� �ϽŹ����� 201 (����)',49431,'�ڳ�����������','2019-04-26 17:02','U','2019-04-28 2:40',378500.6006,179507.0594);
--�� 75
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6511,3340000,'3.34E+17',to_date('2017-08-09', 'YYYY-MM-DD'),1,'����/����',0,'����','051-264-7584','�λ걤���� ���ϱ� �帲�� 190-3����','�λ걤���� ���ϱ� �ٴ�� 254 (�帲��)',49466,'���� ��������','2019-04-26 17:00','U','2019-04-28 2:40',380247.0991,177431.5658);
--�� 76
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6512,3400000,'3.40E+17',to_date('1996-06-20', 'YYYY-MM-DD'),1,'����/����',0,'����','721-8075','�λ걤���� ���屺 ������ ��� 35-12','�λ걤���� ���屺 ������ ������288���� 61',NULL,'���嵿������','2021-06-01 9:22','U','2021-06-03 2:40',401742.193,196019.2395);
--�� 77
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6513,3400000,'3.40E+17',to_date('1987-01-14', 'YYYY-MM-DD'),1,'����/����',0,'����','727-0170','�λ걤���� ���屺 ����� ��õ�� 252-13','�λ걤���� ���屺 ����� �ظ��̷� 17-1',46033,'��õ��������','2022-03-28 14:29','U','2022-03-30 2:40',404115.2555,203878.7833);
--�� 78
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6540,3720000,'3.72E+17',to_date('2001-02-12', 'YYYY-MM-DD'),1,'����/����',0,'����','052-295-8875','��걤���� �ϱ� �Ű 898-2','��걤���� �ϱ� �����2�� 3(�Ű)',44225,'�̼ٵ�������','2022-12-28 10:08','U','2022-12-30 2:40',413714.1594,239986.2095);
--�� 79
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6541,3720000,'3.72E+17',to_date('2003-04-11', 'YYYY-MM-DD'),1,'����/����',0,'����','052-287-0348','��걤���� �ϱ� ���嵿 727-4����','��걤���� �ϱ� ����17�� 11 (���嵿)',44250,'��ö ��������','2015-11-11 13:55','I','2018-08-31 23:59',413478.9035,231692.1172);
--�� 80
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6542,3720000,'3.72E+17',to_date('2010-03-31', 'YYYY-MM-DD'),1,'����/����',0,'����','052-281-0906','��걤���� �ϱ� ��ȵ� 357-2����','��걤���� �ϱ� �Ŵ�� 40 (��ȵ�)',NULL,'��ڻ� ��������','2019-05-30 14:20','U','2019-06-01 2:40',412240.795,239129.7878);
--�� 81
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6543,3720000,'3.72E+17',to_date('2011-05-30', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� �ϱ� ��ȵ� 432-249����','��걤���� �ϱ� �Ŵ�� 26 (��ȵ�, Ȩ�÷���)',44209,'���굿������ Ȩ�÷��� �ϱ���','2019-12-30 9:50','U','2020-01-01 2:40',412349.3005,239222.4501);
--�� 82
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6544,3720000,'3.72E+17',to_date('2015-12-14', 'YYYY-MM-DD'),1,'����/����',0,'����','052-265-8275','��걤���� �ϱ� ��õ�� 431-12','��걤���� �ϱ� ȣ��� 365-1 (��õ��)',44221,'ȣ�赿������','2022-05-17 21:30','U','2022-05-19 2:40',412610.6753,239802.4672);
--�� 83
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6545,3720000,'3.72E+17',to_date('2016-04-19', 'YYYY-MM-DD'),1,'����/����',0,'����','052-297-7582','��걤���� �ϱ� ��ȵ� 357����','��걤���� �ϱ� �Ŵ�� 48 (��ȵ�, ��������)',44209,'�����Ѻ���������','2018-05-30 13:50','I','2018-08-31 23:59',412186.1266,239113.3627);
--�� 84
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6546,3720000,'3.72E+17',to_date('2017-03-31', 'YYYY-MM-DD'),1,'����/����',0,'����','052-291-1190','��걤���� �ϱ� �Ű 230 102ȣ','��걤���� �ϱ� �Ű����� 177, 102ȣ (�Ű)',44225,'������ѵ�������','2021-03-26 20:47','U','2021-03-28 2:40',413866.5754,240278.8712);
--�� 85
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6547,3720000,'3.72E+17',to_date('2017-11-03', 'YYYY-MM-DD'),1,'����/����',0,'����','052-288-9191','��걤���� �ϱ� ȭ���� 1463���� ȭ�� �ֿ뿹�� 124�� 113ȣ','��걤���� �ϱ� ȭ���� 11, 124�� 1�� 113ȣ (ȭ����, ȭ�� �ֿ뿹��)',44240,'ȭ��GL��������','2019-03-07 15:41','U','2019-03-09 2:40',414529.3837,235091.8679);
--�� 86
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6548,3690000,'3.69E+17',to_date('1990-03-12', 'YYYY-MM-DD'),1,'����/����',0,'����','297-0979','��걤���� �߱� �м��� 192-1','��걤���� �߱� �м�����13�� 45 (�м���)',44527,'��굿������','2022-07-04 14:42','U','2022-07-06 2:40',411839.8643,230949.0797);
--�� 87
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6549,3690000,'3.69E+17',to_date('2016-07-28', 'YYYY-MM-DD'),1,'����/����',0,'����','286-5050','��걤���� �߱� �ݱ��� 26-6����','��걤���� �߱� ������ 524 (�ݱ���)',44508,'��� ���� �޵��ü���','2016-07-28 15:00','I','2018-08-31 23:59',412098.1465,232133.9937);
--�� 88
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6550,3690000,'3.69E+17',to_date('1996-11-06', 'YYYY-MM-DD'),1,'����/����',0,'����','292-4112','��걤���� �߱� �ݱ��� 106-6����','��걤���� �߱� ������ 163 (�ݱ���)',44513,'����ȣ��������','2020-05-12 9:18','U','2020-05-14 2:40',412104.371,231353.7915);
--�� 89
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6551,3690000,'3.69E+17',to_date('2001-10-20', 'YYYY-MM-DD'),1,'����/����',0,'����','211-0023','��걤���� �߱� ������ 182-8����','��걤���� �߱� �߾ӱ� 75 (������)',44529,'�̹ڻ絿������','2019-03-05 20:48','U','2019-03-07 2:40',410078.1411,230855.5064);
--�� 90
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6552,3690000,'3.69E+17',to_date('2005-05-13', 'YYYY-MM-DD'),1,'����/����',0,'����','281-2294','��걤���� �߱� ��� 475-10����','��걤���� �߱� ����3�� 24, 1�� (���)',44539,'���� ��������','2018-08-02 15:10','I','2018-08-31 23:59',408192.9166,231382.5846);
--�� 91
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6553,3690000,'3.69E+17',to_date('2010-04-01', 'YYYY-MM-DD'),1,'����/����',0,'����','246-3123','��걤���� �߱� ��ȭ�� 37-7����','��걤���� �߱� ȭ���� 13-2 (��ȭ��)',44452,'���Ͱ���������','2012-10-04 16:56','I','2018-08-31 23:59',409263.7899,230795.413);
--�� 92
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6554,3690000,'3.69E+17',to_date('2013-01-22', 'YYYY-MM-DD'),1,'����/����',0,'����','244-4296','��걤���� �߱� �ٿ 552-2���� ��պ��� 1��','��걤���� �߱� �ٿ�� 1 (�ٿ)',44407,'��ŸŬ��󵿹�����','2013-09-10 17:47','I','2018-08-31 23:59',406245.027,230833.0814);
--�� 93
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6555,3690000,'3.69E+17',to_date('2014-03-13', 'YYYY-MM-DD'),1,'����/����',0,'����','281-3567','��걤���� �߱� �л굿 47-15����','��걤���� �߱� �л�� 5 (�л굿)',44520,'���굿������','2019-03-05 20:52','U','2019-03-07 2:40',411155.6383,230934.9092);
--�� 94
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6556,3690000,'3.69E+17',to_date('2014-07-21', 'YYYY-MM-DD'),1,'����/����',0,'����','211-2399','��걤���� �߱� ��ȭ�� 428-2����','��걤���� �߱� ��ȭ�� 160 (��ȭ��)',44457,'��ȭ��������','2020-04-21 9:27','U','2020-04-23 2:40',407880.8398,230529.6116);
--�� 95
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6557,3690000,'3.69E+17',to_date('2015-02-09', 'YYYY-MM-DD'),1,'����/����',0,'����','212-2475','��걤���� �߱� ������ 279-2','��걤���� �߱� ������ 64-1 (������)',44467,'������ ��������','2022-07-04 14:40','U','2022-07-06 2:40',409475.2121,231081.5635);
--�� 96
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6558,3700000,'3.70E+17',to_date('2001-08-16', 'YYYY-MM-DD'),1,'����/����',0,'����','268-8884','��걤���� ���� ������ 576-18','��걤���� ���� ������ 104 (������)',44670,'��Ʋ�굿���Ƿ��','2022-07-13 16:43','U','2022-07-15 2:40',409088.1383,229335.1443);
--�� 97
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6559,3700000,'3.70E+17',to_date('2002-01-16', 'YYYY-MM-DD'),1,'����/����',0,'����','258-2516','��걤���� ���� �޵� 1400-5','��걤���� ���� ���� 94 (�޵�)',44722,'�̽�����������','2021-08-24 15:42','U','2021-08-26 2:40',410157.2089,228556.745);
--�� 98
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6560,3700000,'3.70E+17',to_date('2002-10-25', 'YYYY-MM-DD'),1,'����/����',0,'����','052-223-5575','��걤���� ���� ���ŵ� 461 ����Ÿ��','��걤���� ���� ���з� 164, 102ȣ (���ŵ�, ����Ÿ��)',44611,'������������','2021-02-03 16:03','U','2021-02-05 2:40',405168.7369,230008.7398);
--�� 99
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6561,3700000,'3.70E+17',to_date('2002-11-01', 'YYYY-MM-DD'),1,'����/����',0,'����','257-7582','��걤���� ���� �޵� 589-1����','��걤���� ���� ������ 147-1 (�޵�)',NULL,'�޵���츮��������','2018-10-11 20:37','U','2018-10-11 23:59',410982.9662,229008.7639);
--�� 100
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6562,3700000,'3.70E+17',to_date('2003-01-03', 'YYYY-MM-DD'),1,'����/����',0,'����','247-6656','��걤���� ���� ���ŵ� 855-7���� 2��','��걤���� ���� ���з� 127, 2�� (���ŵ�)',44607,'���� �� ���� ��������','2013-07-30 13:38','I','2018-08-31 23:59',404972.6305,229738.4191);
--�� 101
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6563,3700000,'3.70E+17',to_date('2003-10-21', 'YYYY-MM-DD'),1,'����/����',0,'����','224-8275','��걤���� ���� ���ŵ� 1434-3����','��걤���� ���� �Ϻμ�ȯ���� 40 (���ŵ�)',NULL,'���굿������','2019-03-07 10:42','U','2019-03-09 2:40',405588.4576,230386.8445);
--�� 102
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6564,3700000,'3.70E+17',to_date('2005-01-11', 'YYYY-MM-DD'),1,'����/����',0,'����','267-0025','��걤���� ���� �޵� 1328-3����','��걤���� ���� ������ 234 (�޵�)',44703,'������������','2017-09-27 13:57','I','2018-08-31 23:59',411287.2817,229487.1199);
--�� 103
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6565,3700000,'3.70E+17',to_date('2006-03-10', 'YYYY-MM-DD'),1,'����/����',0,'����','266-0075','��걤���� ���� ���� 249-3','��걤���� ���� ������ 358 (����)',44662,'�������� ��������','2023-02-17 9:20','U','2023-02-19 2:40',407853.3739,228500.5043);
--�� 104
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6566,3700000,'3.70E+17',to_date('2008-08-20', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���� ���� 146-1','��걤���� ���� ������� 94 (����, ��������� ��������)',44660,'��걤���� �߻�����������������','2022-12-08 11:45','U','2022-12-10 2:40',407967.949,228067.9601);
--�� 105
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6567,3700000,'3.70E+17',to_date('2009-02-06', 'YYYY-MM-DD'),1,'����/����',0,'����','247-7975','��걤���� ���� ���ŵ� 228-1','��걤���� ���� �Ϻμ�ȯ���� 23, 1�� (���ŵ�)',44629,'���ｺ �����ǷἾ��','2022-09-23 15:20','U','2022-09-25 2:40',405433.6134,230398.6922);
--�� 106
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6568,3700000,'3.70E+17',to_date('2009-12-31', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���� ��굿 1551-7','��걤���� ���� ȭ�շ� 200(��굿)',44713,'���Ͽ� �����޵��� ����','2022-12-21 9:19','U','2022-12-23 2:40',412126.241,229492.6933);
--�� 107
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6569,3700000,'3.70E+17',to_date('2010-03-22', 'YYYY-MM-DD'),1,'����/����',0,'����','277-0075','��걤���� ���� ���ŵ� 617-3����','��걤���� ���� ���з� 112 (���ŵ�)',NULL,'�����ϵ�������','2018-06-13 13:21','I','2018-08-31 23:59',404963.1337,229569.098);
--�� 108
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6570,3700000,'3.70E+17',to_date('2014-08-05', 'YYYY-MM-DD'),1,'����/����',0,'����','227-8275','��걤���� ���� ������ 789-91����','��걤���� ���� ���Ϸ� 148, 3�� (������, Ȩ�÷���)',44750,'���굿������','2014-08-05 13:51','I','2018-08-31 23:59',410624.9593,227668.0416);
--�� 109
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6571,3710000,'3.71E+17',to_date('1995-05-25', 'YYYY-MM-DD'),1,'����/����',0,'����','052)252-5878','��걤���� ���� �ϻ굿 574-33���� 1��3��','��걤���� ���� �������ȯ���� 645 (�ϻ굿)',44067,'�ϻ굿���ǷἾ��','2013-09-09 20:42','I','2018-08-31 23:59',420250.4306,224904.3804);
--�� 110
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6572,3710000,'3.71E+17',to_date('2006-03-29', 'YYYY-MM-DD'),1,'����/����',0,'����','052)235-7585','��걤���� ���� �� 73-1����','��걤���� ���� �������ȯ���� 548 (��)',44059,'����� �ູ�� ��������','2014-04-25 19:55','I','2018-08-31 23:59',420112.4351,223926.9659);
--�� 111
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6573,3710000,'3.71E+17',to_date('2014-07-03', 'YYYY-MM-DD'),1,'����/����',0,'����','052-234-7576','��걤���� ���� �ϻ굿 948-3','��걤���� ���� �ϻ���6�� 22, 1�� (�ϻ굿)',44056,'�մ��� ��������','2021-05-20 15:28','U','2021-05-22 2:40',420448.6761,224749.8753);
--�� 112
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6574,3710000,'3.71E+17',to_date('2017-01-01', 'YYYY-MM-DD'),1,'����/����',0,'����','052-232-3567','��걤���� ���� �ϻ굿 577-1����','��걤���� ���� �������ȯ���� 637 (�ϻ굿, Ȩ�÷���)',44068,'���굿������ ������','2019-03-06 13:31','U','2019-03-08 2:40',420194.5062,224850.3237);
--�� 113
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6575,3700000,'3.70E+17',to_date('2011-01-21', 'YYYY-MM-DD'),1,'����/����',0,'����','273-0975','��걤���� ���� ��굿 1646 �̸�Ʈ����� 3��','��걤���� ���� ���߷� 48 (��굿,�̸�Ʈ����� 3��)',NULL,'���Ͽ콺 ��������','2022-05-06 17:06','U','2022-05-08 2:40',412914.803,229015.4301);
--�� 114
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6576,3700000,'3.70E+17',to_date('2012-08-20', 'YYYY-MM-DD'),1,'����/����',0,'����','052-977-2405','��걤���� ���� ��굿 1472-2','��걤���� ���� ������ 273 (��굿)',44700,'����������','2021-07-29 9:46','U','2021-07-31 2:40',411652.8987,229681.5898);
--�� 115
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6577,3700000,'3.70E+17',to_date('2013-11-04', 'YYYY-MM-DD'),1,'����/����',0,'����','268-3567','��걤���� ���� �޵� 830-1����','��걤���� ���� ���� 74, 2�� (�޵�, �Ե���Ʈ�����)',44722,'�����굿������(�Ե���Ʈ �����)','2017-11-07 8:32','I','2018-08-31 23:59',409970.3908,228450.8647);
--�� 116
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6578,3700000,'3.70E+17',to_date('2014-10-02', 'YYYY-MM-DD'),1,'����/����',0,'����','707-2475','��걤���� ���� �޵� 116-2','��걤���� ���� ���� 160 (�޵�)',44726,'��꿡�������޵��ü���','2022-09-26 16:17','U','2022-09-28 2:40',410788.7871,228788.4905);
--�� 117
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6579,3700000,'3.70E+17',to_date('2015-07-31', 'YYYY-MM-DD'),1,'����/����',0,'����','529038275','��걤���� ���� ��굿 180-33����','��걤���� ���� ������ 385-1 (��굿)',44710,'�ֵ�������','2019-03-19 15:10','U','2019-03-21 2:40',412785.7908,229635.9396);
--�� 118
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6580,3700000,'3.70E+17',to_date('2016-08-09', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���� �޵� 634-13����','��걤���� ���� ������ 85-2 (�޵�)',44692,'��굿��������','2016-08-09 22:18','I','2018-08-31 23:59',410363.8465,229090.8909);
--�� 119
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6581,3700000,'3.70E+17',to_date('2017-04-27', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���� ������ 479-7����','��걤���� ���� �߾ӷ� 282 (������)',44679,'�ǿ�����������','2017-05-22 20:17','I','2018-08-31 23:59',409428.3321,229802.1849);
--�� 120
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6582,3700000,'3.70E+17',to_date('2002-03-22', 'YYYY-MM-DD'),1,'����/����',0,'����','273-0075','��걤���� ���� ������ 657-1����','��걤���� ���� �߾ӷ� 165-1 (������)',NULL,'�����������','2018-07-09 14:55','I','2018-08-31 23:59',409752.1229,228695.3504);
--�� 121
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6583,3700000,'3.70E+17',to_date('1997-08-12', 'YYYY-MM-DD'),1,'����/����',0,'����','257-3669','��걤���� ���� ������ 694-19����','��걤���� ���� ���Ϸ�149���� 2 (������)',NULL,'���뵿������','2018-10-03 18:07','U','2018-10-05 2:35',410680.3187,227762.7849);
--�� 122
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6584,3700000,'3.70E+17',to_date('2000-12-19', 'YYYY-MM-DD'),1,'����/����',0,'����','258-2520','��걤���� ���� ������ 1873 ������ڿ�����ũ������ 207ȣ','��걤���� ���� ������� 241, 207ȣ (������, ������ڿ�����ũ������)',44667,'����� ��������','2020-12-06 10:49','U','2020-12-08 2:40',409204.4716,228147.844);
--�� 123
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6585,3700000,'3.70E+17',to_date('2001-08-01', 'YYYY-MM-DD'),1,'����/����',0,'����','273-5911','��걤���� ���� ������ 186-9����','��걤���� ���� �߾ӷ� 218-1 (������)',NULL,'�̷��� ��������','2018-10-16 21:13','U','2018-10-18 2:35',409633.2012,229202.7551);
--�� 124
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6776,3300000,'3.30E+17',to_date('2019-12-26', 'YYYY-MM-DD'),1,'����/����',0,'����','051-506-8492,8493','�λ걤���� ������ ������ 100-2����','�λ걤���� ������ �ƽþƵ��� 131-1, 2�� (������)',47875,'����ȭ�����ǷἾ��','2019-12-26 11:30','I','2019-12-28 0:23',388055.2241,190505.5547);
--�� 125
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6788,3330000,'3.33E+17',to_date('2020-05-01', 'YYYY-MM-DD'),1,'����/����',0,'����','051-710-1766','�λ걤���� �ؿ�뱸 ������ 311-22','�λ걤���� �ؿ�뱸 ���������� 22, 1�� (������)',48073,'�عе�������','2021-06-03 11:01','U','2021-06-05 2:40',400139.14,188900.8272);
--�� 126
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6801,3350000,'3.35E+17',to_date('2020-03-10', 'YYYY-MM-DD'),1,'����/����',0,'����','051-583-7575','�λ걤���� ������ �ΰ 889-7','�λ걤���� ������ �ΰ�� 3, 1~2�� (�ΰ)',46311,'����ġ�����޵��ü���','2020-08-19 16:39','U','2020-08-21 2:40',389902.9114,192926.6937);
--�� 127
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6824,3290000,'3.29E+17',to_date('2020-03-11', 'YYYY-MM-DD'),1,'����/����',0,'����','051-894-1202','�λ걤���� �λ����� ���ߵ� 143-48����','�λ걤���� �λ����� ���ߴ�� 517, �������� (���ߵ�)',47270,'���� ��������','2020-03-13 11:07','U','2020-03-15 2:40',384774.7988,185717.1296);
--�� 128
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6855,3370000,'3.37E+17',to_date('2021-12-28', 'YYYY-MM-DD'),1,'����/����',0,'����','051-711-8253','�λ걤���� ������ ���굿 702-10 �������','�λ걤���� ������ �߾Ӵ�� 1084, ������� 1~3�� (���굿)',47596,'24�� ���ҵ����޵��ü��� ������','2023-01-09 11:54','U','2023-01-11 2:40',389473.2815,189228.0611);
--�� 129
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6859,3400000,'3.40E+17',to_date('2022-01-26', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���屺 ������ ��� 162-18','�λ걤���� ���屺 ������ ��û�� 8, 1��',46074,'����������������','2022-01-26 9:57','I','2022-01-28 0:22',401207.2277,195404.0672);
--�� 130
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6870,3700000,'3.70E+17',to_date('2021-12-23', 'YYYY-MM-DD'),1,'����/����',0,'����','052-281-3567','��걤���� ���� ��굿 1550-12','��걤���� ���� ȭ�շ� 197, 1�� (��굿)',44705,'�Ƴʽ� ��������','2021-12-23 11:26','I','2021-12-25 0:22',412066.5328,229485.2464);
--�� 131
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6932,3350000,'3.35E+17',to_date('1991-10-09', 'YYYY-MM-DD'),1,'����/����',0,'����','515-7450','�λ걤���� ������ �ΰ 255-4 �ູ�Ѻ���','�λ걤���� ������ �ΰ�� 184, �ູ�Ѻ��� 1,2�� (�ΰ)',46269,'������ ���� �Ȱ� ġ������','2022-06-08 17:56','U','2022-06-10 2:40',390375.2841,194559.5706);
--�� 132
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6933,3350000,'3.35E+17',to_date('1994-07-05', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ �ΰ 324-13','�λ걤���� ������ �ΰ�� 86 (�ΰ)',46305,'�ΰ������','2022-09-15 10:33','U','2022-09-17 2:40',390329.9188,193585.2349);
--�� 133
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6934,3350000,'3.35E+17',to_date('2011-10-11', 'YYYY-MM-DD'),1,'����/����',0,'����','515-5179','�λ걤���� ������ ������ 615-6','�λ걤���� ������ �Ĺ����� 38, �������� 2�� (������)',46297,'�ݺ������ǷἾ��','2022-07-25 17:34','U','2022-07-27 2:40',389697.6318,193741.7614);
--�� 134
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6935,3350000,'3.35E+17',to_date('1997-09-23', 'YYYY-MM-DD'),1,'����/����',0,'����','531-2852','�λ걤���� ������ ���� 208-26����','�λ걤���� ������ ������ 200 (����)',46328,'�ѵ���������','2019-03-06 15:12','U','2019-03-08 2:40',391881.9503,192564.799);
--�� 135
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6936,3350000,'3.35E+17',to_date('1999-01-29', 'YYYY-MM-DD'),1,'����/����',0,'����','582-9335','�λ걤���� ������ ������ 219-6����','�λ걤���� ������ �ݰ��� 340 (������)',46283,'�����յ�������','2019-11-04 10:05','U','2019-11-06 2:40',389869.602,195239.2125);
--�� 136
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6937,3350000,'3.35E+17',to_date('2000-06-14', 'YYYY-MM-DD'),1,'����/����',0,'����','517-8275','�λ걤���� ������ ���굿 321-12���� B�� 202ȣ','�λ걤���� ������ �ݰ��� 703-3 (���굿)',46221,'���굿������','2019-11-04 10:14','U','2019-11-06 2:40',390000.7229,198773.9895);
--�� 137
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6938,3350000,'3.35E+17',to_date('2001-06-09', 'YYYY-MM-DD'),1,'����/����',0,'����','582-8701','�λ걤���� ������ ������ 839-1���� 101�� 303ȣ','�λ걤���� ������ �ݰ��� 578 (������)',46229,'���̽����յ�������','2013-04-16 16:11','I','2018-08-31 23:59',389935.9516,197530.2749);
--�� 138
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6939,3350000,'3.35E+17',to_date('2005-08-19', 'YYYY-MM-DD'),1,'����/����',0,'����','512-1661','�λ걤���� ������ ������ 258-22����','�λ걤���� ������ �ݰ��� 454 (������)',46243,'������������','2019-11-04 10:16','U','2019-11-06 2:40',390042.8788,196306.4151);
--�� 139
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6940,3350000,'3.35E+17',to_date('2013-01-04', 'YYYY-MM-DD'),1,'����/����',0,'����','516-7585','�λ걤���� ������ ������ 629-11','�λ걤���� ������ �ݰ��� 206-3 (������)',46297,'����������','2021-11-09 9:18','U','2021-11-11 2:40',389575.4796,193936.9299);
--�� 140
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6941,3350000,'3.35E+17',to_date('2014-08-25', 'YYYY-MM-DD'),1,'����/����',0,'����','714-0209','�λ걤���� ������ �ΰ 224-1','�λ걤���� ������ ������ 25 (�ΰ)',46276,'�������� ��å','2023-03-23 9:33','U','2023-03-25 2:40',390130.9936,195312.2119);
--�� 141
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6942,3350000,'3.35E+17',to_date('2015-03-06', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ������ 742-48����','�λ걤���� ������ �ݰ��� 539 (������)',46231,'�帲��������','2019-03-27 14:32','U','2019-03-29 2:40',389916.8462,197132.4076);
--�� 142
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6943,3350000,'3.35E+17',to_date('2015-04-17', 'YYYY-MM-DD'),1,'����/����',0,'����','525-7810','�λ걤���� ������ ���� 204-12','�λ걤���� ������ ������175���� 11, 2�� (����)',46321,'���� �����޵��ü���','2021-08-02 10:21','U','2021-08-04 2:40',391719.8534,192660.6626);
--�� 143
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6944,3350000,'3.35E+17',to_date('2015-04-27', 'YYYY-MM-DD'),1,'����/����',0,'����','516-1175','�λ걤���� ������ �ΰ 24-6','�λ걤���� ������ �߾Ӵ�� 1754 (�ΰ)',46253,'����2�������޵��ü���','2023-01-11 9:31','U','2023-01-13 2:40',390473.3881,195515.8363);
--�� 144
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6945,3350000,'3.35E+17',to_date('2015-04-27', 'YYYY-MM-DD'),1,'����/����',0,'����','516-1175','�λ걤���� ������ �ΰ 24-6','�λ걤���� ������ �߾Ӵ�� 1754 (�ΰ)',46253,'���ϵ������ܿ�����','2023-01-11 9:26','U','2023-01-13 2:40',390473.3881,195515.8363);
--�� 145
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6946,3350000,'3.35E+17',to_date('2015-08-28', 'YYYY-MM-DD'),1,'����/����',0,'����','518-1360','�λ걤���� ������ ������ 319-6����','�λ걤���� ������ �߾Ӵ��1841���� 24 (������, E��Ʈ������)',46233,'���굿������ �̸�Ʈ������','2019-05-03 10:10','U','2019-05-05 2:40',390161.6934,196690.2227);
--�� 146
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6947,3340000,'3.34E+17',to_date('2003-03-26', 'YYYY-MM-DD'),1,'����/����',0,'����','292-0141','�λ걤���� ���ϱ� ������ 550-1����','�λ걤���� ���ϱ� ������� 295-1 (������)',604-812,'������ ��������','2017-05-16 9:59','I','2018-08-31 23:59',380902.6085,179597.7326);
--�� 147
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6948,3340000,'3.34E+17',to_date('2004-09-15', 'YYYY-MM-DD'),1,'����/����',0,'����','262-7582','�λ걤���� ���ϱ� �ٴ뵿 935-11����','�λ걤���� ���ϱ� �����ܷ�56���� 55 (�ٴ뵿)',49493,'�� ��������','2019-04-26 17:16','U','2019-04-28 2:40',379663.3476,175088.2304);
--�� 148
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6949,3340000,'3.34E+17',to_date('1992-04-30', 'YYYY-MM-DD'),1,'����/����',0,'����','051-206-1891','�λ걤���� ���ϱ� �縮�� 373-4','�λ걤���� ���ϱ� ������� 356 (�縮��)',49345,'���ϵ����Ƿ��','2022-07-04 11:44','U','2022-07-06 2:40',380363.7722,179842.5875);
--�� 149
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6950,3340000,'3.34E+17',to_date('1992-08-28', 'YYYY-MM-DD'),1,'����/����',0,'����','202-7002','�λ걤���� ���ϱ� �縮�� 325-1����','�λ걤���� ���ϱ� ������� 407 (�縮��)',49411,'�� ��������','2020-04-09 19:10','U','2020-04-11 2:40',379877.2213,180029.7204);
--�� 150
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6951,3320000,'3.32E+17',to_date('1991-01-17', 'YYYY-MM-DD'),1,'����/����',0,'����','332-8060','�λ걤���� �ϱ� ��õ�� 375-5','�λ걤���� �ϱ� ������� 119 (��õ��)',46554,'��õ�����ǷἾ��','2022-07-28 10:36','U','2022-07-30 2:40',383674.2857,192327.6662);
--�� 151
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6952,3390000,'3.39E+17',to_date('1989-11-23', 'YYYY-MM-DD'),1,'����/����',0,'����','322-3026','�λ걤���� ��� ������ 555-26����','�λ걤���� ��� ���� 153 (������)',46974,'��󵿹�����','2011-10-30 14:32','I','2018-08-31 23:59',380983.7697,186277.2017);
--�� 152
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6953,3390000,'3.39E+17',to_date('1991-10-16', 'YYYY-MM-DD'),1,'����/����',0,'����','313-2559','�λ걤���� ��� �ַʵ� 1162-3����','�λ걤���� ��� ���ߴ�� 258 (�ַʵ�)',47012,'�ַʵ�������','2011-10-30 14:33','I','2018-08-31 23:59',382265.7392,185261.7392);
--�� 153
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6954,3390000,'3.39E+17',to_date('1996-03-20', 'YYYY-MM-DD'),1,'����/����',0,'����','304-6455','�λ걤���� ��� ������ 429-13����','�λ걤���� ��� ���� 261 (������)',46955,'�ź��嵿������','2014-01-28 17:44','I','2018-08-31 23:59',380490.0777,187240.8032);
--�� 154
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6955,3390000,'3.39E+17',to_date('1996-03-11', 'YYYY-MM-DD'),1,'����/����',0,'����','325-1638','�λ걤���� ��� ��� 1338-8����','�λ걤���� ��� ����� 957 (���)',46926,'��󵿹�����','2014-01-07 17:33','I','2018-08-31 23:59',381359.1447,189866.9462);
--�� 155
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6956,3390000,'3.39E+17',to_date('1998-12-21', 'YYYY-MM-DD'),1,'����/����',0,'����','317-7558','�λ걤���� ��� �ַʵ� 519-62����','�λ걤���� ��� �ַʷ�10���� 125 (�ַʵ�)',NULL,'�뼺��������','2005-12-19 16:53','I','2018-08-31 23:59',382603.9317,185187.337);
--�� 156
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6957,3390000,'3.39E+17',to_date('2003-01-22', 'YYYY-MM-DD'),1,'����/����',0,'����','324-9954','�λ걤���� ��� �ַʵ� 23-2����','�λ걤���� ��� ���ߴ�� 367 (�ַʵ�)',47005,'���ݵ�������','2014-01-07 17:35','I','2018-08-31 23:59',383345.2004,185460.5855);
--�� 157
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6958,3390000,'3.39E+17',to_date('2003-08-25', 'YYYY-MM-DD'),1,'����/����',0,'����','051-316-7597','�λ걤���� ��� ���õ� 25-25','�λ걤���� ��� �뵿�� 18(���õ�)',47035,'�������յ�������','2022-08-09 10:26','U','2022-08-11 2:40',379809.7725,183277.9206);
--�� 158
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6959,3390000,'3.39E+17',to_date('2004-09-22', 'YYYY-MM-DD'),1,'����/����',0,'����','311-7578','�λ걤���� ��� ��� 459-2����','�λ걤���� ��� ���� 107 (���)',46928,'������������','2014-01-07 17:37','I','2018-08-31 23:59',381307.1941,189290.726);
--�� 159
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6960,3390000,'3.39E+17',to_date('2006-05-19', 'YYYY-MM-DD'),1,'����/����',0,'����','051-314-7582','�λ걤���� ��� ���õ� 690���� �Ե���Ʈ������','�λ걤���� ��� ������� 733, �Ե���Ʈ������ 2�� (���õ�)',47032,'���굿������','2019-03-05 10:13','U','2019-03-07 2:40',379352.8056,182712.0791);
--�� 160
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6961,3390000,'3.39E+17',to_date('2014-10-24', 'YYYY-MM-DD'),1,'����/����',0,'����','051-312-7555','�λ걤���� ��� ���嵿 574-9����','�λ걤���� ��� �뵿�� 129 (���嵿)',47050,'���嵿������','2014-10-24 9:56','I','2018-08-31 23:59',380507.1169,184123.0521);
--�� 161
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6962,3390000,'3.39E+17',to_date('2018-05-11', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ��� ���õ� 565-1����','�λ걤���� ��� ������� 786, �������� 201ȣ (���õ�)',47039,'���λ굿���޵��ü���','2019-03-28 8:49','U','2019-03-30 2:40',379687.7552,183065.344);
--�� 162
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6963,3270000,'3.27E+17',to_date('1972-11-18', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���� �ʷ��� 287-15���� 7��1��','�λ걤���� ���� �ʷ���� 83 (�ʷ���)',48813,'���ϵ�������','2013-12-27 11:36','I','2018-08-31 23:59',385749.4901,181903.5903);
--�� 163
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6964,3270000,'3.27E+17',to_date('1992-07-04', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���� ������ 427-48����','�λ걤���� ���� ����� 835-1 (������)',NULL,'�������յ�������','2012-03-28 10:21','I','2018-08-31 23:59',386376.9507,183797.3733);
--�� 164
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6965,3270000,'3.27E+17',to_date('2005-06-24', 'YYYY-MM-DD'),1,'����/����',0,'����','464-5975','�λ걤���� ���� �ʷ��� 287-9����','�λ걤���� ���� �ʷ���� 84-1 (�ʷ���)',48814,'�ùε�������','2019-01-17 10:54','U','2019-01-19 2:40',385778.9416,181909.9164);
--�� 165
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6966,3270000,'3.27E+17',to_date('2009-05-11', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ���� ������ 811-42����','�λ걤���� ���� �������� 11, 1�� (������)',48780,'�ϳ���������','2019-01-17 10:52','U','2019-01-19 2:40',386326.2362,183082.7421);
--�� 166
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6967,3320000,'3.32E+17',to_date('1992-06-15', 'YYYY-MM-DD'),1,'����/����',0,'����','332-7588','�λ걤���� �ϱ� ������ 839-1����','�λ걤���� �ϱ� ��õ�� 280 (������)',46611,'��絿������','2019-03-27 14:48','U','2019-03-29 2:40',385250.1351,191889.103);
--�� 167
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6968,3320000,'3.32E+17',to_date('1999-07-02', 'YYYY-MM-DD'),1,'����/����',0,'����','343-7588','�λ걤���� �ϱ� ȭ���� 2337���� ȭ��2�������ξ��ũ��Ÿ','�λ걤���� �ϱ� �ݰ��� 175 (ȭ����, ȭ��2�������ξ��ũ��Ÿ)',46541,'��Ƶ�������','2019-03-27 14:46','U','2019-03-29 2:40',382841.0071,193563.9531);
--�� 168
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6969,3320000,'3.32E+17',to_date('2002-12-21', 'YYYY-MM-DD'),1,'����/����',0,'����','365-0075','�λ걤���� �ϱ� ��õ�� 383-3����','�λ걤���� �ϱ� ������� 34 (��õ��)',46577,'21�������յ�������','2019-03-27 14:40','U','2019-03-29 2:40',382847.4897,192011.4705);
--�� 169
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6970,3320000,'3.32E+17',to_date('2003-03-21', 'YYYY-MM-DD'),1,'����/����',0,'����','342-3739','�λ걤���� �ϱ� ������ 669-2���� �����������','�λ걤���� �ϱ� �ö��� 1, ����������� (������)',46599,'�����������','2019-03-27 14:51','U','2019-03-29 2:40',382479.7046,191404.0266);
--�� 170
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6971,3320000,'3.32E+17',to_date('2003-09-02', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ϱ� ȭ���� 1469-4����','�λ걤���� �ϱ� �ݰ��� 304 (ȭ����)',NULL,'����������','2007-08-07 11:36','I','2018-08-31 23:59',383277.6521,194763.9);
--�� 171
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6972,3320000,'3.32E+17',to_date('2016-06-10', 'YYYY-MM-DD'),1,'����/����',0,'����','051)343-3834','�λ걤���� �ϱ� ������ 935-2����','�λ걤���� �ϱ� ����� 1053 (������)',46649,'�ص絿������','2019-09-06 16:45','U','2019-09-08 2:40',381760.255,190742.6321);
--�� 172
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6973,3320000,'3.32E+17',to_date('2009-07-02', 'YYYY-MM-DD'),1,'����/����',0,'����','363-7593','�λ걤���� �ϱ� ȭ���� 1528-5���� ȭ������202ȣ','�λ걤���� �ϱ� �ݰ��� 344 (ȭ����,ȭ������202ȣ)',NULL,'�ູ�ѵ�������','2009-07-02 16:00','I','2018-08-31 23:59',383303.8909,195174.3782);
--�� 173
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6974,3320000,'3.32E+17',to_date('2012-03-08', 'YYYY-MM-DD'),1,'����/����',0,'����','513380075','�λ걤���� �ϱ� ������ 916-7����','�λ걤���� �ϱ� ��õ�� 227 (������)',46571,'����24�õ�������','2012-03-08 14:02','I','2018-08-31 23:59',384684.1348,192061.9041);
--�� 174
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6975,3320000,'3.32E+17',to_date('2013-04-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051361-7582','�λ걤���� �ϱ� ȭ���� 898-19 �������ݰ�','�λ걤���� �ϱ� �ݰ��� 182, �������ݰ� (ȭ����)',46539,'ī���� ��������','2021-05-07 13:16','U','2021-05-09 2:40',382940.7371,193602.7466);
--�� 175
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6976,3320000,'3.32E+17',to_date('2014-06-09', 'YYYY-MM-DD'),1,'����/����',0,'����','365-7588','�λ걤���� �ϱ� �ݰ 1880-12���� �ظ�����','�λ걤���� �ϱ� �л�� 299, �ظ����� (�ݰ)',46519,'�׷��� ��������','2019-05-07 14:45','U','2019-05-09 2:40',383111.1017,196111.9007);
--�� 176
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6977,3320000,'3.32E+17',to_date('2017-06-14', 'YYYY-MM-DD'),1,'����/����',0,'����','343-7566','�λ걤���� �ϱ� ��õ�� 381-7����','�λ걤���� �ϱ� ������� 41 (��õ��)',46548,'�������ǷἾ��','2018-08-17 13:43','I','2018-08-31 23:59',382906.3354,192089.3221);
--�� 177
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6978,3320000,'3.32E+17',to_date('2018-01-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-341-3344','�λ걤���� �ϱ� ��õ�� 373-1���� �����׸��ھƾ���Ʈ','�λ걤���� �ϱ� �������155���� 9 (��õ��, �����׸��ھƾ���Ʈ)',46554,'������������','2019-03-27 14:46','U','2019-03-29 2:40',383934.8365,192378.5329);
--�� 178
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6979,3280000,'3.28E+17',to_date('2002-01-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-415-2566','�λ걤���� ������ ������1�� 20-4����','�λ걤���� ������ ������ 111 (������1��)',49036,'������������','2019-03-07 11:08','U','2019-03-09 2:40',386238.8453,178803.0597);
--�� 179
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6980,3280000,'3.28E+17',to_date('1996-05-09', 'YYYY-MM-DD'),1,'����/����',0,'����','051-405-9493','�λ걤���� ������ ���ﵿ 266-3����','�λ걤���� ������ ����� 80 (���ﵿ)',49097,'������������','2019-03-07 11:08','U','2019-03-09 2:40',388779.0746,177680.767);
--�� 180
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6981,3280000,'3.28E+17',to_date('2004-01-03', 'YYYY-MM-DD'),1,'����/����',0,'����','415-2468','�λ걤���� ������ �뱳��1�� 143����','�λ걤���� ������ ������ 78 (�뱳��1��)',49045,'��Ʈ�����յ�������','2019-03-07 11:12','U','2019-03-09 2:40',385893.7103,178909.5597);
--�� 181
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6982,3280000,'3.28E+17',to_date('2009-09-30', 'YYYY-MM-DD'),1,'����/����',0,'����','414-7588','�λ걤���� ������ û�е� 62-60���� �Ѷ�û�о���Ʈ','�λ걤���� ������ ������ 430, �Ѷ�û�о���Ʈ 2�� (û�е�)',49088,'õ��������','2019-03-07 11:13','U','2019-03-09 2:40',388500.1629,178645.3397);
--�� 182
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6983,3330000,'3.33E+17',to_date('2017-01-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-927-7575','�λ걤���� �ؿ�뱸 �ݿ��� 1465-57���� �����ݿ�������','�λ걤���� �ؿ�뱸 �����̷� 65-19, �����ݿ������� 2�� (�ݿ���)',48038,'�ݿ����ѵ�������','2019-03-27 17:11','U','2019-03-29 2:40',392797.4651,190989.3748);
--�� 183
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6984,3330000,'3.33E+17',to_date('2017-06-14', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ؿ�뱸 �µ� 1476-1 �ؿ�뺣������','�λ걤���� �ؿ�뱸 ���� 45, �ؿ�뺣������ 111ȣ (�µ�)',48104,'�ؿ�� 24�� �����Ƿ��','2022-06-15 11:40','U','2022-06-17 2:40',398251.7811,187524.3185);
--�� 184
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6985,3330000,'3.33E+17',to_date('2018-01-24', 'YYYY-MM-DD'),1,'����/����',0,'����','051-710-2004','�λ걤���� �ؿ�뱸 �ߵ� 1262-1','�λ걤���� �ؿ�뱸 �ؿ���غ���357���� 17, 4~8�� (�ߵ�)',48096,'ū���������޵��ü���','2022-05-25 10:46','U','2022-05-27 2:40',397433.6619,187207.142);
--�� 185
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6986,3330000,'3.33E+17',to_date('2018-01-11', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ؿ�뱸 �ߵ� 1809���� �ؿ����������Ʈ����','�λ걤���� �ؿ�뱸 �µ���ȯ��433���� 30-1, �ؿ����������Ʈ���� 224~227ȣ (�ߵ�)',48114,'�� ��������','2019-03-27 17:16','U','2019-03-29 2:40',398546.5723,186991.922);
--�� 186
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6987,3330000,'3.33E+17',to_date('2013-07-22', 'YYYY-MM-DD'),1,'����/����',0,'����','731-7530','�λ걤���� �ؿ�뱸 �µ� 1340-3���� �Ƿ�ü���ǽ��� 204ȣ','�λ걤���� �ؿ�뱸 �µ���ȯ��402���� 8, 204ȣ (�µ�, �Ƿ�ü���ǽ���)',48104,'������ ��������','2019-03-06 19:46','U','2019-03-08 2:40',398351.677,187037.6461);
--�� 187
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6988,3330000,'3.33E+17',to_date('2014-03-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051-702-1626','�λ걤���� �ؿ�뱸 �µ� 1407-2���� ��ǳ������ 302ȣ','�λ걤���� �ؿ�뱸 �µ���ȯ�� 173, ��ǳ������ 302ȣ (�µ�)',48075,'����ǵ�������','2019-03-06 19:49','U','2019-03-08 2:40',398088.8767,188716.5782);
--�� 188
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6989,3330000,'3.33E+17',to_date('2014-06-30', 'YYYY-MM-DD'),1,'����/����',0,'����','051-702-5750','�λ걤���� �ؿ�뱸 �µ� 1473-2���� ������ 306ȣ','�λ걤���� �ؿ�뱸 �ؿ��� 794, ������ 306ȣ (�µ�)',48104,'������������','2019-03-27 17:11','U','2019-03-29 2:40',398155.6608,187681.5736);
--�� 189
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6990,3330000,'3.33E+17',to_date('2014-10-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-701-7599','�λ걤���� �ؿ�뱸 ������ 85-1����','�λ걤���� �ؿ�뱸 ����2��13���� 46 (������)',48069,'������������','2020-04-17 10:16','U','2020-04-19 2:40',400877.3254,190630.1977);
--�� 190
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6991,3330000,'3.33E+17',to_date('2015-05-19', 'YYYY-MM-DD'),1,'����/����',0,'����','746-7077','�λ걤���� �ؿ�뱸 �ߵ� 1512���� �ؿ�� �޸��� ���� �븣���̽� �󰡵� 305ȣ','�λ걤���� �ؿ�뱸 �޸��̱�65���� 33, �󰡵� 3�� 305ȣ (�ߵ�, �ؿ�� �޸��� ���� �븣���̽�)',48117,'�޸��� ȣ�γ� ��������','2019-03-06 19:46','U','2019-03-08 2:40',398058.7221,186789.9814);
--�� 191
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6992,3330000,'3.33E+17',to_date('2016-05-16', 'YYYY-MM-DD'),1,'����/����',0,'����','915-8275','�λ걤���� �ؿ�뱸 �µ� 1315 �ؿ������ھ��ֻ���','�λ걤���� �ؿ�뱸 ���Ƿ� 48, �󰡵� 1-2, 2-2ȣ (�µ�, �ؿ������ھ��ֻ���)',48110,'�ؿ�� �÷�����������','2022-06-15 17:54','U','2022-06-17 2:40',398407.0433,187784.8439);
--�� 192
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6993,3330000,'3.33E+17',to_date('2003-12-19', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ؿ�뱸 �ݿ��� 1202-2����','�λ걤���� �ؿ�뱸 �����̷� 101 (�ݿ���)',48038,'�츮��������','2019-03-04 15:47','U','2019-03-06 2:40',392922.6227,191342.1604);
--�� 193
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6994,3330000,'3.33E+17',to_date('2004-02-19', 'YYYY-MM-DD'),1,'����/����',0,'����','746-0075','�λ걤���� �ؿ�뱸 �쵿 1488 �����帶ũ���Ҿ���Ʈ','�λ걤���� �ؿ�뱸 ���ҵ��� 25, B�� 204ȣ (�쵿, �����帶ũ���Ҿ���Ʈ)',48059,'���̼��� �����޵��ü���','2022-05-04 12:57','U','2022-05-06 2:40',394112.5249,187887.9317);
--�� 194
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6995,3330000,'3.33E+17',to_date('2004-03-03', 'YYYY-MM-DD'),1,'����/����',0,'����','704-4376','�λ걤���� �ؿ�뱸 �µ� 1315���� �ؿ������ھƺ��ջ� 206ȣ','�λ걤���� �ؿ�뱸 ���Ƿ� 48, 206ȣ (�µ�)',48110,'ȭ�����յ�������','2019-03-04 15:43','U','2019-03-06 2:40',398407.0433,187784.8439);
--�� 195
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6996,3400000,'3.40E+17',to_date('2012-09-05', 'YYYY-MM-DD'),1,'����/����',0,'����','728-2236','�λ걤���� ���屺 ������ ���и� 713-3����','�λ걤���� ���屺 ������ ������ 565',46015,'Ŵ����������','2019-03-04 15:42','U','2019-03-06 2:40',397801.2386,204661.7615);
--�� 196
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6997,3330000,'3.33E+17',to_date('2004-03-19', 'YYYY-MM-DD'),1,'����/����',0,'����','746-7775','�λ걤���� �ؿ�뱸 �쵿 529-2����','�λ걤���� �ؿ�뱸 �ؿ��� 624 (�쵿)',48095,'�ؿ��������������','2019-03-04 15:43','U','2019-03-06 2:40',396661.6112,187066.9015);
--�� 197
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6998,3330000,'3.33E+17',to_date('2006-08-17', 'YYYY-MM-DD'),1,'����/����',0,'����','744-6336','�λ걤���� �ؿ�뱸 ��۵� 1200���� ������ũ����Ʈ�� 6�� 205ȣ','�λ걤���� �ؿ�뱸 �����߾ӷ� 145, 205ȣ (��۵�)',48050,'���ҵ������պ���','2019-03-04 15:49','U','2019-03-06 2:40',393239.2379,188619.1496);
--�� 198
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (6999,3330000,'3.33E+17',to_date('2010-02-02', 'YYYY-MM-DD'),1,'����/����',0,'����','544-0775','�λ걤���� �ؿ�뱸 �ݼ۵� 20-16����','�λ걤���� �ؿ�뱸 �ݼ۷� 922 (�ݼ۵�)',48004,'�丶����������','2017-07-31 13:59','I','2018-08-31 23:59',396052.8154,194703.1301);
--�� 199
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7000,3330000,'3.33E+17',to_date('2010-04-05', 'YYYY-MM-DD'),1,'����/����',0,'����','051-702-7511','�λ걤���� �ؿ�뱸 �µ� 985-2����','�λ걤���� �ؿ�뱸 ���� 108, 2�� (�µ�)',48079,'���عڵ�������','2019-03-06 19:58','U','2019-03-08 2:40',397990.4695,188084.8798);
--�� 200
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7001,3330000,'3.33E+17',to_date('2004-08-16', 'YYYY-MM-DD'),1,'����/����',0,'����','784-7844','�λ걤���� �ؿ�뱸 ��۵� 1098-1���� 14��2�� ����Ǽ� 303ȣ','�λ걤���� �ؿ�뱸 ��ݷ� 148, 32ȣ (��۵�)',48053,'������������','2019-03-04 15:51','U','2019-03-06 2:40',393214.9667,189314.4738);
--�� 201
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7002,3330000,'3.33E+17',to_date('2010-04-09', 'YYYY-MM-DD'),1,'����/����',0,'����','747-7407','�λ걤���� �ؿ�뱸 �쵿 1435���� �����̿�����������','�λ걤���� �ؿ�뱸 ������Ƽ3�� 23, �����̿����������� 333~336ȣ (�쵿)',48118,'������Ƽ ���յ�������','2018-05-01 9:57','I','2018-08-31 23:59',395560.2205,186273.7691);
--�� 202
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7003,3330000,'3.33E+17',to_date('2011-02-10', 'YYYY-MM-DD'),1,'����/����',0,'����','544-7588','�λ걤���� �ؿ�뱸 �ݼ۵� 62-508����','�λ걤���� �ؿ�뱸 ���ݼ۷� 73 (�ݼ۵�)',48007,'BS������������','2019-03-06 19:40','U','2019-03-08 2:40',396298.3028,194496.4019);
--�� 203
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7004,3330000,'3.33E+17',to_date('2011-02-17', 'YYYY-MM-DD'),1,'����/����',0,'����','051-701-7555','�λ걤���� �ؿ�뱸 �µ� 1443-7���� ���������� 303ȣ','�λ걤���� �ؿ�뱸 �µ���ȯ�� 309, 303ȣ (�µ�)',48113,'�´�����������','2019-03-04 15:48','U','2019-03-06 2:40',398833.568,187648.429);
--�� 204
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7005,3330000,'3.33E+17',to_date('2007-03-07', 'YYYY-MM-DD'),1,'����/����',0,'����','529-5388','�λ걤���� �ؿ�뱸 �ݿ��� 1629-5����','�λ걤���� �ؿ�뱸 �ݿ��� 96, 1�� (�ݿ���, ��ǳ����)',48036,'��굿������','2019-03-04 15:45','U','2019-03-06 2:40',393310.0757,191056.546);
--�� 205
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7006,3330000,'3.33E+17',to_date('2011-05-11', 'YYYY-MM-DD'),1,'����/����',0,'����','051-746-1075','�λ걤���� �ؿ�뱸 �쵿 586-23����','�λ걤���� �ؿ�뱸 �ؿ��� 658-1 (�쵿)',48095,'��������������','2019-03-06 19:53','U','2019-03-08 2:40',396927.881,187259.8968);
--�� 206
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7007,3330000,'3.33E+17',to_date('2013-03-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-742-7975','�λ걤���� �ؿ�뱸 ��۵� 1200','�λ걤���� �ؿ�뱸 �����߾ӷ� 145, 202ȣ (��۵�, ������ũ��2��)',48050,'�������յ�������','2020-11-11 8:52','U','2020-11-13 2:40',393239.2379,188619.1496);
--�� 207
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7008,3370000,'3.37E+17',to_date('1975-10-14', 'YYYY-MM-DD'),1,'����/����',0,'����','862-8668','�λ걤���� ������ ������ 608-18����','�λ걤���� ������ ������� 146 (������)',47546,'������������','2019-03-06 16:14','U','2019-03-08 2:40',388481.6072,188882.0699);
--�� 208
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7009,3310000,'3.31E+17',to_date('1992-10-20', 'YYYY-MM-DD'),1,'����/����',0,'����','634-4017','�λ걤���� ���� ������ 248-21����','�λ걤���� ���� ������ 38 (������)',48457,'������������','2019-04-23 10:04','U','2019-04-25 2:40',388762.2663,183880.0007);
--�� 209
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7010,3310000,'3.31E+17',to_date('1995-04-08', 'YYYY-MM-DD'),1,'����/����',0,'����','628-0855','�λ걤���� ���� ��ȣ�� 368-4���� ��þ���Ʈ','�λ걤���� ���� ��ȣ��123���� 5 (��ȣ��, ��þ���Ʈ)',48578,'��ȣ��������','2019-04-23 10:05','U','2019-04-25 2:40',392505.2154,182296.1227);
--�� 210
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7011,3370000,'3.37E+17',to_date('1991-11-23', 'YYYY-MM-DD'),1,'����/����',0,'����','503-0688','�λ걤���� ������ ���굿 300-3���� 2��2��','�λ걤���� ������ ��õõ���� 4 (���굿)',47559,'û����������','2015-04-01 9:59','I','2018-08-31 23:59',390401.3859,190192.3725);
--�� 211
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7012,3310000,'3.31E+17',to_date('2013-08-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-627-1275','�λ걤���� ���� ��ȣ�� 957-1���� ��žž�÷��̽� A�� 403ȣ','�λ걤���� ���� ������ 115, ��žž�÷��̽� A�� 403ȣ (��ȣ��)',48515,'��ε�������','2019-07-15 14:48','U','2019-07-17 2:40',392515.6897,183481.9411);
--�� 212
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7013,3370000,'3.37E+17',to_date('2011-01-12', 'YYYY-MM-DD'),1,'����/����',0,'����','753-7580','�λ걤���� ������ ���굿 2235-8����','�λ걤���� ������ ������ 84 (���굿)',47573,'���̵�������','2019-03-06 16:18','U','2019-03-08 2:40',391900.6472,188657.6668);
--�� 213
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7014,3310000,'3.31E+17',to_date('1996-12-02', 'YYYY-MM-DD'),1,'����/����',0,'����','636-5242','�λ걤���� ���� ������ 46-1���� ��� ���� 4�� ����Ʈ �󰡵� 109ȣ','�λ걤���� ���� ������ 7, �󰡵� 109ȣ (������, ��� ���� 4�� ����Ʈ)',48489,'��ϵ�������','2019-04-23 10:07','U','2019-04-25 2:40',389680.6778,182339.0175);
--�� 214
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7015,3310000,'3.31E+17',to_date('2000-06-26', 'YYYY-MM-DD'),1,'����/����',0,'����','635-0402','�λ걤���� ���� ������ 359-21����','�λ걤���� ���� ������ 34 (������)',48457,'25�� ��������','2019-04-23 10:08','U','2019-04-25 2:40',388721.0053,183893.2178);
--�� 215
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7016,3310000,'3.31E+17',to_date('2002-08-13', 'YYYY-MM-DD'),1,'����/����',0,'����','516217555','�λ걤���� ���� �뿬�� 39-22','�λ걤���� ���� ������334���� 3, 2�� (�뿬��)',48509,'ưư��������','2022-07-08 17:39','U','2022-07-10 2:40',391546.8499,184145.7671);
--�� 216
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7017,3310000,'3.31E+17',to_date('2003-03-24', 'YYYY-MM-DD'),1,'����/����',0,'����','623-7588','�λ걤���� ���� ��ȣ�� 176-7���� ��Ʈ�ε�������','�λ걤���� ���� ��ȣ�� 20, ��Ʈ�ε������� (��ȣ��)',48518,'��Ʈ�ε�������','2019-04-23 10:09','U','2019-04-25 2:40',391986.9735,183043.6328);
--�� 217
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7018,3310000,'3.31E+17',to_date('2003-10-13', 'YYYY-MM-DD'),1,'����/����',0,'����','627-2885','�λ걤���� ���� �뿬�� 1746-5 ȣ���౹','�λ걤���� ���� ������ 224-1, ȣ���౹ (�뿬��)',48492,'���緡 �����ǷἾ��','2023-03-22 17:48','U','2023-03-25 2:40',390524.5493,183746.2824);
--�� 218
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7021,3310000,'3.31E+17',to_date('2013-05-02', 'YYYY-MM-DD'),1,'����/����',0,'����','051)612-7552','�λ걤���� ���� ��ȣ�� 554-1����','�λ걤���� ���� ��ȣ�� 233 (��ȣ��)',48593,'�ؿµ�������','2019-03-06 13:36','U','2019-03-08 2:40',392414.0191,181186.1114);
--�� 219
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7022,3310000,'3.31E+17',to_date('2015-11-12', 'YYYY-MM-DD'),1,'����/����',0,'����','051-622-2171','�λ걤���� ���� �뿬�� 1858 �뿬��������ƮǪ������','�λ걤���� ���� ������ 345, 1115�� 124, 125ȣ (�뿬��, �뿬��������ƮǪ������)',48432,'�ٿ� ��������','2022-05-04 9:51','U','2022-05-06 2:40',391411.4502,184553.6728);
--�� 220
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7023,3310000,'3.31E+17',to_date('2017-10-12', 'YYYY-MM-DD'),1,'����/����',0,'����','051-624-2475','�λ걤���� ���� �뿬�� 1745-9','�λ걤���� ���� ������ 221 (�뿬��)',48445,'UN�����ǷἾ��','2022-10-04 13:59','U','2022-10-06 2:40',390487.343,183799.2048);
--�� 221
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7024,3370000,'3.37E+17',to_date('2003-03-28', 'YYYY-MM-DD'),1,'����/����',0,'����','755-4765','�λ걤���� ������ ���굿 418-10����','�λ걤���� ������ ������ 171-1 (���굿)',NULL,'���뵿������','2019-03-06 16:23','U','2019-03-08 2:40',391842.9893,189546.3727);
--�� 222
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7025,3370000,'3.37E+17',to_date('1999-06-19', 'YYYY-MM-DD'),1,'����/����',0,'����','051-867-5595','�λ걤���� ������ ���굿 746-12����','�λ걤���� ������ �����Ŵ��114���� 1 (���굿)',NULL,'������������','2019-03-06 16:22','U','2019-03-08 2:40',389639.4196,189253.9436);
--�� 223
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7026,3370000,'3.37E+17',to_date('2009-05-04', 'YYYY-MM-DD'),1,'����/����',0,'����','864-7582','�λ걤���� ������ ���굿 581-4����','�λ걤���� ������ ����õ�� 258 (���굿, ���������������)',47518,'������ ��������','2016-01-25 15:44','I','2018-08-31 23:59',389856.5724,190029.7107);
--�� 224
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7027,3370000,'3.37E+17',to_date('2010-12-27', 'YYYY-MM-DD'),1,'����/����',0,'����','868-7591','�λ걤���� ������ ������ 2-7','�λ걤���� ������ ������� 278 (������)',47522,'�λ굿���޵��ü���','2023-03-22 9:30','U','2023-03-24 2:40',389195.6262,189929.6);
--�� 225
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7028,3310000,'3.31E+17',to_date('2013-05-23', 'YYYY-MM-DD'),1,'����/����',0,'����','051)636-7582','�λ걤���� ���� ������ 403-7 �ټ� ���� ����','�λ걤���� ���� ������13���� 3, �ټ� ���� ���� (������)',48415,'�ټذ����̸޵��ü���','2022-10-21 15:54','U','2022-10-23 2:40',388526.2039,183992.3288);
--�� 226
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7029,3310000,'3.31E+17',to_date('2013-06-11', 'YYYY-MM-DD'),1,'����/����',0,'����','051)704-0220','�λ걤���� ���� ��ȣ�� 532-19����','�λ걤���� ���� ��ȣ�� 199 (��ȣ��)',48591,'�����񵿹�����','2019-03-07 18:32','U','2019-03-09 2:40',392400.4891,181526.932);
--�� 227
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7030,3310000,'3.31E+17',to_date('2013-07-15', 'YYYY-MM-DD'),1,'����/����',0,'����','051-632-7580','�λ걤���� ���� ������ 403-7 �ټ� ���� ����','�λ걤���� ���� ������13���� 3, �ټ� ���� ���� (������)',48415,'(��)�ټص����޵��ü���','2023-03-10 15:05','U','2023-03-12 2:40',388526.2039,183992.3288);
--�� 228
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7031,3370000,'3.37E+17',to_date('2018-01-24', 'YYYY-MM-DD'),1,'����/����',0,'����','051-868-7579','�λ걤���� ������ ������ 1466-24����','�λ걤���� ������ ������ 84 (������)',47516,'��õõ��������','2018-01-24 14:55','I','2018-08-31 23:59',389618.6578,190495.9021);
--�� 229
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7032,3370000,'3.37E+17',to_date('2014-05-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-759-8669','�λ걤���� ������ ���굿 399-12','�λ걤���� ������ ������ 234-1 (���굿)',47565,'��������','2023-02-07 17:23','U','2023-02-09 2:40',391356.083,189652.149);
--�� 230
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7033,3370000,'3.37E+17',to_date('2014-06-17', 'YYYY-MM-DD'),1,'����/����',0,'����','868-6631','�λ걤���� ������ ���굿 104-82����','�λ걤���� ������ ������ 354 (���굿)',47559,'MS��������','2018-10-19 10:42','U','2018-11-03 4:00',390299.9242,190031.8533);
--�� 231
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7034,3370000,'3.37E+17',to_date('2015-09-24', 'YYYY-MM-DD'),1,'����/����',0,'����','051-868-0075','�λ걤���� ������ ���굿 1948-7����','�λ걤���� ������ ������ 140 (���굿)',47610,'�̷뵿������','2018-10-19 11:29','U','2018-11-03 4:00',389968.7895,188130.6562);
--�� 232
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7035,3370000,'3.37E+17',to_date('2015-08-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-863-8638','�λ걤���� ������ ���굿 306-39','�λ걤���� ������ ������344���� 1 (���굿)',47559,'���̵��� ��������','2021-04-12 10:46','U','2021-04-14 2:40',390337.7549,189955.214);
--�� 233
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7036,3370000,'3.37E+17',to_date('2017-08-03', 'YYYY-MM-DD'),1,'����/����',0,'����','051-753-9875','','�λ걤���� ������ �ȿ��� 28, 1�� (���굿, �׸�����)',47565,'�غ�ġ��������','2017-08-03 10:02','I','2018-08-31 23:59',391228.4176,189893.1211);
--�� 234
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7037,3370000,'3.37E+17',to_date('2018-04-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-997-8275','�λ걤���� ������ ���굿 417-20����','�λ걤���� ������ ������237���� 115 (���굿)',47558,'��������������','2018-04-20 11:08','I','2018-08-31 23:59',391835.1053,189316.067);
--�� 235
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7038,3370000,'3.37E+17',to_date('2018-07-12', 'YYYY-MM-DD'),1,'����/����',0,'����','051-853-7579','�λ걤���� ������ ���굿 844-28','�λ걤���� ������ ������ 98 (���굿)',47607,'Jpet��������','2023-03-24 13:15','U','2023-03-26 2:40',389553.2447,188196.9353);
--�� 236
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7039,3380000,'3.38E+17',to_date('2014-10-24', 'YYYY-MM-DD'),1,'����/����',0,'����','051-514-5404','','�λ걤���� ������ ���ȷ� 19 (���ȵ�)',48297,'���ﵿ������','2014-10-24 10:45','I','2018-08-31 23:59',392645.3072,186207.1302);
--�� 237
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7040,3380000,'3.38E+17',to_date('2015-03-18', 'YYYY-MM-DD'),1,'����/����',0,'����','','','�λ걤���� ������ ������ 184 (���ȵ�)',48303,'���񵿹�����','2022-10-25 10:59','U','2022-10-27 2:40',393099.6739,186269.8253);
--�� 238
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7041,3380000,'3.38E+17',to_date('2015-06-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-627-7542','','�λ걤���� ������ Ȳ�ɻ�� 3, 2�� (��õ��)',48316,'���� ��������','2022-08-12 14:40','U','2022-08-14 2:40',392204.5422,185165.5845);
--�� 239
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7042,3380000,'3.38E+17',to_date('2016-03-10', 'YYYY-MM-DD'),1,'����/����',0,'����','051-757-7845','','�λ걤���� ������ ������ 602, 1�� (���ȵ�)',48294,'�˷��� ��������','2016-03-10 14:36','I','2018-08-31 23:59',392534.7146,186505.3719);
--�� 240
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7043,3380000,'3.38E+17',to_date('2017-05-22', 'YYYY-MM-DD'),1,'����/����',0,'����','','','�λ걤���� ������ ������702���� 18, 3�� (���ȵ�)',48266,'Ŭ������ ��������','2017-05-22 16:18','I','2018-08-31 23:59',392764.4714,187347.8314);
--�� 241
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7044,3380000,'3.38E+17',to_date('1989-10-05', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ��õ��','�λ걤���� ������ Ȳ�ɴ�� 505, 1�� (��õ��)',48313,'��õ��������','2014-07-14 14:41','I','2018-08-31 23:59',392147.4103,184089.0357);
--�� 242
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7045,3380000,'3.38E+17',to_date('2018-01-05', 'YYYY-MM-DD'),1,'����/����',0,'����','517444179','�λ걤���� ������ �ζ��� 28-1���� 1��','�λ걤���� ������ ������ 258, 1�� (�ζ���)',48288,'��������������','2018-01-05 10:39','I','2018-08-31 23:59',393723.5924,186557.2603);
--�� 243
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7046,3380000,'3.38E+17',to_date('2018-02-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-752-8883','�λ걤���� ������ ���̵� 430-3���� 1��','�λ걤���� ������ ������ 37, 1�� (���̵�)',48210,'�̶���������','2018-02-08 11:39','I','2018-08-31 23:59',391916.3754,188188.477);
--�� 244
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7047,3380000,'3.38E+17',to_date('2018-04-12', 'YYYY-MM-DD'),1,'����/����',0,'����','516252345','�λ걤���� ������ ��õ�� 69-20','�λ걤���� ������ ������ 405-1, 2-4�� (��õ��)',48316,'�������ӵ����Ƿ��','2023-02-10 16:51','U','2023-02-12 2:40',392056.8066,184646.2066);
--�� 245
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7048,3380000,'3.38E+17',to_date('1995-05-08', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ���ȵ�','�λ걤���� ������ ������ 567, 2�� (���ȵ�)',48260,'���ȵ�������','2014-10-31 15:11','I','2018-08-31 23:59',392434.2976,186192.5508);
--�� 246
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7049,3380000,'3.38E+17',to_date('1996-05-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-759-0225','�λ걤���� ������ ������','�λ걤���� ������ ������ 757, 2�� (������)',48222,'�̻󵿹�����','2014-12-24 11:16','I','2018-08-31 23:59',393259.403,187424.4945);
--�� 247
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7050,3380000,'3.38E+17',to_date('1998-04-30', 'YYYY-MM-DD'),1,'����/����',0,'����','051-628-8211','�λ걤���� ������ ��õ�� 47-1���� ȭ�����Ʈ 6�� 2ȣ','�λ걤���� ������ ������ 485, 6�� 2ȣ (��õ��, ȭ�����Ʈ)',48265,'�Ҹ��ְ����պ���','2013-07-01 9:46','I','2018-08-31 23:59',392232.2151,185358.9658);
--�� 248
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7051,3380000,'3.38E+17',to_date('2004-02-04', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ���̵� 777���� 45��1�� �Ｚ����Ʈ 7�� 1107ȣ','�λ걤���� ������ ������15���� 7 (���̵�, ��ȭ)',48211,'������������','2015-12-04 10:44','I','2018-08-31 23:59',391420.713,187567.309);
--�� 249
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7052,3380000,'3.38E+17',to_date('2004-11-25', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ������ 76-1���� 16��5�� ������������Ʈ 1401ȣ','�λ걤���� ������ ������ 733 (������)',48223,'�����������','2015-12-04 10:41','I','2018-08-31 23:59',393045.4707,187552.7454);
--�� 250
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7053,3380000,'3.38E+17',to_date('2006-07-27', 'YYYY-MM-DD'),1,'����/����',0,'����','753-8875','�λ걤���� ������ ���̵� 963-21����','�λ걤���� ������ ������ 241 (���̵�)',48207,'�������յ�������','2013-07-31 9:44','I','2018-08-31 23:59',390998.5338,188044.1321);
--�� 251
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7054,3380000,'3.38E+17',to_date('2007-02-15', 'YYYY-MM-DD'),1,'����/����',0,'����','051-754-3270','�λ걤���� ������ ���̵� 837-4���� 19��5��','�λ걤���� ������ ������ 235 (���̵�)',48207,'�Ｚ��������','2013-12-30 13:32','I','2018-08-31 23:59',390929.9312,188050.5082);
--�� 252
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7055,3380000,'3.38E+17',to_date('2012-02-21', 'YYYY-MM-DD'),1,'����/����',0,'����','051-761-2502','�λ걤���� ������ ���ȵ� 117-10����','�λ걤���� ������ ������ 618-1 (���ȵ�)',48291,'ABC��������','2012-02-21 13:51','I','2018-08-31 23:59',392549.0995,186685.2639);
--�� 253
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7056,3380000,'3.38E+17',to_date('2014-06-30', 'YYYY-MM-DD'),1,'����/����',0,'����','517578529','','�λ걤���� ������ ������ 207 (���ȵ�)',48303,'�ζ���������','2015-08-06 13:45','I','2018-08-31 23:59',393248.5105,186475.2907);
--�� 254
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7196,3290000,'3.29E+17',to_date('2020-04-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-818-5975','�λ걤���� �λ����� ������ 667-16���� �̿���������','�λ걤���� �λ����� ������ 25, �̿��������� 201ȣ (������)',47247,'����Q �ܰ� ��������','2020-04-13 13:48','I','2020-04-15 0:23',387863.7161,186257.5075);
--�� 255
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7202,3300000,'3.30E+17',to_date('2020-06-03', 'YYYY-MM-DD'),1,'����/����',0,'����','515142470','�λ걤���� ������ ��õ�� 777-49����','�λ걤���� ������ �߾Ӵ��1381���� 43, 2�� (��õ��)',47728,'����������','2020-06-03 11:31','I','2020-06-05 0:23',388925.1298,192172.8389);
--�� 256
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7203,3320000,'3.32E+17',to_date('2020-04-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-342-5999','�λ걤���� �ϱ� ������ 918-13����','�λ걤���� �ϱ� ����3�� 55-1, 2�� (������)',46563,'������ ��������','2020-04-08 16:37','I','2020-04-10 0:23',384754.3119,192101.4961);
--�� 257
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7209,3330000,'3.33E+17',to_date('2020-06-05', 'YYYY-MM-DD'),1,'����/����',0,'����','051-742-7585','�λ걤���� �ؿ�뱸 �쵿 1435-3 ���Ͽ�����','�λ걤���� �ؿ�뱸 ������Ƽ3�� 37, ���Ͽ����� 207ȣ (�쵿)',48118,'������ ��������','2023-03-27 17:32','U','2023-03-29 2:40',395534.3219,186145.1302);
--�� 258
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7241,3330000,'3.33E+17',to_date('2020-05-06', 'YYYY-MM-DD'),1,'����/����',0,'����','051-711-5999','�λ걤���� �ؿ�뱸 �ݿ��� 1441-85 �ټغ���','�λ걤���� �ؿ�뱸 �����̷� 78, �ټغ��� 2�� (�ݿ���)',48037,'���ǵ����޵��ü���','2022-06-09 9:06','U','2022-06-11 2:40',392947.5294,191104.6491);
--�� 259
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7248,3360000,'3.36E+17',to_date('2020-04-06', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ������ 3357-2����','�λ걤���� ������ ��������8�� 233, 2�� 203ȣ (������)',46726,'Ȩ�� ��������','2020-04-23 10:22','U','2020-04-25 2:40',374846.3635,179403.949);
--�� 260
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7249,3390000,'3.39E+17',to_date('2020-06-09', 'YYYY-MM-DD'),1,'����/����',0,'����','517157979','�λ걤���� ��� �ַʵ� 191-17����','�λ걤���� ��� ���ߴ�� 325 (�ַʵ�)',47004,'������ ��������','2020-06-09 9:03','I','2020-06-11 0:23',382913.5352,185404.72);
--�� 261
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7293,3700000,'3.70E+17',to_date('2021-12-03', 'YYYY-MM-DD'),1,'����/����',0,'����','052-936-0075','��걤���� ���� ������ 717-2','��걤���� ���� �߾ӷ�28���� 2(������)',44755,'������������','2021-12-08 10:02','U','2021-12-10 2:40',410251.3404,227382.9986);
--�� 262
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7304,3290000,'3.29E+17',to_date('2021-11-12', 'YYYY-MM-DD'),1,'����/����',0,'����','051-818-1101','�λ걤���� �λ����� ������ 203-17','�λ걤���� �λ����� ������ 110-1(������)',47115,'ǳ�浿������','2021-11-12 9:20','I','2021-11-14 0:22',386858.3424,188687.2409);
--�� 263
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7326,3350000,'3.35E+17',to_date('2023-03-16', 'YYYY-MM-DD'),1,'����/����',0,'����','051-515-5179','�λ걤���� ������ ������ 615-6','�λ걤���� ������ �Ĺ����� 38, 1�� (������)',46297,'�ݺ���������','2023-03-16 8:58','I','2023-03-18 0:41',389697.6318,193741.7614);
--�� 264
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7344,3380000,'3.38E+17',to_date('2023-02-07', 'YYYY-MM-DD'),1,'����/����',0,'����','051-753-2966','�λ걤���� ������ ���̵� 803-10','�λ걤���� ������ ������ 296(���̵�)',48235,'����Ʈ������ ��������','2023-02-21 16:42','U','2023-02-23 2:40',391527.4307,187966.6296);
--�� 265
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7350,3350000,'3.35E+17',to_date('2023-03-21', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ������ 607-37','�λ걤���� ������ �Ĺ����� 11, 2�� (������)',46301,'���㵿���ǷἾ��','2023-03-21 17:37','I','2023-03-23 0:41',389912.897,193614.5837);
--�� 266
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7398,3330000,'3.33E+17',to_date('2001-04-02', 'YYYY-MM-DD'),1,'����/����',0,'����','703-6996','�λ걤���� �ؿ�뱸 �µ� 1289-4���� �Ѽֺ���','�λ걤���� �ؿ�뱸 �µ���ȯ�� 178, 2�� (�µ�)',48078,'�ŵ��õ�������','2012-03-26 15:36','I','2018-08-31 23:59',398114.7254,188646.7314);
--�� 267
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7399,3330000,'3.33E+17',to_date('2001-07-02', 'YYYY-MM-DD'),1,'����/����',0,'����','784-1235','�λ걤���� �ؿ�뱸 �ݿ��� 1291-1346����','�λ걤���� �ؿ�뱸 �ؿ���61���� 104 (�ݿ���)',48051,'Ǫ����������','2019-03-27 17:07','U','2019-03-29 2:40',393889.3996,190459.9555);
--�� 268
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7400,3330000,'3.33E+17',to_date('1995-03-22', 'YYYY-MM-DD'),1,'����/����',0,'����','784-0079','�λ걤���� �ؿ�뱸 ��۵� 1059-3����','�λ걤���� �ؿ�뱸 ��ݷ� 117-1, 2�� (��۵�)',48054,'��۵�������','2013-12-26 9:31','I','2018-08-31 23:59',393617.9119,189822.8846);
--�� 269
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7401,3330000,'3.33E+17',to_date('1996-11-29', 'YYYY-MM-DD'),1,'����/����',0,'����','704-7540','�λ걤���� �ؿ�뱸 �µ� 1327-5���� 10��۰�����','�λ걤���� �ؿ�뱸 �µ���ȯ�� 308, 3�� (�µ�)',48110,'���ɵ�������','2012-01-10 16:25','I','2018-08-31 23:59',398779.0602,187679.4036);
--�� 270
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7402,3330000,'3.33E+17',to_date('1999-01-22', 'YYYY-MM-DD'),1,'����/����',0,'����','704-7582','�λ걤���� �ؿ�뱸 �쵿 641-7����','�λ걤���� �ؿ�뱸 �ؿ��� 580, 4�� (�쵿)',48094,'���ؿ� �����ǷἾ��','2019-03-06 19:43','U','2019-03-08 2:40',396290.775,186797.7446);
--�� 271
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7403,3330000,'3.33E+17',to_date('2003-02-25', 'YYYY-MM-DD'),1,'����/����',0,'����','545-0041','�λ걤���� �ؿ�뱸 �ݼ۵� 257-248����','�λ걤���� �ؿ�뱸 �Ʒ��ݼ۷� 11-1 (�ݼ۵�)',48017,'�ݼ۵�������','2019-03-04 15:50','U','2019-03-06 2:40',395445.9279,193925.8128);
--�� 272
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7404,3300000,'3.30E+17',to_date('2014-05-12', 'YYYY-MM-DD'),1,'����/����',0,'����','515540010','�λ걤���� ������ ������ 676-112����','�λ걤���� ������ ������ 194, 1�� (������)',47747,'�� ��������','2019-11-19 12:51','U','2019-11-21 2:40',389597.477,192179.4203);
--�� 273
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7405,3300000,'3.30E+17',to_date('2016-03-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-555-4813','�λ걤���� ������ ���ȵ� 568����','�λ걤���� ������ ������ 90 (���ȵ�, ȣ���޵���)',47814,'�����ص�������','2019-01-17 10:30','U','2019-01-19 2:40',389730.5437,191213.3798);
--�� 274
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7406,3300000,'3.30E+17',to_date('2016-10-28', 'YYYY-MM-DD'),1,'����/����',0,'����','051-505-4088','�λ걤���� ������ ��õ�� 1266-4����','�λ걤���� ������ �ƽþƵ��� 207 (��õ��)',47852,'��õ��������','2019-01-17 10:31','U','2019-01-19 2:40',388057.9041,191229.0182);
--�� 275
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7407,3300000,'3.30E+17',to_date('2018-05-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-982-2580','�λ걤���� ������ ������ 64-24���� 1,2��','�λ걤���� ������ �ƽþƵ��� 160, 1,2�� (������)',47842,'�����������','2018-05-31 11:51','I','2018-08-31 23:59',388037.5021,190778.6013);
--�� 276
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7408,3300000,'3.30E+17',to_date('1992-01-14', 'YYYY-MM-DD'),1,'����/����',0,'����','504-1813','�λ걤���� ������ ������ 28-15����','�λ걤���� ������ �����Ϸ�63���� 11 (������)',47860,'�����ﺸ��������','2019-03-28 11:35','U','2019-03-30 2:40',387322.6727,190886.3262);
--�� 277
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7409,3300000,'3.30E+17',to_date('1998-01-13', 'YYYY-MM-DD'),1,'����/����',0,'����','555-8300','�λ걤���� ������ ������ 429-17����','�λ걤���� ������ ������98���� 1 (������)',47814,'�ѻ����������','2016-05-23 17:56','I','2018-08-31 23:59',389677.7442,191267.8055);
--�� 278
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7410,3300000,'3.30E+17',to_date('1998-02-26', 'YYYY-MM-DD'),1,'����/����',0,'����','552-3003','�λ걤���� ������ ������ 627-4����','�λ걤���� ������ ��Ĵ��237���� 148 (������)',47809,'������꺴��','2019-01-17 10:32','U','2019-01-19 2:40',389560.473,191788.2264);
--�� 279
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7411,3300000,'3.30E+17',to_date('2006-06-15', 'YYYY-MM-DD'),1,'����/����',0,'����','525-1275','�λ걤���� ������ �ȶ��� 469-8����','�λ걤���� ������ ����� 150 (�ȶ���)',47794,'�ʿ���������','2016-05-23 17:59','I','2018-08-31 23:59',392296.4456,190840.0906);
--�� 280
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7412,3300000,'3.30E+17',to_date('2012-07-10', 'YYYY-MM-DD'),1,'����/����',0,'����','524-8275','�λ걤���� ������ �ȶ��� 946-7����','�λ걤���� ������ �ݼ۷� 243 (�ȶ���)',47754,'�����Ǻ�������������','2020-02-20 10:49','U','2020-02-22 2:40',391075.3324,191261.0795);
--�� 281
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7413,3300000,'3.30E+17',to_date('2012-07-27', 'YYYY-MM-DD'),1,'����/����',0,'����','051-531-7582','�λ걤���� ������ �ȶ��� 64-1����','�λ걤���� ������ ��Ĵ�� 488 (�ȶ���)',47905,'�ٸ���������','2016-05-23 18:02','I','2018-08-31 23:59',392221.1881,190383.5461);
--�� 282
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7414,3300000,'3.30E+17',to_date('2013-04-19', 'YYYY-MM-DD'),1,'����/����',0,'����','555-2119','�λ걤���� ������ ���ȵ� 4-17','�λ걤���� ������ ������ 65, 1�� (���ȵ�)',47818,'���嵿������','2021-10-13 16:07','U','2021-10-15 2:40',389735.5106,190957.4117);
--�� 283
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7415,3300000,'3.30E+17',to_date('2008-02-22', 'YYYY-MM-DD'),1,'����/����',0,'����','506-7975','�λ걤���� ������ ������ 42-1����','�λ걤���� ������ ������70���� 50 (������)',47864,'�ڿ���������','2012-08-02 15:51','I','2018-08-31 23:59',387331.3603,190631.6142);
--�� 284
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7416,3300000,'3.30E+17',to_date('2012-03-19', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ��õ�� 402-21���� 22��4�� 105ȣ','�λ걤���� ������ �ݰ��� 69, 105ȣ (��õ��)',47706,'�������յ�������','2019-03-13 17:43','U','2019-03-15 2:40',389072.9541,192669.6585);
--�� 285
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7417,3300000,'3.30E+17',to_date('2014-04-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-557-7577','�λ걤���� ������ ��õ�� 177-2����','�λ걤���� ������ ������147���� 6 (��õ��)',47802,'�л굿������','2017-10-12 17:31','I','2018-08-31 23:59',389989.7061,191486.2968);
--�� 286
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7418,3300000,'3.30E+17',to_date('2014-05-01', 'YYYY-MM-DD'),1,'����/����',0,'����','051-506-8875','�λ걤���� ������ ��õ�� 1440-1','�λ걤���� ������ ��Ĵ�� 160, 1�� (��õ��)',47824,'��ī�̵�������','2020-06-29 15:51','U','2020-07-01 2:40',389112.3373,191433.4406);
--�� 287
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7419,3300000,'3.30E+17',to_date('1982-11-29', 'YYYY-MM-DD'),1,'����/����',0,'����','555-4130','�λ걤���� ������ ���ε� 288-58����','�λ걤���� ������ ��Ĵ�� 268-1 (���ε�)',47878,'�����������','2019-01-17 10:33','U','2019-01-19 2:40',390130.9977,191048.9997);
--�� 288
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7420,3300000,'3.30E+17',to_date('1990-07-07', 'YYYY-MM-DD'),1,'����/����',0,'����','051-556-8747','�λ걤���� ������ �ȶ��� 756-57����','�λ걤���� ������ �ȿ���98���� 4 (�ȶ���)',47894,'�ȶ���������','2019-01-17 10:33','U','2019-01-19 2:40',391004.4886,190526.7084);
--�� 289
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7421,3300000,'3.30E+17',to_date('1991-06-07', 'YYYY-MM-DD'),1,'����/����',0,'����','553-4409','�λ걤���� ������ ��õ�� 170-2����','�λ걤���� ������ �ݰ������� 11-1 (��õ��)',47711,'��������������','2019-01-17 10:34','U','2019-01-19 2:40',389584.1651,193008.3248);
--�� 290
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7422,3300000,'3.30E+17',to_date('1991-09-03', 'YYYY-MM-DD'),1,'����/����',0,'����','527-8742','�λ걤���� ������ ���嵿 29-4����','�λ걤���� ������ �ݼ۷� 265 (���嵿)',47752,'�Ѿ����յ�������','2019-01-17 10:35','U','2019-01-19 2:40',391225.7738,191419.5697);
--�� 291
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7578,3730000,'3.73E+17',to_date('2004-12-02', 'YYYY-MM-DD'),1,'����/����',0,'����','248-7582','��걤���� ���ֱ� ������ õ�� 639-6','��걤���� ���ֱ� ������ õ���߾ӱ� 47, �������������� 1��',44931,'��������������','2021-08-03 10:52','U','2021-08-05 2:40',402223.2502,231600.8952);
--�� 292
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7579,3730000,'3.73E+17',to_date('2006-01-04', 'YYYY-MM-DD'),1,'����/����',0,'����','264-7872','��걤���� ���ֱ� ����� ���θ� 232-1����','��걤���� ���ֱ� ����� ����õ5�� 14, �ٵ� 104ȣ (���λ�)',44944,'����������','2019-03-06 17:04','U','2019-03-08 2:40',391270.1869,231944.3553);
--�� 293
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7580,3730000,'3.73E+17',to_date('2007-03-14', 'YYYY-MM-DD'),1,'����/����',0,'����','052-262-6114','��걤���� ���ֱ� �ﳲ�� ������ 1499-264����','��걤���� ���ֱ� �ﳲ�� ���򰭺��� 3',44947,'�ʷϵ�������','2019-03-06 17:07','U','2019-03-08 2:40',392265.5738,231268.6629);
--�� 294
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7581,3730000,'3.73E+17',to_date('2007-03-31', 'YYYY-MM-DD'),1,'����/����',0,'����','052-239-7585','��걤���� ���ֱ� �¾��� �߸� 1311���� �¾缭��Ÿ����','��걤���� ���ֱ� �¾��� ����3�� 40 (�¾缭��Ÿ����)',44976,'�¾� �߸���������','2019-03-06 16:34','U','2019-03-08 2:40',408257.1255,214729.8141);
--�� 295
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7582,3730000,'3.73E+17',to_date('2011-08-17', 'YYYY-MM-DD'),1,'����/����',0,'����','225-0075','��걤���� ���ֱ� ����� ���θ� 370-15����','��걤���� ���ֱ� ����� ������ 135',44938,'�Ϳ쵿������','2019-03-06 16:58','U','2019-03-08 2:40',392401.1956,232134.5749);
--�� 296
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7583,3730000,'3.73E+17',to_date('2012-02-03', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� ����� ���θ� 265-2','��걤���� ���ֱ� ����� ��õ4�� 19-9, ����� �������� 1�� 101ȣ',44945,'����� ��������','2021-04-12 21:36','U','2021-04-14 2:40',391580.374,231645.4986);
--�� 297
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7584,3730000,'3.73E+17',to_date('2013-11-08', 'YYYY-MM-DD'),1,'����/����',0,'����','052-238-7511','��걤���� ���ֱ� �¾��� ��ȸ� 567-4','��걤���� ���ֱ� �¾��� ���� 12, ��â�̸���������',44978,'��â�̸���������','2023-02-27 17:15','U','2023-03-01 2:40',407047.4201,214885.5845);
--�� 298
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7585,3730000,'3.73E+17',to_date('2014-04-09', 'YYYY-MM-DD'),1,'����/����',0,'����','052-211-7599','��걤���� ���ֱ� ������ ������ 386-1����','��걤���� ���ֱ� ������ ����6�� 5',44925,'BB��������','2019-03-06 13:12','U','2019-03-08 2:40',403304.2445,232196.9548);
--�� 299
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7586,3730000,'3.73E+17',to_date('2014-07-04', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �»��� ���Ÿ� 561����','��걤���� ���ֱ� �»��� ���ŷ� 250',45005,'MK��������','2019-03-06 13:13','U','2019-03-08 2:40',409585.8342,217298.3277);
--�� 300
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7587,3730000,'3.73E+17',to_date('1995-08-31', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �ε��� ���踮 925-2����','��걤���� ���ֱ� �ε��� ���̿���� 787',44914,'��絿������','2019-10-17 15:46','U','2019-10-19 2:40',399694.1951,247100.8615);
--�� 301
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7588,3730000,'3.73E+17',to_date('1983-07-15', 'YYYY-MM-DD'),1,'����/����',0,'����','052-262-4888','��걤���� ���ֱ� �ﳲ�� ������ 355-7����','��걤���� ���ֱ� �ﳲ�� ����� 79',NULL,'���ϵ�������','2019-03-06 17:05','U','2019-03-08 2:40',392264.0614,231197.4418);
--�� 302
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7589,3730000,'3.73E+17',to_date('1996-04-01', 'YYYY-MM-DD'),1,'����/����',0,'����','052-262-6797','��걤���� ���ֱ� �ε��� ���踮 525���� �����緡���� 203ȣ','��걤���� ���ֱ� �ε��� ���3�� 9, �����緡���� 203ȣ',44914,'������������','2019-03-06 16:10','U','2019-03-08 2:40',398939.8395,248151.2859);
--�� 303
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7590,3730000,'3.73E+17',to_date('1976-01-19', 'YYYY-MM-DD'),1,'����/����',0,'����','052-262-1076','��걤���� ���ֱ� ����� ���θ� 133-3����','��걤���� ���ֱ� ����� ����8�� 19-6',44941,'�뵿��������','2019-03-06 13:26','U','2019-03-08 2:40',392734.5626,231524.1954);
--�� 304
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7591,3730000,'3.73E+17',to_date('1997-07-31', 'YYYY-MM-DD'),1,'����/����',0,'����','052-264-6708','��걤���� ���ֱ� ����� ���θ�','��걤���� ���ֱ� ����� ������ 20, ���� 1��',44946,'���������������','2016-08-02 17:31','I','2018-08-31 23:59',391938.0204,231649.6757);
--�� 305
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7592,3730000,'3.73E+17',to_date('1979-12-15', 'YYYY-MM-DD'),1,'����/����',0,'����','268-9074','��걤���� ���ֱ� û���� �󳲸� 577-1����','��걤���� ���ֱ� û���� �������ͱ� 7',44984,'���ϵ�������','2019-03-06 17:07','U','2019-03-08 2:40',409171.5224,223786.2137);
--�� 306
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7593,3730000,'3.73E+17',to_date('2016-08-11', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� ����� �±⸮ 693-7','��걤���� ���ֱ� ����� �±�� 23-6',44935,'�ڵ�������','2022-12-30 16:56','U','2023-01-01 2:40',393590.5449,234262.7986);
--�� 307
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7594,3730000,'3.73E+17',to_date('2017-04-24', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �ﳲ�� ������ 1555-1���� ��� ���� ����������Ʈ ��2�� 202ȣ','��걤���� ���ֱ� �ﳲ�� �ⱳ�� 164, 2�� 202ȣ (��� ���� ����������Ʈ)',44949,'�߻굿������','2019-03-06 17:06','U','2019-03-08 2:40',391566.8817,231231.8495);
--�� 308
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7595,3730000,'3.73E+17',to_date('2017-07-03', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �ﳲ�� ��⸮ 176-6����','��걤���� ���ֱ� �ﳲ�� �Ϲ�� 27',44955,'����ȣ ��������','2019-03-06 15:48','U','2019-03-08 2:40',389524.6529,224884.2421);
--�� 309
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7596,3730000,'3.73E+17',to_date('2018-01-22', 'YYYY-MM-DD'),1,'����/����',0,'����','','��걤���� ���ֱ� �ﳲ�� ��ȭ�� 1481-29����','��걤���� ���ֱ� �ﳲ�� �߳��� 72, 3��',44953,'���ε�������','2019-03-06 13:44','U','2019-03-08 2:40',391184.6147,228477.6967);
--�� 310
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7643,3690000,'3.69E+17',to_date('2020-07-09', 'YYYY-MM-DD'),1,'����/����',0,'����','052-713-7575','��걤���� �߱� ��ȭ�� 123-2','��걤���� �߱� ��ȭ�� 250 (��ȭ��)',44456,'���������ǷἾ��','2020-07-12 18:00','U','2020-07-14 2:40',408742.38,230578.0873);
--�� 311
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7648,3380000,'3.38E+17',to_date('2020-07-03', 'YYYY-MM-DD'),1,'����/����',0,'����','051-757-1275','�λ걤���� ������ �ζ��� 774 ���Һ�Ÿ����2�� �� 401�� 203ȣ','�λ걤���� ������ ���з�63���� 142, 401�� 2�� 203ȣ (�ζ���, ���Һ�Ÿ����2��)',48272,'����Ĺ �����̺���','2020-07-13 13:22','U','2020-07-15 2:40',393053.9747,187433.2652);
--�� 312
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7674,3330000,'3.33E+17',to_date('2020-08-19', 'YYYY-MM-DD'),1,'����/����',0,'����','051-782-7275','�λ걤���� �ؿ�뱸 ��۵� 369-1','�λ걤���� �ؿ�뱸 �ؿ���177���� 6 (��۵�)',48056,'��â�� ��������','2020-09-14 17:15','U','2020-09-16 2:40',393347.123,189033.8418);
--�� 313
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7698,3330000,'3.33E+17',to_date('2021-08-10', 'YYYY-MM-DD'),1,'����/����',0,'����','051-702-8275','�λ걤���� �ؿ�뱸 �µ� 1486-1 ��Ȳ����','�λ걤���� �ؿ�뱸 ���� 40, ��Ȳ���� 301ȣ (�µ�)',48111,'�ؿ�뵿���޵��ü���','2021-08-31 12:40','U','2021-09-02 2:40',398342.925,187510.7976);
--�� 314
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7699,3300000,'3.30E+17',to_date('2021-09-07', 'YYYY-MM-DD'),1,'����/����',0,'����','051-505-7578','�λ걤���� ������ ��õ�� 1250-8 �������̴ϵ��','�λ걤���� ������ �ƽþƵ��� 209, 2�� (��õ��, �������̴ϵ��)',47851,'���������ǷἾ��','2021-10-29 16:15','U','2021-10-31 2:40',388064.6091,191257.7432);
--�� 315
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7700,3300000,'3.30E+17',to_date('2021-07-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-552-6800','�λ걤���� ������ ��õ�� 180-14 ��õ�忪�����׸��ھƴ���Ƽ','�λ걤���� ������ �߾Ӵ��1473���� 24, ��õ�忪�����׸��ھƴ���Ƽ �󰡵� 109~110ȣ (��õ��)',47711,'�¸�����������','2021-07-08 11:55','I','2021-07-10 0:22',389550.0051,192966.7933);
--�� 316
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7716,3360000,'3.36E+17',to_date('2021-08-17', 'YYYY-MM-DD'),1,'����/����',0,'����','051-972-0972','�λ걤���� ������ ��ȣ�� 304-9','�λ걤���� ������ ��ȣ���1�� 124, 103ȣ (��ȣ��)',46760,'��ȣ��������','2021-08-17 18:39','I','2021-08-19 0:22',371138.9765,177398.8558);
--�� 317
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7741,3310000,'3.31E+17',to_date('2021-09-01', 'YYYY-MM-DD'),1,'����/����',0,'����','517117515','�λ걤���� ���� �뿬�� 29-1','�λ걤���� ���� ������ 364, 4�� (�뿬��)',48509,'���� �ܰ������ǷἾ��','2022-03-22 10:08','U','2022-03-24 2:40',391808.9157,184281.9547);
--�� 318
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7779,3300000,'3.30E+17',to_date('2022-12-28', 'YYYY-MM-DD'),1,'����/����',0,'����','051-513-6060','�λ걤���� ������ ��õ�� 456-29 ��ȭŸ������Ʈ','�λ걤���� ������ ��õ��� 20, 1�� (��õ��, ��ȭŸ������Ʈ)',47714,'24�� ���޵����ǷἾ��','2023-03-30 16:17','U','2023-04-01 2:40',389289.7675,192509.9942);
--�� 319
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7780,3260000,'3.26E+17',to_date('2022-12-06', 'YYYY-MM-DD'),1,'����/����',0,'����','051-710-0719','�λ걤���� ���� �ϳ��� 123-15 �۵���������Ʈ�������̽�Ƽ����Ʈ','�λ걤���� ���� �۵��غ��� 192, ��B�� 2�� 201ȣ (�ϳ���, �۵���������Ʈ�������̽�Ƽ����Ʈ)',49264,'���̽�Ƽ ��������','2022-12-06 10:02','I','2022-12-08 0:40',384495.0667,177326.0295);
--�� 320
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7806,3330000,'3.33E+17',to_date('2021-06-25', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ؿ�뱸 �쵿 1488 �����帶ũ���Ҿ���Ʈ','�λ걤���� �ؿ�뱸 ���ҵ��� 25, B�󰡵� 203ȣ (�쵿, �����帶ũ���Ҿ���Ʈ)',48059,'�����ɾ� ��������','2022-02-18 9:38','U','2022-02-20 2:40',394112.5249,187887.9317);
--�� 321
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (7856,3320000,'3.32E+17',to_date('2021-06-08', 'YYYY-MM-DD'),1,'����/����',0,'����','051-908-7575','�λ걤���� �ϱ� ��õ�� 561-2 ä��Ʈ��','�λ걤���� �ϱ� �ݰ��� 126, ä��Ʈ�� 3�� (��õ��)',46545,'���ൿ���ǷἾ��','2021-06-08 19:45','I','2021-06-10 0:22',382766.7643,193052.6885);
--�� 322
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8480,3320000,'3.32E+17',to_date('2018-09-20', 'YYYY-MM-DD'),1,'����/����',0,'����','051-333-7584','�λ걤���� �ϱ� ȭ���� 2277-4���� ���Ѱ���','�λ걤���� �ϱ� �ݰ��� 287, ���Ѱ��� 2�� 202,203ȣ (ȭ����)',46526,'�� ��������','2019-03-27 14:50','U','2019-03-29 2:40',383206.814,194624.5038);
--�� 323
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8499,3290000,'3.29E+17',to_date('2020-09-09', 'YYYY-MM-DD'),1,'����/����',0,'����','051-808-5550','�λ걤���� �λ����� ������ 263-36','�λ걤���� �λ����� ���Ϸ� 218 (������)',47127,'���������ǷἾ��','2020-09-09 14:35','I','2020-09-11 0:23',386576.1236,188193.2817);
--�� 324
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8500,3720000,'3.72E+17',to_date('2020-09-07', 'YYYY-MM-DD'),1,'����/����',0,'����','052-713-7582','��걤���� �ϱ� ������ 1235-4','��걤���� �ϱ� �ڻ���11�� 1, 203,204,205ȣ (������)',44236,'���ϴ� �����޵��ü���','2022-01-03 16:32','U','2022-01-05 2:40',414148.3858,235960.4524);
--�� 325
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8508,3380000,'3.38E+17',to_date('2020-10-06', 'YYYY-MM-DD'),1,'����/����',0,'����','051-753-7582','�λ걤���� ������ �ζ��� 110-82 3��','�λ걤���� ������ �����غ���370���� 9-8, ������� 3�� (�ζ���)',48280,'������ �����Ǻΰ�����','2020-10-06 19:35','I','2020-10-08 0:23',394369.8731,186131.0946);
--�� 326
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8513,3290000,'3.29E+17',to_date('2020-10-19', 'YYYY-MM-DD'),1,'����/����',0,'����','518065000','�λ걤���� �λ����� �ξϵ� 318-76 ������������Ƽ����ũ����Ʈ','�λ걤���� �λ����� ����� 173, 207,208ȣ (�ξϵ�, ������������Ƽ����ũ����Ʈ)',47141,'��𵿹�����','2020-10-19 10:02','I','2020-10-21 0:23',386480.1877,187219.3063);
--�� 327
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8518,3270000,'3.27E+17',to_date('2020-10-29', 'YYYY-MM-DD'),1,'����/����',0,'����','051-638-9977','�λ걤���� ���� ���ϵ� 325-3','�λ걤���� ���� ���Ϸ� 64(���ϵ�)',48747,'������������','2022-06-08 10:18','U','2022-06-10 2:40',387652.2424,183763.9158);
--�� 328
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8523,3350000,'3.35E+17',to_date('2020-11-03', 'YYYY-MM-DD'),1,'����/����',0,'����','051-515-7272','�λ걤���� ������ ������ 471-8','�λ걤���� ������ �ݰ���403���� 1, 2�� (������)',46245,'����������','2020-11-03 16:15','I','2020-11-05 0:23',389908.8959,195823.1149);
--�� 329
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8549,3300000,'3.30E+17',to_date('2022-10-14', 'YYYY-MM-DD'),1,'����/����',0,'����','051-531-8275','�λ걤���� ������ �ȶ��� 633-4 ��������','�λ걤���� ������ �ȿ��� 72, �������� 1�� (�ȶ���)',47901,'������������','2022-10-25 13:58','U','2022-10-27 2:40',391100.1762,190292.6509);
--�� 330
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8568,3320000,'3.32E+17',to_date('2022-09-05', 'YYYY-MM-DD'),1,'����/����',0,'����','051-714-5251','�λ걤���� �ϱ� ȭ���� 190-2 ��������','�λ걤���� �ϱ� �ݰ��� 366, �������� 1�� (ȭ����)',46517,'��׵����ǷἾ��','2022-09-05 16:23','I','2022-09-07 0:22',383283.3027,195388.5103);
--�� 331
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8580,3330000,'3.33E+17',to_date('2021-04-12', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� �ؿ�뱸 �ݿ��� 1190-1 ���ż������Ʈ','�λ걤���� �ؿ�뱸 ���� 61, 201ȣ (�ݿ���, ���ż������Ʈ)',48046,'�ູ�帲 ��������','2021-09-24 19:07','U','2021-09-26 2:40',392600.0999,191419.5175);
--�� 332
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8586,3400000,'3.40E+17',to_date('2021-02-18', 'YYYY-MM-DD'),1,'����/����',0,'����','517217975','�λ걤���� ���屺 �ϱ��� �Ｚ�� 830-8 ��ŸŸ����, 301,302ȣ','�λ걤���� ���屺 �ϱ��� �غ�6�� 85-4, ��ŸŸ���� 3�� 301,302ȣ',46048,'�ϱ��غ���������','2021-02-18 9:01','I','2021-02-20 0:23',402594.2917,198486.9329);
--�� 333
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8595,3290000,'3.29E+17',to_date('2021-03-02', 'YYYY-MM-DD'),1,'����/����',0,'����','051-819-6061','�λ걤���� �λ����� ������ 876-7','�λ걤���� �λ����� ������ 152 (������)',47241,'24�� �µ����ǷἾ��','2022-11-09 13:26','U','2022-11-11 2:40',387881.1591,186682.8442);
--�� 334
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8602,3300000,'3.30E+17',to_date('2021-03-23', 'YYYY-MM-DD'),1,'����/����',0,'����','051-555-1125','�λ걤���� ������ ���ε� 205-12','�λ걤���� ������ ��Ĵ�� 288 (���ε�)',47879,'��Ƹ���������','2021-03-23 13:17','I','2021-03-25 0:22',390306.7341,190985.686);
--�� 335
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8606,3330000,'3.33E+17',to_date('2021-02-10', 'YYYY-MM-DD'),1,'����/����',0,'����','051-747-1275','�λ걤���� �ؿ�뱸 �ߵ� 942-6','�λ걤���� �ؿ�뱸 �޸��̱� 58, 2�� (�ߵ�)',48097,'���� ��������','2021-11-18 10:38','U','2021-11-20 2:40',397748.0983,186818.8506);
--�� 336
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8620,3300000,'3.30E+17',to_date('2021-03-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-711-0006','�λ걤���� ������ ������ 506-13 ��������','�λ걤���� ������ ��Ĵ�� 194, �������� 2�� (������)',47815,'24�� ���������ǷἾ��','2023-02-15 13:42','U','2023-02-18 2:40',389439.9718,191276.3279);
--�� 337
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8623,3400000,'3.40E+17',to_date('2021-03-26', 'YYYY-MM-DD'),1,'����/����',0,'����','517247570','�λ걤���� ���屺 �ϱ��� �Ｚ�� 825-2 �ϱ�����������, 2�� 203ȣ','�λ걤���� ���屺 �ϱ��� �غ��� 13, �ϱ����������� 2�� 203ȣ',46048,'�ٸ����� ��������','2021-03-26 9:26','I','2021-03-28 0:22',402521.1775,198590.0505);
--�� 338
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (8630,3300000,'3.30E+17',to_date('2021-03-31', 'YYYY-MM-DD'),1,'����/����',0,'����','051-711-0006','�λ걤���� ������ ������ 506-13 ��������','�λ걤���� ������ ��Ĵ�� 194, �������� 3�� (������)',47815,'24�� ��������������','2023-02-15 13:12','U','2023-02-18 2:40',389439.9718,191276.3279);
--�� 339
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9097,3360000,'3.36E+17',to_date('2022-07-08', 'YYYY-MM-DD'),1,'����/����',0,'����','','�λ걤���� ������ ������ 3597-5','�λ걤���� ������ ��������2�� 29, 203ȣ (������)',46726,'���� ����������','2022-07-11 9:28','U','2022-07-13 2:40',373808.7564,178891.0303);
--�� 340
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9099,3340000,'3.34E+17',to_date('2022-07-06', 'YYYY-MM-DD'),1,'����/����',0,'����','051-717-2316','�λ걤���� ���ϱ� �ٴ뵿 1548-47','�λ걤���� ���ϱ� �ٴ�� 700, 2�� (�ٴ뵿)',49505,'���ٸ� ��������','2022-07-14 16:58','U','2022-07-16 2:40',379207.7254,173951.8004);
--�� 341
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9113,3360000,'3.36E+17',to_date('2022-07-12', 'YYYY-MM-DD'),1,'����/����',0,'����','051-711-7581','�λ걤���� ������ ������ 3420-7','�λ걤���� ������ ��������8�� 270, 1�� 202ȣ (������)',46772,'��︲�����޵��ü���','2022-07-12 14:26','I','2022-07-14 0:22',375192.2933,179291.2555);
--�� 342
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9550,3330000,'3.33E+17',to_date('2018-11-19', 'YYYY-MM-DD'),1,'����/����',0,'����','051-701-7588','�λ걤���� �ؿ�뱸 �µ� 1479-3���� ��������������','�λ걤���� �ؿ�뱸 �ؿ��� 814, �������������� A�� 301ȣ (�µ�)',48111,'��������������','2019-11-18 15:01','U','2019-11-20 2:40',398330.5165,187771.5114);
--�� 343
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9569,3710000,'3.71E+17',to_date('2020-12-05', 'YYYY-MM-DD'),1,'����/����',0,'����','522327575','��걤���� ���� �ϻ굿 945','��걤���� ���� �������ȯ���� 652, �׶���ũ 301,302,304ȣ (�ϻ굿)',44056,'ôô �����ǷἾ��','2021-07-14 14:45','U','2021-07-16 2:40',420356.2744,224949.0991);
--�� 344
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9578,3400000,'3.40E+17',to_date('2020-12-02', 'YYYY-MM-DD'),1,'����/����',0,'����','051-755-1175','�λ걤���� ���屺 ������ ��� 417-16','�λ걤���� ���屺 ������ ������ 286',46066,'��� ��������','2020-12-02 10:57','I','2020-12-04 0:23',401439.6919,195982.2579);
--�� 345
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9583,3330000,'3.33E+17',to_date('2021-01-21', 'YYYY-MM-DD'),1,'����/����',0,'����','051-751-7585','�λ걤���� �ؿ�뱸 �쵿 1405 ������ũ','�λ걤���� �ؿ�뱸 ������Ƽ2�� 2, ������ũ 208~209ȣ (�쵿)',48092,'������ũ ��������','2023-02-15 16:14','U','2023-02-18 2:40',394304.2715,187325.7713);
--�� 346
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9600,3370000,'3.37E+17',to_date('2021-01-13', 'YYYY-MM-DD'),1,'����/����',0,'����','051-791-0175','�λ걤���� ������ ���굿 1953-1','�λ걤���� ������ ������ 135 (���굿)',47603,'���굿���ǷἾ��','2023-02-03 16:38','U','2023-02-05 2:40',389916.4819,188188.0447);
--�� 347
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9614,3340000,'3.34E+17',to_date('2022-04-29', 'YYYY-MM-DD'),1,'����/����',0,'����','051-714-2435','�λ걤���� ���ϱ� ���� 569-51','�λ걤���� ���ϱ� ��������� 713, 1�� (����)',49396,'�ູ�� ��������','2022-05-11 18:47','U','2022-05-13 2:40',380804.6773,178043.9189);
--�� 348
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9647,3270000,'3.27E+17',to_date('2022-05-04', 'YYYY-MM-DD'),1,'����/����',0,'����','051-465-7582','�λ걤���� ���� �ʷ��� 1145-9 ��ȭ�ϴϿ� ����Ƽ �ְ��๰��1��','�λ걤���� ���� ������ 48, ��ȭ�ϴϿ� ����Ƽ �ְ��๰��1�� 103ȣ (�ʷ���)',48792,'����� ��������','2022-05-11 13:29','U','2022-05-13 2:40',386216.078,182410.0825);
--�� 349
INSERT INTO HOSPITAL_DATA (HD_ID, HD_CODE, HD_MANAGE, HD_PERDATE, HD_STATUSCODE, HD_SATUSNAME, HD_DETAILCODE, HD_DETAILNAME, HD_TEL, HD_ADDRESS_GENERAL, HD_ADDRESS_ROAD, HD_ADDRESS_ROADNUM, HD_NAME, HD_ADIT_DATE, HD_ADIT_GUBUN, HD_ADIT_RESDATE, HD_LNG, HD_LAT) VALUES (9657,3340000,'3.34E+17',to_date('2022-05-19', 'YYYY-MM-DD'),1,'����/����',0,'����','051-265-0114','�λ걤���� ���ϱ� �帲�� 325-67','�λ걤���� ���ϱ� �帲������ 41, 1�� (�帲��)',49475,'��Ƶ�������','2022-12-30 16:16','U','2023-01-01 2:40',379594.3462,177529.7771);


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