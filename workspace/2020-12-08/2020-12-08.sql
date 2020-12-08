2020-12-08-01)
예) 2005년 1~6월 모든 거래처별 매출현황을 조회하시오
    Alias는 거래처코드,거래처명,매출액
  (일반 OUTER JOIN);
 SELECT A.BUYER_ID AS 거래처코드,
        A.BUYER_NAME AS 거래처명,
        SUM(B.CART_QTY*C.PROD_PRICE) AS 매출액
   FROM BUYER A, CART B, PROD C
  WHERE B.CART_PROD(+) = C.PROD_ID
    AND A.BUYER_ID = C.PROD_BUYER
    AND SUBSTR(B.CART_NO,1,6) BETWEEN '200501' AND '200506'
GROUP BY A.BUYER_ID,A.BUYER_NAME 
ORDER BY 1;


    (ANSI OUTER);
 SELECT A.BUYER_ID AS 거래처코드,
        A.BUYER_NAME AS 거래처명,
        SUM(B.CART_QTY*C.PROD_PRICE) AS 매출액
   FROM BUYER A
LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
LEFT OUTER JOIN CART B ON(B.CART_PROD = C.PROD_ID
  AND  SUBSTR(B.CART_NO,1,6) BETWEEN '200501' AND '200506')
 GROUP BY A.BUYER_ID,A.BUYER_NAME  
 ORDER BY 1;
 
    (SUBQUETY)
 SELECT A.BUYER_ID AS 거래처코드,
        A.BUYER_NAME AS 거래처명,
        SUM(B.CART_QTY*C.PROD_PRICE) AS 매출액
   FROM BUYER A,(2005년 1~6월 거래처별 매출액-내부조인)B
   WHERE A.BUYER_ID=B.거래처코드(+);
   
   
(2005년 1~6월 거래처별 매출액-내부조인);
SELECT BUYER_ID AS BID ,
        SUM(CART_QTY*PROD_PRICE) AS AMT
    FROM BUYER,CART,PROD
    WHERE BUYER_ID = PROD_BUYER
    AND PROD_ID = CART_PROD
    AND SUBSTR(CART_NO,1,6) BETWEEN '200501' AND '200506'
    GROUP BY BUYER_ID;
    
(결합);

 SELECT A.BUYER_ID AS 거래처코드,
        A.BUYER_NAME AS 거래처명,
        B.AMT AS 매출액
   FROM BUYER A,(SELECT BUYER_ID AS BID ,
                    SUM(CART_QTY*PROD_PRICE) AS AMT
                   FROM BUYER,CART,PROD
                  WHERE BUYER_ID = PROD_BUYER
                    AND PROD_ID = CART_PROD
                    AND SUBSTR(CART_NO,1,6) BETWEEN '200501' AND '200506'
               GROUP BY BUYER_ID )B
   WHERE A.BUYER_ID=B.BID(+);
   
  
예)2005년 모든 제품별 매입/매출을 조회하시오
   Alias는 상품코드, 상품명, 매입수량, 매출수량,매입금액,매출금액
(SUBQUERY)
SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       AS 매입수량,
       AS 매출수량,
       AS 매입금액,
       AS 매출금액
  FROM PROD A,(2005년 매입집계)B,(2005년매출집계)C
  WHERE A.PROD_ID= B.()(+)
    AND A.PROD_ID=C.()(+);
 
 
 (2005년 매입집계)
 SELECT BUY_PROD AS BROD ,
        SUM(BUY_QTY) AS BQTY
        SUM(BUY_QTY*BUY_COST) AS BAMT
   FROM BUYPROD
   WHERE BUY_DATE BETWEEN '20050101' AND '20051231'
GROUP BY BUY_PROD;

(2005년 매출집계)
 SELECT CART_PROD AS CROD ,
        SUM(CART_QTY) AS CQTY,
        SUM(CART_QTY*PROD_PRICE) AS CAMT
   FROM CART,PROD
   WHERE CART_PROD=PROD_ID
   AND CART_NO LIKE '2005%'
GROUP BY CART_PROD;


   ( 결합);
   SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       B.BQTY AS 매입수량,
       C.CQTY AS 매출수량,
       B.BAMT AS 매입금액,
       C.CAMT AS 매출금액
  FROM PROD A,(SELECT BUY_PROD AS BPROD ,
                  SUM(BUY_QTY) AS BQTY,
                  SUM(BUY_QTY*BUY_COST) AS BAMT
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN '20050101' AND '20051231'
             GROUP BY BUY_PROD)B,
             
             (SELECT CART_PROD AS CPROD ,
                 SUM(CART_QTY) AS CQTY,
                 SUM(CART_QTY*PROD_PRICE) AS CAMT
                FROM CART,PROD
               WHERE CART_PROD=PROD_ID
                 AND CART_NO LIKE '2005%'
            GROUP BY CART_PROD)C
     WHERE A.PROD_ID= B.BPROD(+)
     AND A.PROD_ID=C.CPROD(+);
     
     
