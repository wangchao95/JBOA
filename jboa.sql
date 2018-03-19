prompt PL/SQL Developer import file
prompt Created on 2013��10��29�� by weiyun.zhang
set feedback off
set define off

CREATE SEQUENCE SEQ_VOUCHER INCREMENT BY 1 START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;
CREATE SEQUENCE SEQ_VOUCHER_DETAIL INCREMENT BY 1 START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;
CREATE SEQUENCE SEQ_CHECK_RESULT INCREMENT BY 1 START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;
CREATE SEQUENCE SEQ_LEAVE INCREMENT BY 1 START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;
CREATE SEQUENCE hibernate_sequence INCREMENT BY 1 START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;

prompt Creating SYS_DEPARTMENT...
create table SYS_DEPARTMENT
(
  ID   NUMBER(10) not null,
  NAME VARCHAR2(50) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table SYS_DEPARTMENT
  add constraint DEPARTMENT_ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_EMPLOYEE...
create table SYS_EMPLOYEE
(
  SN            VARCHAR2(50) not null,
  POSITION_ID   NUMBER(10) not null,
  DEPARTMENT_ID NUMBER(10) not null,
  NAME          VARCHAR2(50) not null,
  PASSWORD      VARCHAR2(50) not null,
  STATUS        VARCHAR2(20) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SYS_EMPLOYEE
  add constraint SN primary key (SN)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SYS_EMPLOYEE
  add constraint DEPART_ID foreign key (DEPARTMENT_ID)
  references SYS_DEPARTMENT (ID);

prompt Creating BIZ_CLAIM_VOUCHER...
create table BIZ_CLAIM_VOUCHER
(
  ID            NUMBER(10) not null,
  NEXT_DEAL_SN  VARCHAR2(50),
  CREATE_SN     VARCHAR2(50) not null,
  CREATE_TIME   DATE not null,
  EVENT         VARCHAR2(255) not null,
  TOTAL_ACCOUNT NUMBER(20,2) not null,
  STATUS        VARCHAR2(20) not null,
  MODIFY_TIME   DATE
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER
  add constraint CLAIM_ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER
  add constraint E_SN foreign key (CREATE_SN)
  references SYS_EMPLOYEE (SN);
alter table BIZ_CLAIM_VOUCHER
  add constraint F_SN foreign key (NEXT_DEAL_SN)
  references SYS_EMPLOYEE (SN);

prompt Creating BIZ_CHECK_RESULT...
create table BIZ_CHECK_RESULT
(
  ID         NUMBER(10) not null,
  CLAIM_ID   NUMBER(10) not null,
  CHECK_TIME DATE not null,
  CHECKER_SN VARCHAR2(50) not null,
  RESULT     VARCHAR2(50) not null,
  COMM       VARCHAR2(500) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CHECK_RESULT
  add constraint CID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CHECK_RESULT
  add constraint FK_CLAIM_ID foreign key (CLAIM_ID)
  references BIZ_CLAIM_VOUCHER (ID);

prompt Creating BIZ_CLAIM_VOUCHER_DETAIL...
create table BIZ_CLAIM_VOUCHER_DETAIL
(
  ID      NUMBER(10) not null,
  MAIN_ID NUMBER(10) not null,
  ITEM    VARCHAR2(20) not null,
  ACCOUNT NUMBER(20,2) not null,
  DES     VARCHAR2(200) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER_DETAIL
  add constraint DETAIL_ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER_DETAIL
  add constraint CLAIME_ID foreign key (MAIN_ID)
  references BIZ_CLAIM_VOUCHER (ID);

prompt Creating BIZ_CLAIM_VOUCHER_STATISTICS...
create table BIZ_CLAIM_VOUCHER_STATISTICS
(
  ID            NUMBER(10) not null,
  TOTAL_COUNT   NUMBER(20,2) not null,
  YEAR          NUMBER(4) not null,
  MONTH         NUMBER(2) not null,
  DEPARTMENT_ID NUMBER(10) not null,
  MODIFY_TIME   DATE not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER_STATISTICS
  add constraint ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUCHER_STATISTICS
  add constraint DEPTID_ID foreign key (DEPARTMENT_ID)
  references SYS_DEPARTMENT (ID);

prompt Creating BIZ_CLAIM_VOUYEAR__STATISTICS...
create table BIZ_CLAIM_VOUYEAR__STATISTICS
(
  ID            NUMBER(10) not null,
  TOTAL_COUNT   NUMBER(30,2) not null,
  YEAR          NUMBER(4) not null,
  MODIFY_TIME   DATE not null,
  DEPARTMENT_ID NUMBER(10) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BIZ_CLAIM_VOUYEAR__STATISTICS
  add constraint SID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating BIZ_LEAVE...
create table BIZ_LEAVE
(
  ID              NUMBER(10) not null,
  EMPLOYEE_SN     VARCHAR2(50) not null,
  STARTTIME       DATE not null,
  ENDTIME         DATE not null,
  LEAVEDAY        NUMBER(5,1) not null,
  REASON          VARCHAR2(500) not null,
  STATUS          VARCHAR2(20),
  LEAVETYPE       VARCHAR2(50),
  NEXT_DEAL_SN    VARCHAR2(50),
  APPROVE_OPINION VARCHAR2(100),
  CREATETIME      DATE,
  MODIFYTIME      DATE
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table BIZ_LEAVE
  add constraint LEAVE_ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_POSITION...
create table SYS_POSITION
(
  ID      NUMBER(10) not null,
  NAME_CN VARCHAR2(50) not null,
  NAME_EN VARCHAR2(50) not null
)
tablespace JBOADB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SYS_POSITION
  add constraint POSIT_ID primary key (ID)
  using index 
  tablespace JBOADB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for SYS_DEPARTMENT...
alter table SYS_DEPARTMENT disable all triggers;
prompt Disabling triggers for SYS_EMPLOYEE...
alter table SYS_EMPLOYEE disable all triggers;
prompt Disabling triggers for BIZ_CLAIM_VOUCHER...
alter table BIZ_CLAIM_VOUCHER disable all triggers;
prompt Disabling triggers for BIZ_CHECK_RESULT...
alter table BIZ_CHECK_RESULT disable all triggers;
prompt Disabling triggers for BIZ_CLAIM_VOUCHER_DETAIL...
alter table BIZ_CLAIM_VOUCHER_DETAIL disable all triggers;
prompt Disabling triggers for BIZ_CLAIM_VOUCHER_STATISTICS...
alter table BIZ_CLAIM_VOUCHER_STATISTICS disable all triggers;
prompt Disabling triggers for BIZ_CLAIM_VOUYEAR__STATISTICS...
alter table BIZ_CLAIM_VOUYEAR__STATISTICS disable all triggers;
prompt Disabling triggers for BIZ_LEAVE...
alter table BIZ_LEAVE disable all triggers;
prompt Disabling triggers for SYS_POSITION...
alter table SYS_POSITION disable all triggers;
prompt Disabling foreign key constraints for SYS_EMPLOYEE...
alter table SYS_EMPLOYEE disable constraint DEPART_ID;
prompt Disabling foreign key constraints for BIZ_CLAIM_VOUCHER...
alter table BIZ_CLAIM_VOUCHER disable constraint E_SN;
alter table BIZ_CLAIM_VOUCHER disable constraint F_SN;
prompt Disabling foreign key constraints for BIZ_CHECK_RESULT...
alter table BIZ_CHECK_RESULT disable constraint FK_CLAIM_ID;
prompt Disabling foreign key constraints for BIZ_CLAIM_VOUCHER_DETAIL...
alter table BIZ_CLAIM_VOUCHER_DETAIL disable constraint CLAIME_ID;
prompt Disabling foreign key constraints for BIZ_CLAIM_VOUCHER_STATISTICS...
alter table BIZ_CLAIM_VOUCHER_STATISTICS disable constraint DEPTID_ID;
prompt Loading SYS_DEPARTMENT...
insert into SYS_DEPARTMENT (ID, NAME)
values (1, '���²�');
insert into SYS_DEPARTMENT (ID, NAME)
values (2, 'ƽ̨�з���');
insert into SYS_DEPARTMENT (ID, NAME)
values (3, '��Ʒ��Ʋ�');
insert into SYS_DEPARTMENT (ID, NAME)
values (4, '����');
insert into SYS_DEPARTMENT (ID, NAME)
values (5, '�ܲð칫��');
commit;
prompt 5 records loaded
prompt Loading SYS_EMPLOYEE...
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('017', 1, 1, '��Сΰ', '202cb962ac59075b964b07152d234b70', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('001', 1, 2, '��ƽ', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('002', 2, 2, 'Ҷ��', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('003', 3, 3, '��ΰ', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('004', 4, 4, '��С��', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('005', 1, 3, '�ַ�', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('006', 1, 3, '�Ŵ���', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('011', 1, 1, '���ΰ1', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('007', 1, 1, '���ΰ', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('008', 3, 5, '����', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('009', 4, 4, '���', '123', '��ְ');
insert into SYS_EMPLOYEE (SN, POSITION_ID, DEPARTMENT_ID, NAME, PASSWORD, STATUS)
values ('018', 1, 1, '���ΰ', '123', '��ְ');
commit;
prompt 10 records loaded
prompt Loading BIZ_CLAIM_VOUCHER...
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (100, null, '001', to_date('06-09-2013 13:29:30', 'dd-mm-yyyy hh24:mi:ss'), '����', 600, '����ֹ', to_date('13-09-2013 15:29:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (102, '001', '001', to_date('06-09-2013 13:41:50', 'dd-mm-yyyy hh24:mi:ss'), '��˾ҵ��', 6500.23, '�´���', to_date('13-09-2013 15:02:09', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (1, null, '001', to_date('02-07-2013 08:30:00', 'dd-mm-yyyy hh24:mi:ss'), '����', 200.55, '�Ѹ���', to_date('27-08-2013', 'dd-mm-yyyy'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (2, null, '005', to_date('08-08-2013 09:30:00', 'dd-mm-yyyy hh24:mi:ss'), '����', 1200.01, '�Ѹ���', to_date('29-08-2013', 'dd-mm-yyyy'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (3, '004', '006', to_date('08-08-2013 10:30:00', 'dd-mm-yyyy hh24:mi:ss'), '����ͻ�', 8535.59, '������', to_date('18-09-2013 11:18:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (4, null, '001', to_date('29-08-2013 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), '��ĩ�Ӱ�', 128.01, '�Ѹ���', to_date('02-09-2013 09:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (7, '004', '001', to_date('03-09-2013 05:00:00', 'dd-mm-yyyy hh24:mi:ss'), '��ĩ�Ӱ�', 5132.51, '������', to_date('18-09-2013 11:19:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (8, '001', '001', to_date('03-09-2013 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), '��ĩ�Ӱ�', 132.51, '�Ѵ��', to_date('03-09-2013 09:00:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (6, null, '002', to_date('01-07-2013', 'dd-mm-yyyy'), '��ĩ�Ӱ�', 400, '�Ѹ���', to_date('20-07-2013', 'dd-mm-yyyy'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (128, '001', '001', to_date('10-09-2013 13:47:42', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (151, null, '017', to_date('14-10-2013 17:34:29', 'dd-mm-yyyy hh24:mi:ss'), '���', 50, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (200, null, '001', to_date('23-10-2013 13:47:44', 'dd-mm-yyyy hh24:mi:ss'), '123', 34, '�´���', to_date('23-10-2013 13:47:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (202, null, '001', to_date('23-10-2013 13:48:27', 'dd-mm-yyyy hh24:mi:ss'), '11', 22, '�´���', to_date('23-10-2013 13:52:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (129, '001', '001', to_date('10-09-2013 14:05:47', 'dd-mm-yyyy hh24:mi:ss'), '�⽻������', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (133, '001', '001', to_date('13-09-2013 15:21:52', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 888, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (132, '001', '001', to_date('13-09-2013 15:18:39', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 388, '�´���', to_date('13-09-2013 15:19:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (181, null, '003', to_date('22-10-2013 17:27:55', 'dd-mm-yyyy hh24:mi:ss'), '���', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (192, null, '003', to_date('23-10-2013 10:52:09', 'dd-mm-yyyy hh24:mi:ss'), '���', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (198, null, '001', to_date('23-10-2013 13:45:32', 'dd-mm-yyyy hh24:mi:ss'), '123', 44, '�´���', to_date('23-10-2013 13:47:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (175, null, '001', to_date('22-10-2013 16:13:03', 'dd-mm-yyyy hh24:mi:ss'), '123', 12, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (5, '002', '001', to_date('01-08-2013', 'dd-mm-yyyy'), '��ĩ�Ӱ�', 45.01, '���ύ', to_date('31-08-2013', 'dd-mm-yyyy'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (107, '004', '001', to_date('06-09-2013 16:12:58', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 1000, '������', to_date('18-09-2013 11:18:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (106, '002', '001', to_date('06-09-2013 16:03:39', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 700, '���ύ', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (108, '004', '001', to_date('06-09-2013 16:16:56', 'dd-mm-yyyy hh24:mi:ss'), '����', 1599, '������', to_date('18-09-2013 11:12:42', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (124, '001', '001', to_date('10-09-2013 13:01:28', 'dd-mm-yyyy hh24:mi:ss'), '�Ӱ�', 104, '�´���', to_date('13-09-2013 15:20:12', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (126, '001', '001', to_date('10-09-2013 13:41:57', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 1000, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (130, '001', '001', to_date('10-09-2013 14:08:25', 'dd-mm-yyyy hh24:mi:ss'), '�ݷÿͻ�', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (171, null, '003', to_date('22-10-2013 16:06:53', 'dd-mm-yyyy hh24:mi:ss'), '���', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (173, null, '001', to_date('22-10-2013 16:12:36', 'dd-mm-yyyy hh24:mi:ss'), '��������㷢', 15, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (180, null, '003', to_date('22-10-2013 16:55:36', 'dd-mm-yyyy hh24:mi:ss'), '���', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (191, null, '003', to_date('23-10-2013 10:51:39', 'dd-mm-yyyy hh24:mi:ss'), '���', 100, '�´���', null);
insert into BIZ_CLAIM_VOUCHER (ID, NEXT_DEAL_SN, CREATE_SN, CREATE_TIME, EVENT, TOTAL_ACCOUNT, STATUS, MODIFY_TIME)
values (196, null, '001', to_date('23-10-2013 11:28:42', 'dd-mm-yyyy hh24:mi:ss'), '123123123', 369, '�´���', to_date('23-10-2013 13:37:12', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 32 records loaded
prompt Loading BIZ_CHECK_RESULT...
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (1, 1, to_date('02-09-2013 09:02:02', 'dd-mm-yyyy hh24:mi:ss'), '002', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (2, 1, to_date('02-09-2013 11:02:02', 'dd-mm-yyyy hh24:mi:ss'), '004', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (101, 4, to_date('04-09-2013 17:12:27', 'dd-mm-yyyy hh24:mi:ss'), '004', 'ͨ��', 'û���Ⱑ');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (142, 108, to_date('18-09-2013 11:12:42', 'dd-mm-yyyy hh24:mi:ss'), '002', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (143, 7, to_date('18-09-2013 11:13:05', 'dd-mm-yyyy hh24:mi:ss'), '002', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (144, 107, to_date('18-09-2013 11:18:16', 'dd-mm-yyyy hh24:mi:ss'), '002', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (145, 3, to_date('18-09-2013 11:18:54', 'dd-mm-yyyy hh24:mi:ss'), '003', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (146, 7, to_date('18-09-2013 11:19:03', 'dd-mm-yyyy hh24:mi:ss'), '003', 'ͨ��', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (121, 100, to_date('13-09-2013 15:29:06', 'dd-mm-yyyy hh24:mi:ss'), '002', '�ܾ�', 'ͬ��');
insert into BIZ_CHECK_RESULT (ID, CLAIM_ID, CHECK_TIME, CHECKER_SN, RESULT, COMM)
values (100, 4, to_date('04-09-2013 17:00:13', 'dd-mm-yyyy hh24:mi:ss'), '002', 'ͨ��', 'ͬ��');
commit;
prompt 10 records loaded
prompt Loading BIZ_CLAIM_VOUCHER_DETAIL...
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (107, 108, '��Ʒ��', 600, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (102, 102, '�Ǽʽ�ͨ��', 200, '�ؼ�');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (103, 102, '���ʲͷ�', 300, '�Է�Ǯ');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (104, 102, '�칫��', 6000, '�������');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (10, 7, '�Ǽʽ�ͨ��', 4598, '������Ʊ');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (11, 7, '���ʲͷ�', 534.51, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (1, 1, 'ס��', 100, '����ס��');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (2, 1, '���ʲͷ�', 180, '��ͻ��Է�');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (3, 2, '��ͨ', 300, '���ڽ�ͨ');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (4, 2, 'ס��', 600, '����ס��');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (5, 2, '����', 300, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (6, 3, '��ͨ', 100, '���ڽ�ͨ');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (7, 3, '����', 700, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (128, 124, '�Ǽʽ�ͨ��', 4, 'test');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (125, 132, '�Ǽʽ�ͨ��', 111, 'test');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (126, 132, '�Ǽʽ�ͨ��', 222, 'test1');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (127, 132, '�Ǽʽ�ͨ��', 55, 'test2');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (129, 133, '��Ʒ��', 888, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (170, 202, '�Ǽʽ�ͨ��', 11, '11');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (171, 202, '�Ǽʽ�ͨ��', 11, '11');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (8, 1, '���ڽ�ͨ��', 20, '�Ӱ�ؼ�');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (9, 4, '���ڽ�ͨ��', 20, '�Ӱ�ؼ�');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (105, 107, '�Ǽʽ�ͨ��', 300, '��');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (106, 108, '�Ǽʽ�ͨ��', 999, '��ͨ��');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (124, 130, '�Ǽʽ�ͨ��', 100, '����');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (154, 198, '�Ǽʽ�ͨ��', 22, '22');
insert into BIZ_CLAIM_VOUCHER_DETAIL (ID, MAIN_ID, ITEM, ACCOUNT, DES)
values (155, 198, '�Ǽʽ�ͨ��', 11, '11');
commit;
prompt 27 records loaded
prompt Loading BIZ_CLAIM_VOUCHER_STATISTICS...
insert into BIZ_CLAIM_VOUCHER_STATISTICS (ID, TOTAL_COUNT, YEAR, MONTH, DEPARTMENT_ID, MODIFY_TIME)
values (1, 400, 2013, 7, 2, to_date('15-08-2013 16:34:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER_STATISTICS (ID, TOTAL_COUNT, YEAR, MONTH, DEPARTMENT_ID, MODIFY_TIME)
values (2, 200.55, 2013, 8, 2, to_date('18-09-2013 16:34:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER_STATISTICS (ID, TOTAL_COUNT, YEAR, MONTH, DEPARTMENT_ID, MODIFY_TIME)
values (3, 2000.02, 2013, 8, 3, to_date('18-09-2013 16:34:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_CLAIM_VOUCHER_STATISTICS (ID, TOTAL_COUNT, YEAR, MONTH, DEPARTMENT_ID, MODIFY_TIME)
values (4, 128.01, 2013, 9, 2, to_date('15-10-2013 16:37:58', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 4 records loaded
prompt Loading BIZ_CLAIM_VOUYEAR__STATISTICS...
insert into BIZ_CLAIM_VOUYEAR__STATISTICS (ID, TOTAL_COUNT, YEAR, MODIFY_TIME, DEPARTMENT_ID)
values (5, 728.56, 2013, to_date('15-02-2014 16:40:36', 'dd-mm-yyyy hh24:mi:ss'), 2);
insert into BIZ_CLAIM_VOUYEAR__STATISTICS (ID, TOTAL_COUNT, YEAR, MODIFY_TIME, DEPARTMENT_ID)
values (6, 2000.02, 2013, to_date('15-02-2014 16:40:36', 'dd-mm-yyyy hh24:mi:ss'), 3);
commit;
prompt 2 records loaded
prompt Loading BIZ_LEAVE...
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (105, '001', to_date('09-09-2013', 'dd-mm-yyyy'), to_date('10-09-2013', 'dd-mm-yyyy'), 1, '���', '������', '���', '002', null, to_date('05-09-2013 16:49:56', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (121, '001', to_date('06-09-2013', 'dd-mm-yyyy'), to_date('07-09-2013', 'dd-mm-yyyy'), 1, '���', '������', '�¼�', '002', null, to_date('06-09-2013 09:02:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (136, '001', to_date('10-09-2013 10:54:07', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-09-2013 10:54:07', 'dd-mm-yyyy hh24:mi:ss'), 1, '2', '������', '���', '002', null, to_date('09-09-2013 10:54:20', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (139, '001', to_date('23-09-2013 11:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('24-09-2013 11:15:00', 'dd-mm-yyyy hh24:mi:ss'), 1, '1', '������', '���', '002', null, to_date('09-09-2013 11:15:11', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (143, '001', to_date('30-09-2013 15:09:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-10-2013 15:09:50', 'dd-mm-yyyy hh24:mi:ss'), 1, 'ttt', '������', '���', '002', null, to_date('09-09-2013 15:10:08', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (1, '001', to_date('02-08-2013 08:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2013 00:30:00', 'dd-mm-yyyy hh24:mi:ss'), .5, '��������', '������', '�¼�', '002', 'ͬ��', to_date('01-08-2013 10:02:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2013 22:58:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (2, '001', to_date('06-08-2013 08:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-08-2013 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), 2, '��ð', '�Ѵ��', '����', null, 'ͬ��', to_date('01-08-2013 10:02:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2013 22:58:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (3, '001', to_date('09-08-2013 08:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2013 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), 1, '��ð', '������ ', '����', '002', 'ͬ��', to_date('01-08-2013 10:02:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-09-2013 15:49:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (4, '004', to_date('13-08-2013 08:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('14-08-2013 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), 2, '�¼�', '������', '�¼�', null, null, null, null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (101, '001', to_date('13-08-2013', 'dd-mm-yyyy'), to_date('13-08-2013', 'dd-mm-yyyy'), 1, '���', '������ ', '���', '002', 'ͨ��', to_date('05-09-2013 14:31:19', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-09-2013 15:21:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (127, '001', to_date('18-02-2014 09:55:21', 'dd-mm-yyyy hh24:mi:ss'), to_date('20-02-2014 09:55:23', 'dd-mm-yyyy hh24:mi:ss'), 2, '44', '������', '���', '002', null, to_date('18-02-2014 09:55:28', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (102, '001', to_date('13-08-2013', 'dd-mm-yyyy'), to_date('13-08-2013', 'dd-mm-yyyy'), 1, '��ٴ�', '������', '�¼�', '002', null, to_date('05-09-2013 14:38:50', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (104, '001', to_date('05-09-2013', 'dd-mm-yyyy'), to_date('06-09-2013', 'dd-mm-yyyy'), 1, '���', '�Ѵ�� ', '���', '002', '�ذ�', to_date('05-09-2013 15:26:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-09-2013 15:42:31', 'dd-mm-yyyy hh24:mi:ss'));
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (122, '001', to_date('06-09-2013', 'dd-mm-yyyy'), to_date('08-09-2013', 'dd-mm-yyyy'), 2, '��', '������', '���', '002', null, to_date('06-09-2013 09:15:18', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (124, '001', to_date('05-09-2013 09:20:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-09-2013 09:20:00', 'dd-mm-yyyy hh24:mi:ss'), 2, '���', '������', '���', '002', null, to_date('06-09-2013 09:20:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (125, '001', to_date('06-09-2013 14:19:47', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-09-2013 14:19:50', 'dd-mm-yyyy hh24:mi:ss'), 1, '���', '������', '���', '002', null, to_date('06-09-2013 14:20:10', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into BIZ_LEAVE (ID, EMPLOYEE_SN, STARTTIME, ENDTIME, LEAVEDAY, REASON, STATUS, LEAVETYPE, NEXT_DEAL_SN, APPROVE_OPINION, CREATETIME, MODIFYTIME)
values (140, '001', to_date('11-09-2013 14:51:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('12-09-2013 14:51:35', 'dd-mm-yyyy hh24:mi:ss'), 2, 'tt', '������', '���', '002', null, to_date('09-09-2013 14:51:48', 'dd-mm-yyyy hh24:mi:ss'), null);
commit;
prompt 17 records loaded
prompt Loading SYS_POSITION...
insert into SYS_POSITION (ID, NAME_CN, NAME_EN)
values (1, 'Ա��', 'staff');
insert into SYS_POSITION (ID, NAME_CN, NAME_EN)
values (2, '���ž���', 'manager');
insert into SYS_POSITION (ID, NAME_CN, NAME_EN)
values (3, '�ܾ���', 'generalmanager');
insert into SYS_POSITION (ID, NAME_CN, NAME_EN)
values (4, '����', 'cashier');
commit;
prompt 4 records loaded
prompt Enabling foreign key constraints for SYS_EMPLOYEE...
alter table SYS_EMPLOYEE enable constraint DEPART_ID;
prompt Enabling foreign key constraints for BIZ_CLAIM_VOUCHER...
alter table BIZ_CLAIM_VOUCHER enable constraint E_SN;
alter table BIZ_CLAIM_VOUCHER enable constraint F_SN;
prompt Enabling foreign key constraints for BIZ_CHECK_RESULT...
alter table BIZ_CHECK_RESULT enable constraint FK_CLAIM_ID;
prompt Enabling foreign key constraints for BIZ_CLAIM_VOUCHER_DETAIL...
alter table BIZ_CLAIM_VOUCHER_DETAIL enable constraint CLAIME_ID;
prompt Enabling foreign key constraints for BIZ_CLAIM_VOUCHER_STATISTICS...
alter table BIZ_CLAIM_VOUCHER_STATISTICS enable constraint DEPTID_ID;
prompt Enabling triggers for SYS_DEPARTMENT...
alter table SYS_DEPARTMENT enable all triggers;
prompt Enabling triggers for SYS_EMPLOYEE...
alter table SYS_EMPLOYEE enable all triggers;
prompt Enabling triggers for BIZ_CLAIM_VOUCHER...
alter table BIZ_CLAIM_VOUCHER enable all triggers;
prompt Enabling triggers for BIZ_CHECK_RESULT...
alter table BIZ_CHECK_RESULT enable all triggers;
prompt Enabling triggers for BIZ_CLAIM_VOUCHER_DETAIL...
alter table BIZ_CLAIM_VOUCHER_DETAIL enable all triggers;
prompt Enabling triggers for BIZ_CLAIM_VOUCHER_STATISTICS...
alter table BIZ_CLAIM_VOUCHER_STATISTICS enable all triggers;
prompt Enabling triggers for BIZ_CLAIM_VOUYEAR__STATISTICS...
alter table BIZ_CLAIM_VOUYEAR__STATISTICS enable all triggers;
prompt Enabling triggers for BIZ_LEAVE...
alter table BIZ_LEAVE enable all triggers;
prompt Enabling triggers for SYS_POSITION...
alter table SYS_POSITION enable all triggers;
set feedback on
set define on
prompt Done.
