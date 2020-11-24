2020-11-17-01 SQL(STRUCTED QUERY LANGUAGE)
    1. DDL(DATA DEFINITION LANGUAGE)
        -데이트의 정의어(오라클 객체 생성, 삭제, 변경)
        -CREATE, DROP, ALTER
        
        
    1)테이블 생성 명령
     -오라클 데이터베이스의 기본 객체인 테이블 생성
     -CREATE TABLE 명령 제공
     (사용형식)
    CREATE TABLE 테이블명(
    컬럼명1 타입명[(크기[BYTE|CHAR])] [NOT NULL][DEFAULT 값],
    컬럼명1 타입명[(크기[BYTE|CHAR])] [NOT NULL][DEFAULT 값],
                                :
    컬럼명1 타입명[(크기[BYTE|CHAR])] [NOT NULL][DEFAULT 값],
    
    [CONSTRAINT 기본키설정명 PRIMARY KEY(컬럼명1[,컬럼명2,...]).]             -- //전체 테이블스페이스에서 기본키설정명이라는 말을 얘만 써야함(오류남)
    [CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명1[,컬럼명2,...]).
        REFERENCE 테이블명(컬럼명1[,컬럼명2,...]));
    . 기본키설정명 : 해당테이블 스페이스에서 유일한 명칭이어야 함
    . 외래키설정명 : 해당테이블 스페이스에서 유일한 명칭이어야 함
    . '테이블명(컬럼명1)' : 외래키가 참조하는 원본 테이블의 이름이고,
                    '(컬럼명1)'은 원본테이블에서 사용된 컬럼명
                    
예) 한국건설 물리erd를 기초로 테이블을 생성하시오

    (1)EMP 테이블 생성
  CREATE TABLE EMP(
    EMP_ID CHAR(5),
    EMP_NAME VARCHAR2(30) NOT NULL,
    ADDR VARCHAR2(80),
    TEL_NO VARCHAR2(20),
    JOB_GRADE VARCHAR2(50),
    DEPT_NAME VARCHAR2(50),
    
    CONSTRAINT pk_emp PRIMARY KEY(EMP_ID));
    
     (2)SITE 테이블 생성
  CREATE TABLE SITE(
      SITE_NO CHAR(8), --기본키
      SITE_NAME VARCHAR2(50) NOT NULL,
      SITE_TEL_NO VARCHAR2(20),
      CONS_AMT NUMBER(12) DEFAULT 0,
      INPUT_PER NUMBER(4) DEFAULT 0,
      START_DATE DATE DEFAULT SYSDATE,
      P_COM_DATE DATE,
      COM_DATE DATE,
      REMARKS VARCHAR2(100),
      
      CONSTRAINT pk_site PRIMARY KEY(SITE_NO));
      
      (3)MATERIALS 테이블 생성
    CREATE TABLE MATERIALS(
        MAT_ID CHAR(10), -- 기본키
        MAT_NAME VARCHAR2(50) NOT NULL,
        MAT_QTY NUMBER(4) DEFAULT 0,
        MAT_PRICE NUMBER(8) DEFAULT 0,
        PUR_DATE DATE,
        SITE_NO CHAR(8),
        
        CONSTRAINT pk_materials PRIMARY KEY(MAT_ID),
        CONSTRAINT fk_SITE FOREIGN KEY(SITE_NO)
         REFERENCES SITE(SITE_NO));
         
      (4)WORK 테이블생성
      CREATE TABLE WORK(
        EMP_ID CHAR(5),
        SITE_NO CHAR(8),
        WST_DATE DATE,
        
        CONSTRAINT pk_work PRIMARY KEY(EMP_ID,SITE_NO),
        CONSTRAINT fk_work_emp FOREIGN KEY(EMP_ID)
        REFERENCES EMP(EMP_ID),
        CONSTRAINT fk_work_site FOREIGN KEY(SITE_NO)
        REFERENCES SITE(SITE_NO));
            
            
            COMMIT;
        
            
            