예) 사원테이블에서 부서별 가장낮은 급여를 조회하고 누가 그 급여를 받는지 조회하시오
    Alias는 사원번호,사원명,부서번호,부서명,급여
    
(메인쿼리 : 사원테이블에서 사원번호,사원명,부서번호,부서명,급여 조회);
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       B.DEPARTMENT_NAME AS 부서명,
       A.SALARY AS 급여
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
   AND A.SALARY = (최소급여)
 (서브쿼리 : 부서별 최소임금);
SELECT C.MSAL
   FROM EMPLOYEES B,(SELECT DEPARTMENT_ID AS DID,
                      MIN(SALARY) AS MSAL
                     FROM EMPLOYEES A
                 GROUP BY A.DEPARTMENT_ID)C
    WHERE B.DEPARTMENT_ID = C.DID;
 
   
   (결합);
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       D.DID AS 부서번호,
       D.DNAME AS 부서명,
       A.SALARY AS 급여
  FROM EMPLOYEES A, (SELECT B.DEPARTMENT_ID AS DID,
                            C.DEPARTMENT_NAME AS DNAME,
                              MIN(B.SALARY) AS MSAL
                             FROM EMPLOYEES B, DEPARTMENTS C
                             WHERE B.DEPARTMENT_ID=C.DEPARTMENT_ID
                          GROUP BY B.DEPARTMENT_ID,C.DEPARTMENT_NAME
                          ORDER BY 1) D
 WHERE A.DEPARTMENT_ID = D.DID
 AND A.SALARY = D.MSAL
ORDER BY 3;
   


예)사원테이블과 직무테이블(JOBS)을 사용하여 각 직무별 최소급여를 조회하고
   해당 직무를 가지고 있는 사원 중 최소급여를 받는 사원정보를 조회하시오
   Alias는 사원번호, 사원명, 직무코드, 직무명, 급여
   (메인쿼리 : 사원번호, 사원명, 직무코드, 직무명, 급여 조회)
   
 SELECT A.EMPLOYEE_ID AS 사원번호,
        A.EMP_NAME AS 사원명,
        A.JOB_ID AS 직무코드,
        B.JOB_TITLE AS 직무명,
        A.SALARY AS 급여
   FROM EMPLOYEES A, JOBS B
  WHERE A.JOB_ID=B.JOB_ID   
    AND A.SALART IN (직무별 최저급여 : JOBS테이블의 MIN_SALARY이 아님)
    
    (직무별 최저급여);
  SELECT JOB_ID,
         MIN(SALARY)
    FROM EMPLOYEES
    GROUP BY JOB_ID;
   
   
   (결합);
    SELECT A.EMPLOYEE_ID AS 사원번호,
        A.EMP_NAME AS 사원명,
        A.JOB_ID AS 직무코드,
        B.JOB_TITLE AS 직무명,
        A.SALARY AS 급여
   FROM EMPLOYEES A, JOBS B
  WHERE A.JOB_ID=B.JOB_ID   
    AND (A.JOB_ID, A.SALARY) IN (SELECT JOB_ID,
                                        MIN(SALARY)
                                   FROM EMPLOYEES
                               GROUP BY JOB_ID)
   ORDER BY 3;
   
   
예) 사원테이블에서 부서명이 '배송부'인 직원정보를 서브쿼리를 사용하여 조회
    Alias는 사원번호,사원명,부서명,급여
(FROM절 서브쿼리);
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       B.EMI AS 부서명,
       A.SALARY AS 급여
  FROM EMPLOYEES A,(SELECT DEPARTMENT_ID AS EMI
                      FROM DEPARTMENTS
                      WHERE DEPARTMENT_NAME = '배송부') B
WHERE A.DEPARTMENT_ID = B.EMI

(WHERE절 서브쿼리);
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       B.DEPARTMENT_NAME AS 부서명,
       A.SALARY AS 급여
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID 
                            FROM DEPARTMENTS
                           WHERE B.DEPARTMENT_NAME = '배송부')
   
   
   
   
   
   
   
   
   