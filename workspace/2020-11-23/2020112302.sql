2020-11-23-02)
 3) ALL 연산자
  -질의 탐색을 위해 2개 이상의 표현식(항목)을 지정
  - 모든 표현식의 평가 결과가 참이어야 WHERE 절이 참이되는 연산자
  (거의 사용되는 경우가 없음)
  - AND 연산자로 변환 가능

 (사용형식)
   컬럼명 ALL (표현식1,표현식2,...)
    
 4)EXISTS 연산자
   - 반드시 뒤에 서브쿼리가 나와야 함

 (사용형식)
  WHERE EXISTS (서브쿼리)

예) 사원테이블에서 전체 사원의 평균급여보다 많은 급여를 수령하는
    사원이 근무하는 부서코드를 조회하시오
    
(전체사원의 평균급여)
SELECT ROUND(AVG(SALARY))
    FROM EMPOYEES;
    
SELECT DISTINCT DEPARTMENT_ID
    FROM EMPLOYEES
 WHERE EXISTS (SELECT 1
                FROM EMPLOYEES
                WHERE SALARY >(SELECT ROUND(AVG(SALARY))
                                    FROM EMPLOYEES))
   ORDER BY 1;                                 
   
 5)BETWEEN 연산자
    -범위를 지정하여 조건을 구성하는 경우 사용
    (사용형식)
    컬럼명 BETWEEN 값1 AND 값2
    . 컬럼명의 값이 '값1'에서 '값2' 사이의 값이면 참(true)을 반환


예) 회원테이블에서 마일리지가 1000~3000사이인 회원정보를 조회하시오
    Alias는 회원번호,회원명,마일리지
    (AND 연산자 사용)
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_MILEAGE AS 마일리지
    FROM MEMBER       
 WHERE MEM_MILEAGE BETWEEN 1000 AND 3000;

예제) 매입테이블(BUYPROD)에서 2005년 1월 매입자료를 조회하시오
     Alias는 매입일,매입상품 코드, 매입수량, 매입단가, 매입금액이다
     
SELECT BUY_DATE AS 매입일,
       BUY_PROD AS "매입상품 코드",                  
       BUY_QTY AS 매입수량,
       BUY_COST AS 매입단가,
       BUY_QTY * BUY_COST AS 매입금액
    FROM BUYPROD
WHERE BUY_DATE BETWEEN '20050101' AND '20050131';


예제] 장바구니테이블에서 'a001'회원부터 'd001'회원까지 구매정보를 조회하시오
    Alias 는 회원번호,상품코드,구매수량
SELECT CART_MEMBER AS 회원번호,
       CART_PROD AS 상품코드,
       CART_QTY AS 구매수량
    FROM CART
WHERE CART_MEMBER BETWEEN 'a001' AND 'd001';

 
 
 6)LIKE 연산자++++++++++++++++++(문자열에 만 사용)
  - 패턴을 비교하는 경우 사용하는 연산자
  - 와리드카드(패턴문자열)로 '%'와'_'가 사용
  - '%': '%'가 사용된 위치에서 그 이후에 나오는 모든 문자열과 대응
    ex) '김%' : '김'으로 시작하는 모든 문자열과 대응
        '%김' : '김'으로 끝나는 모든 문자열과 대응
        '%김%' :단어 내부에 '김'이 존재하는 모든 문자열과 대응
  - '_': '_'가 사용된 위치에서 하나의 문자와 대응
    ex) '김_' : '김'으로 시작하고 2글자로 구성되며 두번째 글자는 어느 글자든 상관없음
        '_김' : '김'으로 끝나는 2글자로 구성된 문자열과 대응

예)회원테이블에서 회원의 거주지가 '충남'인 회원정보를 출력하시오
   Alias 는 회원이름, 주소, 직업이다
   
SELECT  MEM_NAME AS 회원이름,
        MEM_ADD1||' '||MEM_ADD2 AS 주소,
        MEM_JOB AS 직업
    FROM MEMBER
  WHERE MEM_ADD1 LIKE '충남%'










