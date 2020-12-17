2020-12-17-01) 저장 프로시져(Stored Procedure : Procedure)

 - 특정 기능을 수행하여 하나의 결과를 도출하기 위한 명령의 모임
 - 미리 컴파일되어 서버에 저장
 - 사용자는 실행가능한 프로시져명만 호출(네트워크의 트래픽 감소, 실행효율 증대, 보안확보)
 - 반환값이 없음      --프로시져이름으로 출력하면 안뜸 매개변수로만 가능
 (사용형식)
  CREATE [OR REPLACE] PROCEDURE 프로시져명[(                     //질문:OR REPLACE는 수정한다는건가요? ALTER과 다를게 뭐죠
    매개변수 [IN|OUT|INOUT] 타입명 [:=|DEFAULT 값],                 --INOUT은 사용하지마라, 다생략하면 IN이 된다.
            :
    매개변수 [IN|OUT|INOUT] 타입명 [:=|DEFAULT 값]                  --타입명만 기술해야한다 예를들어 VARCHAR2()    괄호안에 크기를 지정하면 오류뜬다.
    IS|AS
        선언부;
    BEGIN
        실행부
        [EXCEPTION
            예외처리부;
        ]
    END;

(실행문 사용형식)
 EXEC|EXECUTE 프로시져명(매개변수,...); --단독실행
 
 익명블록이나 다른 함수 등에서는 
 프로시져명(매개변수,...);
 
 
 **재고수불테이블을 생성하시오
  테이블명 : REMAIN
  컬럼명         데이터타입          NULLABLE     PK/FK여부   DEFAULT VALUE
  -----------------------------------------------------------------------
  REMAIN_YEAR   CHAR(4)            N.N          PK
  REMAIN_PROD   VARCHAR2(10)       N.N          PK/FK
  REMAIN_J_00   NUMVER(5)                                     0
  REMAIN_I      NUMVER(5)                                     0
  REMAIN_O      NUMVER(5)                                     0
  REMAIN_J_99   NUMVER(5)                                     0
  REMAIN_       DATE                                                        --수정되어진 날짜

--위값을 테이블로 만들어주기
CREATE TABLE REMAIN(
  REMAIN_YEAR   CHAR(4),
  REMAIN_PROD   VARCHAR2(10),
  REMAIN_J_00   NUMBER(5) DEFAULT 0,                                     
  REMAIN_I      NUMBER(5) DEFAULT 0,                                       
  REMAIN_O      NUMBER(5) DEFAULT 0,                                       
  REMAIN_J_99   NUMBER(5) DEFAULT 0,                                       
  REMAIN_DATE       DATE,
  
  CONSTRAINT pk_remain PRIMARY KEY (REMAIN_YEAR,REMAIN_PROD),
  CONSTRAINT fk_remain_reod FOREIGN KEY(REMAIN_PROD)
    REFERENCES PROD(PROD_ID));


** PROD 테이블의 상품번화와 적정재고(PROD_PROPERSTOCK)를 REMAIN테이블의 REMAIN_PROD와
   REMAIN_J_00(기초재고)에 삽입하시오. 또 REMAIN_YEAR는 '2005'이고 날짜는
   '2005/01/01'이다
   
   --INSERT에는 서브쿼리가 유일하게 괄호가 안들어간다.
   INSERT INTO REMAIN(REMAIN_YEAR,REMAIN_PROD,REMAIN_J_00,REMAIN_J_99,REMAIN_)
   SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20050101')
   FROM PROD;

SELECT * FROM REMAIN;


예) 2005년 1월 모든 상품별 매입수량을 조회하고 재고수불테이블을 UPDATE하시오
    PROCEDURE 사용    (모든 상품별 매입수량) (프로시져 사용)
    --조회
SELECT PROD_ID,NVL(SUM(BUY_QTY),0)
FROM PROD
LEFT OUTER JOIN BUYPROD ON (PROD_ID=BUY_PROD
 AND BUY_DATE BETWEEN '20050101' AND '20050131')
 GROUP BY PROD_ID
 ORDER BY PROD_ID;
 
    -- PROCEDURE사용
CREATE OR REPLACE PROCEDURE PROC_BUYPROD01(         --프로시져는 PROC_로 시작하는게 예의같은것 가독성
  P_ID IN PROD.PROD_ID%TYPE,
  P_QTY IN NUMBER)
 IS
BEGIN
  UPDATE REMAIN
    SET REMAIN_I = REMAIN_I + P_QTY,
        REMAIN_J_99 = REMAIN_J_99 + P_QTY,
        REMAIN_DATE = TO_DATE('20050131')
  WHERE REMAIN_PROD = P_ID
    AND REMAIN_YEAR = '2005';               --기본키가 복합키인경우에는 두가지의 기본키를 다 넣어줘야한다 아니면 자료가 엉망이될수 있다.

END;

(실행)
declare 
    cursor cur_buyprod01
    is
    SELECT PROD_ID,NVL(SUM(BUY_QTY),0) AS AMT
    FROM PROD
    LEFT OUTER JOIN BUYPROD ON (PROD_ID=BUY_PROD
     AND BUY_DATE BETWEEN '20050101' AND '20050131')
     GROUP BY PROD_ID
     ORDER BY PROD_ID;

BEGIN
    FOR REC_BUYPROD IN cur_buyprod01 LOOP
     PROC_BUYPROD01(REC_BUYPROD.PROD_ID, REC_BUYPROD.AMT);
    END LOOP;
    
END;

SELECT *FROM REMAIN;

예)한명의 회원 ID를 입력받아 회원의 이름과 주소, 마일리지를 출력하는 PROCEDURE를 작성하시오
--1번째 방법 프로시져 안에서 
CREATE OR REPLACE PROCEDURE PROC_MEM01(
 P_ID MEMBER.MEM_ID%TYPE)
