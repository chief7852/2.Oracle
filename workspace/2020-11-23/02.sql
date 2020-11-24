2020-11-23-01)연산자
 4.기타연산자
  1)IN 연산자
   - 질의 탐색을 위해 2개 이상의 표현식(항목)을 지정
   - OR 연산자로 변환 가능
    (사용형식)
    컬럼명 IN(표현식1, 표현식2,...)
    . '컬럼명'에 저장된 값이 ()안에 기술된 표현식 중 어느 하나와 일치하면
        전체조건이 참


예 ) 사원테이블에서 부서코드가 20,60,80번 부서에 속한 사원을 검색하시오                //특별하게 지칭한 파트에서 찾는것
     Alias는 사원번호, 사원명, 부서코드, 급여

(IN 연산자를 사용하지 않는 경우)
SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        SALARY AS 급여
    FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,60,80)      
 ORDER BY 3;

    2)SOME, ANY 연산자
     - 기본 기능은 IN연산자와 동일
     (사용형식)
     컬럼명 관계연산자 ANY|SOME (표현식1, 표현식2, ...)
     . IN 연산자는 동일성만 판단(=ANY, =SOME)
     . ANY, SOME은 크기비교도 가능하다.
    
예) - ANY 연산자 사용
SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        SALARY AS 급여
    FROM EMPLOYEES
WHERE DEPARTMENT_ID =ANY (20,60,80)      
 ORDER BY 3;

- SOME 연산자 사용
SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        SALARY AS 급여
    FROM EMPLOYEES
WHERE DEPARTMENT_ID =SOME (20,60,80)      
 ORDER BY 3;


예)회원 테이블에서 직업이 공무원인 회원이 가진 마일리지보다 더 많은
   마일리지를 보유한 회원을 조회하시오
   
SELECT MEM_NAME, MEM_MILEAGE
      FROM MEMBER 
    WHERE MEM_JOB = '공무원'
    ORDER BY MEM_MILEAGE DESC;


SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_MILEAGE >ANY ( SELECT MAX (MEM_MILEAGE)
                         FROM MEMBER
                         WHERE MEM_JOB='공무원')

문제] 사원테이블에서 부서번호가 30,50,80 부서에 속하지 않은 사원을 조회하시오
    Alias 는 사원번호, 사원명, 부서번호,입사일
    
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       HIRE_DATE AS 입사일    
FROM EMPLOYEES    
WHERE DEPARTMENT_ID NOT IN(30,50,80)            --WHERE NOT DEPARTMENT_ID = ANY(30,50,80)
ORDER BY 3;
    
문제] 회원테이블에서 다음자료의 주민번호를 수정하시오
     회원번호 :'e001', 주민번호 :'750501-2406017'  => '010501-4406017'
     회원번호 :'n001', 주민번호 :'750323-1011014'  => '000323-3011014'

UPDATE MEMBER
    SET MEM_REGNO1 ='010501',
        MEM_REGNO2 ='4406017'
    WHERE MEM_ID='e001'
    
UPDATE MEMBER
    SET MEM_REGNO1 ='000323',
        MEM_REGNO2 ='3011014'
    WHERE MEM_ID='n001'
    
SELECT MEM_NAME, MEM_REGNO1||'-'||MEM_REGNO2
    FROM MEMBER
  WHERE MEM_ID='n001'OR MEM_ID='e001';




COMMIT;


문제] 회원테이블에서 여성회원이고 마일리지가 3000이상인 회원정보를 조회하시오
     Alias는 회원번호, 회원명 ,주민번호 , 직업, 마일리지
     
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN(2,4) 
    AND MEM_MILEAGE>= 3000;

문제] 상품데이블(PROD)에서 분류코드가 'P102'이고 판매금액이 10만원 이상인
      상품을 조회하시오
      Alias는 상품코드, 상품명, 분류코드, 판매가격

SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       PROD_LGU AS 분류코드,
       PROD_PRICE AS 판매가격
    FROM PROD
WHERE PROD_LGU='P102' AND PROD_PRICE>=100000;

문제] 장바구니테이블에서 2005년 7월 1일~7월 15일 판매정보를 조회하시오
    AlIAS는 장바구니번호,회원번호,수량
    단, 구매수량이 많은 것 부터 출력

SELECT CART_NO AS 장바구니번호,
        CART_MEMBER AS 회원번호,
        CART_QTY AS 수량
FROM CART
WHERE SUBSTR(CART_NO,1,8)>='20050701'
      AND SUBSTR(CART_NO,1,8)<='20050715'
 ORDER BY 3 DESC;
 
 
 예) 사원테이블에서 사원의 근속년수를 구하고 근속년수가 15년 이상인 회원들에게
    보너스를 지급하려한다. 이를 조회하시오
    보너스 :급여의 15%
    지급액 :급여+보너스
    Alias는 사원번호,사원명,입사일,근속년수,보너스,급여,지급액이다.
 SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        HIRE_DATE AS 입사일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS 근속년수,
        SALARY *0.15 AS 보너스,
        SALARY AS 급여,
        SALARY *0.15+SALARY AS 지급액
    FROM EMPLOYEES
 WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)>=15;
 
 
 
 예)회원테이블에서 회원들의 나이를 주민번호를 기준으로 계산하시오
    Alias는 회원번호, 회원명, 주민번호, 나이
    
    
SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
        CASE WHEN  SUBSTR(MEM_REGNO2,1,1) = '1' OR SUBSTR(MEM_REGNO2,1,1)='2' THEN
             EXTRACT (YEAR FROM SYSDATE)-(1900+ TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))) AS 나이
        ELSE EXTRACT (YEAR FROM SYSDATE)-(2000+ TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
        END AS 나이
FROM MEMBER


예제) 매입테이블(BUYPROD)에서 2005년 1월 매입자료를 조회하시오
     Alias는 매입일,매입상품 코드, 매입수량, 매입단가, 매입금액이다

SELECT BUY_DATE AS 매입일,
       BUY_PROD AS "매입상품 코드",                   --컬럼명에 빈칸이나 특수문장이 들어가면 ""을 넣어줘야한다.
       BUY_QTY AS 매입수량,
       BUY_COST AS 매입단가,
       BUY_QTY * BUY_COST AS 매입금액
    FROM BUYPROD
WHERE BUY_DATE >= '20050101' AND BUY_DATE <= '20050131';