2020-12-01-03) JOIN++++++++++++++++++++++++++++++++++++++           --공통컬럼이있어야함
  - RDB의 핵심 기능
  - 관계형데이터 베이스는 자료가 여러 테이블에 분산되어 저장되고
    테이블 간의 관계가 맺어져 있음
  - 따라서 여러 테이블에서 필요한 자료를 조회하기 위해 조인연산이 필요
  - 조인연산은 연산에 참여하는 테이블 간의 관계가 맺어져 있음을 전제로 함
  
  (JOIN의 종류)
  1)방식에 따라 : 일반조인, ANSI 조인
  2)조인 조건에 사용하는 연산자에 따라 EQUI JOIN, NON EQUI JOIN
  3)참가하는 행들의 확장 여부에 따라 내부조인(INNER JOIN), 외부조인(OUTER JOIN)
  4)그 밖에 SELF JOIN, CARTESIAN PRODUCT(CROSS JOIN) 등으로 나뉨
  (사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2] [,테이블명3 [별칭3], ...]           --별칭은 되도록 영어로 붙여야 좋음
    WHERE 조인조건1
     [AND 조인조건2,...]
     [AND 일반조건,...]
    . 테이블명에는 별칭을 사용하여 동일한 컬럼명이 두개 이상의 테이블에 사용된 경우
      소속을 구별해줌
    . 별칭을 사용하지 않는 경우 동일한 컬럼명은 '테이블명.컬럼명' 형식으로 기술해야함
    . 조인조건은 두 테이블 사이에 존재하는 같은 값을 갖는 컬럼간의 동등성 ('=')
      등을 평가하기 위한 조건으로 N개의 테이블이 사용된 경우 적어도 n-1개 이상의 조인조건이
      필요함
    . 일반조건과 조인조건의 기술 순서는 일정한 규칙이 없음
  
  
1. CARTESUAN PRODUCT  --위험함
  - 모든 행, 모든 열의 조합이 발생(행들은 곱한 값, 열들은 더한 값)
  - 특별한 목적이 아닌 경우 사용되지 않음
  - 조인조건이 없거나 잘못설정된 경우에도 발생됨
  - ANSI에서는 CROSS JOIN
  
  예)
  SELECT COUNT(*) FROM CART;
  SELECT COUNT(*) FROM CUSTOMERS;
  
  
  SELECT COUNT(*)
    FROM CART A, CUSTOMERS B;

==(ANSI 형식)==
  SELECT COUNT(*)
    FROM CART 
   CROSS JOIN CUSTOMERS
   CROSS JOIN PROD;
  
  
2. EQUI JOIN(동등 조인)
 - 대부분의 조인 형식
 - 조인조건에 '='연산자가 사용됨
 - ANSI에서는 INNER JOIN으로 구현 됨
 (ANSI 사용형식)
 SELECT 컬럼list
    FROM 테이블명1[별칭]
  INNER JOIN 테이블명2[별칭] ON(조인조건
    [AND 일반조건])
  [INNER JOIN 테이블명3[별칭] ON(조인조건
    [AND 일반조건])]
  [WHERE 일반조건]
  
예)장바구니테이블에서 2005년 6월 판매현황을 조회하시오
   Alias는 일자,회원명,상품명,판매수량,판매금액
   SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 일자,
          B.MEM_NAME AS 회원명,
          C.PROD_NAME AS 상품명,
          A.CART_QTY AS 판매수량,
          A.CART_QTY*C.PROD_PRICE AS 판매금액
   FROM CART A, MEMBER B, PROD C
   WHERE A.CART_MEMBER = B.MEM_ID             --조인조건
    AND  A.CART_PROD = C.PROD_ID            --조인조건
    AND  A.CART_NO LIKE '200506%'
   ORDER BY 1;
  
  
  
  
  
  
  
  
  
  
  
  
  
  