IS
 V_NAME MEMBER.MEM_NAME%TYPE;
 V_ADDR VARCHAR2(100);
 V_MILE MEMBER.MEM_MILEAGE%TYPE;
BEGIN
  SELECT MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_MILEAGE INTO V_NAME,V_ADDR,V_MILE
    FROM MEMBER
   WHERE MEM_ID=P_ID;

    DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);
    DBMS_OUTPUT.PUT_LINE('마일리지 : '||V_MILE);    
    
END;


--실행
EXECUTE PROC_MEM01('d001');

SELECT * FROM MEMBER;
SET SERVEROUTPUT ON;

--2번째 방법 매개변수로 만들기
CREATE OR REPLACE PROCEDURE PROC_MEM01(
 P_ID IN MEMBER.MEM_ID%TYPE,
 P_NAME OUT MEMBER.MEM_NAME%TYPE,
 P_ADDR OUT VARCHAR2,
 P_MILE OUT MEMBER.MEM_MILEAGE%TYPE)
IS
BEGIN
  SELECT MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_MILEAGE INTO P_NAME,P_ADDR,P_MILE
    FROM MEMBER
   WHERE MEM_ID=P_ID;

END;




--실행
DECLARE
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
BEGIN
    PROC_MEM01('b001',V_NAME,V_ADDR,V_MILE);
    
    DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);    
    DBMS_OUTPUT.PUT_LINE('마일리지 : '||V_MILE);   
END;                                                          --얘는 익명블록이라 EXEC,EXCUTE 생략
    
 --실행 : 거주지가 충남인 회원에 대한 프로시져 수행   
 
 DECLARE
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
    
    CURSOR CUR_MEM02
    IS
      SELECT MEM_ID FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%';
BEGIN
    FOR RMEM IN CUR_MEM02 LOOP
    PROC_MEM01(RMEM.MEM_ID,V_NAME,V_ADDR,V_MILE);
    
    DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);    
    DBMS_OUTPUT.PUT_LINE('마일리지 : '||V_MILE);   
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  END LOOP;
END;                  

문제] 상품코드와 월을 입력받아 해당상품의 입고수량과 출고수량을 조회하여 출력하는 프로시져를 
      작성하시오(PROCEDURE 이름 : PROC_CB_INFO)
CREATE OR REPLACE PROCEDURE PROC_CN_INFO(
 P_CODE IN PROD.PROD_ID%TYPE,
 P_MONTH IN CHAR,
 P_OAMT OUT NUMBER,
 P_IAMT OUT NUMBER)
 IS
 V_DATE DATE:=TO_DATE('2005'||P_MONTH||'01');
BEGIN
 SELECT SUM(BUY_QTY) INTO P_IAMT
   FROM BUYPROD
  WHERE BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
    AND BUY_PROD= P_CODE;
    
    SELECT SUM(CART_QTY) INTO P_OAMT
   FROM CART
  WHERE SUBSTR(CART_NO,1,6)=SUBSTR(REPLACE(TO_CHAR(V_DATE),'/'),1,6)
    AND CART_PROD= P_CODE;
     
END;


 DECLARE
    V_IAMT NUMBER := 0;
    V_OAMT NUMBER := 0;
    V_NAME PROD.PROD_NAME%TYPE;
BEGIN
 SELECT PROD_NAME INTO V_NAME
   FROM PROD
   WHERE PROD_ID='P101000006';
   
 PROC_CN_INFO('P101000006','04',V_OAMT,V_IAMT);
 
  DBMS_OUTPUT.PUT_LINE('상품코드 : P101000006');
  DBMS_OUTPUT.PUT_LINE('상품명 : '||V_NAME);
  DBMS_OUTPUT.PUT_LINE('상품코드 : '||V_OAMT);
  DBMS_OUTPUT.PUT_LINE('상품코드 : '||V_IAMT);
END;
    
    
    
    
    
 
 EXECUTE PROC_CN_INFO('p101000001','04') ;
 SELECT SUBSTR(PROD_INSDATE,6 ,2)
 FROM PROD;
 
 
 
 
 
 
 