2020-12-02-01)
예)상품테이블에서 상품의 분류코드가 'P200'대의 상품을 조회하시오
    Alias는 상품코드, 상품명, 분류코드, 분류명, 판매가격이다
    SELECT A.PROD_ID AS 상품코드,
           A.PROD_NAME AS 상품명,
           A.PROD_LGU AS 분류코드,
           B.LPROD_NM AS 분류명,
           A.PROD_PRICE AS 판매가격
      FROM PROD A , LPROD B
     WHERE A.PROD_LGU LIKE 'P2%' --일반조건
       AND A.PROD_LGU=B.LPROD_GU
  ORDER BY 3;
  
(ANSI조인 사용);
    SELECT A.PROD_ID AS 상품코드,
           A.PROD_NAME AS 상품명,
           A.PROD_LGU AS 분류코드,
           B.LPROD_NM AS 분류명,
           A.PROD_PRICE AS 판매가격
      FROM PROD A   
    INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)    --조인조건
    WHERE A.PROD_LGU LIKE 'P2%'         --일반조건
    ORDER BY 3;


 예제)2005년 1월 1일 ~ 15일 동안 발생된 매입정보를 조회하시오
     Alias 일자, 상품코드,상품명,수량,금액
  SELECT A.BUY_DATE AS 일자,
         A.BUY_PROD AS 상품코드,
         B.PROD_NAME AS 상품명,
         A.BUY_QTY AS 수량,
         A.BUY_QTY*B.PROD_PRICE AS 금액
    FROM BUYPROD A, PROD B
   WHERE A.BUY_DATE BETWEEN '20050101' AND '20050115'
     AND A.BUY_PROD=B.PROD_ID
   ORDER BY 1;
   
   (ANSI조인 방법)
       Alias일자, 상품코드,상품명,수량,금액;
  SELECT A.BUY_DATE AS 일자,
         A.BUY_PROD AS 상품코드,
         B.PROD_NAME AS 상품명,
         A.BUY_QTY AS 수량,
         A.BUY_QTY*B.PROD_PRICE AS 금액
    FROM BUYPROD A
 INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
    WHERE A.BUY_DATE BETWEEN '20050101' AND '20050115'
  ORDER BY 1;
-- INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
--    AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND '20050115');
  
예제) 2005년 5월 상품별 매입/매출현황을 조회하시오
      Alias는 상품코드,상품명,매출액합계,매입액합계
  SELECT C.PROD_ID AS 상품코드,
         C.PROD_NAME AS 상품명,
         SUM(A.CART_QTY*C.PROD_PRICE) AS 매출액합계,
         SUM(B.BUY_QTY*B.BUY_COST) AS 매입액합계
    FROM CART A, BUYPROD B, PROD C
   WHERE A.CART_PROD=C.PROD_ID
     AND B.BUY_PROD=C.PROD_ID
     AND A.CART_NO LIKE '200505%'
     AND B.BUY_DATE BETWEEN ' 20050501' AND '20050531'
  GROUP BY C.PROD_ID,C.PROD_NAME
  ORDER BY 1;
  
(2005년 5월 상품별 매출현황)
  
  SELECT C.PROD_ID AS 상품코드,
         C.PROD_NAME AS 상품명,
         SUM(A.CART_QTY*C.PROD_PRICE) AS 매출액합계
    FROM CART A, PROD C
    WHERE A.CART_PROD=C.PROD_ID
      AND A.CART_NO LIKE '200505%'
    GROUP BY C.PROD_ID,C.PROD_NAME
    ORDER BY 1;

(외부조인-ANSI)
 SELECT C.PROD_ID AS 상품코드,
         C.PROD_NAME AS 상품명,
         SUM(A.CART_QTY*C.PROD_PRICE) AS 매출액합계,
         SUM(B.BUY_QTY*B.BUY_COST) AS 매입액합계
    FROM CART A
RIGHT OUTER JOIN PROD C ON(A.CART_PROD=C.PROD_ID
     AND A.CART_NO LIKE '200505%')
LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID
     AND B.BUY_DATE BETWEEN ' 20050501' AND '20050531')
  GROUP BY C.PROD_ID,C.PROD_NAME
  ORDER BY 1;


예제)2005년 1~6월 사이 거래처별 매입현황을 조회하시오
    Alias는 거래처코드,거래처명,매입액합계                 --BUY테이블과 BUYER테이블이 서로 중매되는것을 찾아줘야한다.(PROD)
  SELECT A.BUYER_ID AS 거래처코드,
         A.BUYER_NAME AS 거래처명,
         SUM(C.BUY_QTY*C.BUY_COST) AS 매입액합계
    FROM BUYER A, PROD B, BUYPROD C
    WHERE C.BUY_PROD = B.PROD_ID
      AND A.BUYER_ID = B.PROD_BUYER
      AND C.BUY_DATE BETWEEN '20050101' AND '20050630'
    GROUP BY A.BUYER_ID, A.BUYER_NAME
    ORDER BY 1;
    
(ANSI JOIN형식변환);
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       SUM(C.BUY_QTY*C.BUY_COST) AS 매입액합계
  FROM BUYER A
INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
INNER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID
     AND C.BUY_DATE BETWEEN '20050101' AND '20050630')
  GROUP BY A.BUYER_ID, A.BUYER_NAME
    ORDER BY 1;



 예제)장바구니테이블에서 2005년 5월 회원별 판매금액을 조회하시오          --PROD_PRICE CART_QTY
     Alias는 회원번호,회원명,구매액(ANSI INNER JOIN방식)
 SELECT A.MEM_ID AS 회원번호,
        A.MEM_NAME AS 회원명,
        SUM(B.CART_QTY*C.PROD_PRICE) AS 판매액
    FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.CART_MEMBER)
INNER JOIN PROD C ON(B.CART_PROD=C.PROD_ID
       AND CART_NO LIKE '200505%')
    GROUP BY A.MEM_ID,A.MEM_NAME
    ORDER BY 3 ;
    
    
    (기본방식);
 SELECT A.MEM_ID AS 회원번호,
        A.MEM_NAME AS 회원명,
        NVL(SUM(B.CART_QTY*C.PROD_PRICE),0) AS 판매액
   FROM MEMBER A,CART B,PROD C
  WHERE A.MEM_ID=B.CART_MEMBER
    AND B.CART_PROD=C.PROD_ID
    AND B.CART_NO LIKE '200505%'        --SUBSTR(B.CART_NO,1,6) = '200505'사용시 연산시간이 빠름
    GROUP BY A.MEM_ID,A.MEM_NAME
    ORDER BY 3 ;

--예제)사원테이블에서 관리자(MANAGER_ID)별 사원정보를 조회하시오     --DEPARTMENTS
--    Alias 관리자번호,관리자명,소속사원수,부서명이다
--  SELECT MANAGER_ID AS 관리자번호,
--         관리자명,
--         AS 소속사원수,
--         DEPARTMENT_NAME AS 부서명
--    FROM EMPLOYEES A,DEPARTMENT B
--    GROUP BY   안배운거랍니다.


        
         
    




