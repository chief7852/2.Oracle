2020-11-30-01)
2. AVG(column)
 - 'column'을 기준으로 그룹으로 묶인 집단에 대한 평균값 반환
 예)사원테이블에서 각 부서별 평균 급여를 소수 1자리까지 구하시오
 SELECT DEPARTMENT_ID AS 부서코드,
        -- EMP_NAME AS 사원이름, 
        ROUND(AVG(SALARY),1)
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID --EMP_NAME
ORDER BY 1;
  
  예)상품테이블에서 상품분류별 평균매입가를 구해보시오.
 SELECT PROD_LGU AS 상품분류,
        ROUND(AVG(PROD_COST),-1) AS 평균매입가
    FROM PROD
  GROUP BY PROD_LGU
  ORDER BY 1;
  
  
 예제)2005년 월별 제품별 평균매입수량과 매입금액합계를 구하시오
 SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월별,
        BUY_PROD AS 제품코드,
        ROUND(AVG(BUY_QTY)) AS 평균매입수량,
        SUM(BUY_QTY*BUY_COST) AS 매입금액합계
 FROM BUYPROD
 WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
 GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD
 ORDER BY 1;
 
 예제)2005년 5월 일자별 평균판매 수량을 구하시오
  SELECT TO_DATE(SUBSTR((CART_NO),1,8)) AS 일자,
         ROUND(AVG(CART_QTY)) AS "평균판매 수량"
    FROM CART
WHERE CART_NO LIKE '200505%'
GROUP BY TO_DATE(SUBSTR((CART_NO),1,8))
ORDER BY 1;

 예제)사원테이블에서 각 부서별 평균급여보다 많은 급여를 받는 사원정보를
     출력하시오                                              --각부서의 평균급여 먼저계산하기      SELECT DEPARMENT_ID AS DID,
                                                            --                                      AVG(SALATY) AS ASAL ,
     Alias는 사원번호, 사원명, 부서코드, 부서명, 평균급여
  SELECT DEPARTMENT_ID AS DID,
         AVG(SALARY) AS ASAL
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID;
        
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명, 
         A.SALARY AS 급여,
         A.DEPARTMENT_ID AS 부서코드,
         B.DEPARTMENT_NAME AS 부서명,
         ROUND(C.ASAL) AS 평균급여
    FROM EMPLOYEES A, DEPARTMENTS B,
      (  SELECT DEPARTMENT_ID AS DID,
             AVG(SALARY) AS ASAL
         FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) C
  WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
    AND A.DEPARTMENT_ID = C.DID
    AND A.SALARY>=C.ASAL
ORDER BY 4,3;

3. COUNT(*|column)
 - 그룹으로 묶인 각 그룹에 포함된 자료 수(행의 수)
 - 외부조인에 COUNT함수를 사용할 경우 '*' 대신 컬럼명을 사용해야 함
 
 예)사원테이블에서 각 부서별 인원수를 구하시오
 SELECT DEPARTMENT_ID AS 부서코드,
        COUNT(*) AS 인원수,
        COUNT(EMP_NAME) AS 사원수
    FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
  
 예)2005년 6월 제품별 판매건수를 조회하시오
 SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        COUNT(CART_MEMBER) AS 판매건수
    FROM CART 
    RIGHT OUTER JOIN PROD ON(CART_PROD =PROD_ID
    AND  CART_NO LIKE '200506%')
  GROUP BY PROD_ID,PROD_NAME
  ORDER BY 1;
  
  예제)상품테이블에서 각 분류별 상품의 수를 조회하시오
 SELECT  PROD_LGU AS 상품분류,
        COUNT(*) AS 상품의수
    FROM PROD
    GROUP BY PROD_LGU
    ORDER BY 1;
  예제)회원테이블에서 각 연령대별 회원수를 조회하시오
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'언저리' AS 연령대,
         COUNT(*)||'명' AS 회원수
  FROM MEMBER
  GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)
  ORDER BY 1;
  
  예제)회원테이블에서 직업 종류별 회원수를 구하시오
  SELECT MEM_JOB AS 직업종류,
         COUNT(*) AS 회원수,
         COUNT(DISTINCT MEM_JOB) AS "회원수(DISTINCT)"
    FROM MEMBER
 GROUP BY MEM_JOB
 ORDER BY 1;
  
  
  예제)회원테이블에서 직업의 종류를 출력하시오
      Alias 직업명
SELECT DISTINCT MEM_JOB AS 직업종류
FROM MEMBER


4.MAX(column),MIN(column)
 - 'coloumn'으로 기술 컬럼에 저장된 값 중 최대값과 최소값을 구하여 반환
 - 내부적으로 계산 하는 방식은 'column'을 기준으로 오름차순정렬(MIN), 또는 
   내림차순 정렬 후 그 중 첫번째 행의 값을 반환
   따라서 처리시간이 다소 많이 소요됨

*** 의사컬럼 ROWNUM
 - 쿼리 결과(뷰)의 각행에 부여된 순번 값
 - 상위 5개 또는 하위 5개 등 필요한 갯수의 결과만을 출력할 때 사용(다른 DBMS에서는 TOP 함수로 제공됨)
 
 예)회원의 마일리지 중 최대마일리지 값을 구하시오
 SELECT MAX(MEM_MILEAGE)
    FROM MEMBER;
    
 SELECT MEM_MILEAGE
   FROM MEMBER
  ORDER BY 1 DESC;
  
  SELECT A.MILE                     --위 식의 MAX값 내보내려면 이렇게 하나 더씌워서 뽑아내야함
  FROM(SELECT MEM_MILEAGE AS MILE
        FROM MEMBER
        ORDER BY 1 DESC)A
   WHERE ROWNUM <=1;

--미니멈을하려면
SELECT A.MILE 
  FROM(SELECT MEM_MILEAGE AS MILE
        FROM MEMBER
        ORDER BY 1 ASC) A
   WHERE ROWNUM =1;
   
 예) 사원테이블에서 부서별 최대급여와 최소급여를 조회하시오
 SELECT DEPARTMENT_ID AS 부서코드,
        MAX(SALARY) AS 최대급여,
        MIN(SALARY) AS 최소급여
    FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
  
 
  
        
  
  
  
  
  
  