2020-12-01-02) NULL 처리함수
  - 연산에 사용되는 항목 중 NULL을 포함 하는 경우 결과가 NULL로 반환
  - IS [NOT] NULL, NVL2, BULLIF 등의 함수(연산자)가 제공 됨
 1. IS [NOT] NULL
  - NULL 값 여부를 비교하기 위하여 '='사용은 허용되지 않음
  - 반드시 IS[NOT] NULL연산자를 사용해야함
  
  예)사원테이블에서 영업실적코드(COMMISSION_PCT)가 NULL이 아닌 사원을 조회하시오
     Alias는 사원번호,사원명,부서코드,영업실적
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서코드,
         COMMISSION_PCT AS 영업실적
    FROM EMPLOYEES
   WHERE COMMISSION_PCT IS NOT NULL;
   
  2. NVL(c,val)
  - 'c'의 값이 NULL이면 'val'을 반환하고 NULL이 아니면 'c'의 값을 반환
  - 연산에 사용되는 숫자 항목의 값이 NULL을 포함할 위험이 있는 경우 사용

 예) CREATE TABLE TEMP(
        COL1 NUMBER(6),
        COL2 VARCHAR2(20) NOT NULL,
        COL3 DATE);
        
        INSERT INTO TEMP(COL2) VALUES('대전시');
         INSERT INTO TEMP VALUES(10,'중구',SYSDATE);   

 예)사원테이블에서 영업실적에 따른 보너스를 조회하시오
    Alias는 사원번호,사원명,영업실적,보너스
     (NVL미사용)
     SELECT EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS  사원명,
            COMMISSION_PCT AS 영업실적,
            COMMISSION_PCT*SALARY AS 보너스
        FROM EMPLOYEES;
     
    (NVL사용)
     SELECT EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS  사원명,
            COMMISSION_PCT AS 영업실적,
            NVL(COMMISSION_PCT*SALARY,0) AS 보너스
        FROM EMPLOYEES;

  **회원테이블에서 회원번호 'r001', 'd001','k001'회원의 마일리지를
    null로 바꾸시오
  UPDATE MEMBER
        SET MEM_MILEAGE=NULL
    WHERE LOWER(MEM_ID) IN('r001', 'd001','k001');
     
  예제) 모든 회원들에게 500마일리지를 추가로 지급하려한다
        회원번호, 회원명, 기존 마일리지, 변경마일리지를 출력
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 기존마일리지,
           NVL(MEM_MILEAGE,0) + 500 AS 변경마일리지
      FROM MEMBER;
  
  예)매입테이블에서 2005년 3월 모든 상품별 매입현황을 조회하시오
    Alias는 상품코드,상품명,매입수량,매입금액
    SELECT B.PROD_ID AS 상품코드,
           B.PROD_NAME AS 상품명,
           NVL(SUM(A.BUY_QTY),0) AS 매입수량,
          NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS 매입금액
      FROM BUYPROD A
      RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
        AND A.BUY_DATE BETWEEN '20050301' AND '20050331')
    GROUP BY B.PROD_ID , B.PROD_NAME
    ORDER BY 1;
     
     
예)회원테이블에서 마일리지가 NULL인 회원을 조회하여 비고난에 '탈퇴회원'
   을 NULL이 아닌 회원은 '정상회원'을 출력하시오
   Alias는 회원번호, 회원명,마일리지,비고
   SELECT MEM_ID AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_MILEAGE AS 마일리지,
          NVL2(MEM_MILEAGE,'정상회원','탈퇴회원') AS 비고
    FROM MEMBER;
     
     
 3. NVL2(c, val1,val2)
   - 'c'의 값이 NULL이면 val2를 반환하고,NULL이 아니면 val1을 반환함
   - 'val1'과'val2'는 같은 데이터 타입이어야 함
   - NVL함수를 구현
   
  예제) 모든 회원들에게 500마일리지를 추가로 지급하려한다( NVL2 사용)
        회원번호, 회원명, 기존 마일리지, 변경마일리지를 출력
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 기존마일리지,
           NVL2(MEM_MILEAGE,MEM_MILEAGE,0) + 500 AS 변경마일리지
      FROM MEMBER;
     
 4.NULLIF(c1, c2)               --잘안씀    
   - 'c1'과'c2'가 같으면 NULL, 다른 값이면 c1을 반환
   
**상품테이블에서 분류코드가 'P201'인 상품의 할인판매가격을 매입가격으로 변경하시오.
  UPDATE PROD 
  SET PROD_SALE = PROD_COST
   WHERE PROD_LGU= 'P201';
    
예)상품테이블에서 매입가격과할인판매 가격이 같은 상품은 ' 마감처리물품'
    서로 다르면 '정상상품'을 비고난에 출력하시오.(NVL2,NULLIF 사용)
    Alias는 상품코드,상품명,매입가격,할인판매가격,비고
   SELECT PROD_ID AS 상품코드,
          PROD_NAME AS 상품명,
          PROD_COST AS 매입가격,
          PROD_SALE AS 할인판매가격,
    NVL2(NULLIF(PROD_COST,PROD_SALE),'정상상품','마감처리물품')AS 비고
    FROM PROD;
    
    
    
    
    
    
    
    