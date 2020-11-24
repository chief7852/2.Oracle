2020-11-18-01) 
1.INSERT 문
 - 테이블에 자료를 삽입할 때 사용
 (사용형식)
  INSERT INTO 테이블명[(컬럼명1, 컬럼명2,...)]
    VALUES(값1,값2,...);
    .'컬럼명1, 컬럼명2,...' : 은 생략할 수 있음                      //[]이 칸자체가 생략가능하다는말
     생략하는 경우 테이블에 존재하는 모든 컬럼의 갯수와 순서 및 데이터 타입에
     맞게 자료를 VALUES절에 기술해야함
    .'컬럼명1, 컬럼명2,...'을 사용하는 경우는 선택된 컬럼에 자료를 삽입하고자
     하는 경우 기술하며, VALUES절에 기술된 값과 컬럼명은 1 : 1로 대응 되어야 함
    .'컬럼명1, 컬럼명2,...' 기술시 NOT NULL 컬럼은 생략 될 수 없음.
    
예>다음 자료를 EMP테이블에 저장하시오
[자료]
사원ID : C1001
사원명 : 홍길동
주소 :대전시 중구 대흥동 500
부서명 : 총무기획부

INSERT INTO EMP(EMP_ID, EMP_NAME,ADDR,DEPT_NAME)
        VALUES('C1001','홍길동','대전시 중구 대흥동 500','총무기획부');
(검증하는법)
SELECT * FROM EMP;                  



사원ID : C1002
사원명 : 강감찬
주소 : 서울시 성북구 신장위동 300-10
직책 : 부장
부서명 : IT개발부

INSERT INTO EMP
        VALUES('C1002','강감찬','서울시 성북구 신장위동 300-10',
                '','부장','IT 개발부');

 SELECT * FROM EMP;





사원ID : C1005
사원명 : 이민정
주소 :대전시 대덕구 법동 100
전화번호 : 01012345678
직책 : 과장
부서명 : 자금부

INSERT INTO EMP(EMP_ID,ADDR,DEPT_NAME,TEL_NO,JOB_GRADE,EMP_NAME)
        VALUES('C1005','대전시 대덕구 법동 100','자금부','010-1234-5678',
                '과장','이민정');
                
COMMIT;     --저장
DELETE EMP; --삭제
ROLLBACK;   --되돌리기
                
SELECT * FROM EMP;  

2.UPDATE 문
 - 저장되어 있는 자료(컬럼의 값)를 수정할때 사용          --자료가 존재해야지만 수정가능하다, 없는자료는 수정할수없다.
    (사용형식)
UPDATE 테이블명
    SET 컬럼명 = 값 [,
        컬럼명 = 값,...]
    [WHERE 조건];
 . '컬럼명' : 변경할 자료의 컬럼명
 . 'WHERE'절이 생략되면 모든 자료의 해당 컬럼값을 수정

예) '홍길동' 사원의 전화번호를 '042-222-8202'로 수정하시오

UPDATE EMP
    SET TEL_NO = '042-222-8202'
  WHERE EMP_ID = 'C1001';

COMMIT;
SELECT * FROM EMP;

예) '강감찬' 사원의 전화번호를 '010-9876-1234'로, 직위를 '차장'수정하시오

UPDATE EMP
    SET TEL_NO = '010-9876-1234',
        JOB_GRADE = '차장'
 WHERE EMP_NAME = '강감찬';

SELECT * FROM EMP


문제] 다음 조건에 맞도록 WORK테이블 등에 자료를 삽입하시오
    [처리조건]
   사원번호 'C1001'인 홍길동 사원이 오늘 날짜로 'DAE00001' 사업장에
   발령 받아 출근함.
   'DAE00001'사업장은 '대전 상수도 관리사업'으로 오늘부터 공사가
   개시되고 2021년 6월 30일에 완공을 목표로하는 사업장이다.
   
   INSERT INTO SITE(SITE_NO,SITE_NAME,START_DATE,P_COM_DATE)
    VALUES('DAE00001','대전 상수도 관리사업',SYSDATE,'20210630');

SELECT * FROM SITE
   
   INSERT INTO WORK
    VALUES('C1001','DAE00001',SYSDATE/*'20201118'*/);
   
   
   DELETE EMP
   WHERE EMP_NAME='홍길동';                --안됨 WORK테이블에서 남아있어서
   
DROP TABLE EMP;                             --안됨 WORK테이블에서 남아있어서
SELECT * FROM WORK;

3. DELETE 문
 - 테이블에 저장된 자료를 삭제할 때 사용
 - 관계가 설정된 테이블에서 부모테이블의 행 중 참조되고 있는 자료는 삭제 거절           --삭제하는법 관계를 삭제, 자식테이블부터 삭제 
    (사용형식)
 -ROLLBACK의 대상

DELETE 테이블명
 [WHERE 조건];
 'WHERE'절이 생략되면 테이블의 모든 행이 삭제
 
 
 
 예)EMP테이블의 모든자료를 삭제하시오
 DELETE WORK;   
 DELETE EMP; --자식테이블이 없어서 삭제불가
                    --그래서 WORK먼저 삭제함
                    
                    
SELECT * FROM WORK;
 SELECT * FROM EMP;
 
 
 
 
 DROP TABLE EMP;            --실패        --DROP은 ROLLBACK 안통함
 4. DROP 문
  - 오라클 객체를 삭제
  - ROLLBACK의 대상이 아님
  
 (사용형식)
DROP 객체타입 객체명;      --객체타입은 왼쪽에있는 테이블 뷰, 인덱스같은것
                         --객체명은 그 안쪽폴더들

예)EMP테이블과 WORK테이블 사이에 존재하는 관계를 삭제하시오
ALTER TABLE WORK
 DROP CONSTRAINT FK_WORK_EMP;
 
 ALTER TABLE WORK
 DROP CONSTRAINT FK_WORK_SITE;
 
DROP TABLE EMP;

ROLLBACK;


DROP TABLE SITE;    -- MATERIALS가 자식테이블이라 삭제안됐음

DROP TABLE MATERIALS;

DROP TABLE WORK;
