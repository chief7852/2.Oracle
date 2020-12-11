2020-12-11)SQL 실행 절차

--다시한번 
ROWNUM 용도
. 페이징 처리(row 1~3)
. 다른 행과 구분되는 유일한 가상의 컬럼 생성/활요
. 튜닝시
 - inline view 안에서 rownum 사용시 vuew  merging이 일어나지 않는다.


--MEMBER 테이블에서 두개의 컬럼만 조회 : MEM_ID, MEM_NAME
--이름(MEM_NAME)컬럼 오름차순으로 조회된 결과를 페이징 처리하는 쿼리를 작성하세요

SELECT *
FROM(SELECT ROWNUM rn , A.*
        FROM(SELECT MEM_ID, MEM_NAME
               FROM MEMBER
              ORDER BY MEM_NAME DESC) A)
WHERE rn BETWEEN (:PAGE-1)* :PAGESIZE + 1 AND :PAGE * :PAGESIZE;


SQL 실행 절차



+++++++++++++++++++++++
동일한 SQL이라는 것은 문자열이 완벽하게 동일해야함
공백 , 대소문자도 완벽하게 일치해야 동일한 SQL로인식
-----------------------------------------------
(바인드변수를 쓰지않으면 하나하나 SQL공유폴더에 저장값이 남아있음 공백하나 더들어가도 새로생김)
SELECT  /*DDIT*/ MEM_ID, MEM_NAME
FROM MEMBER
WHERE MEM_ID = 'a001';

(바인드 변수를 쓰지않으면 밑에 것만 저장되고 내용만 바뀜)
SELECT  /*DDIT*/ MEM_ID, MEM_NAME
FROM MEMBER
WHERE MEM_ID = :id;
        
        
        

+++++++++++++++

실행계획 확인 방법
1. 실행할 SQL 위에 EXPLAIN PLAN FOR 를 작성하고 실행
2. 실행 계획 조회
   SELECT *
   FROM TABLE(DBMS_XPLAN.DISPLAY);      --자바에 패키지 같은것 = (DBMS_XPLAN.DISPLAY)
-----------------------
EXPLAIN PLAN FOR
SELECT *
FROM MEMBER   --실행되었습니다.

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);         
/*Plan hash value: 3441279308
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |    24 |  4728 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| MEMBER |    24 |  4728 |     2   (0)| 00:00:01 |        --얘는 들여쓰기가 있으니깐 자식노드이다.
----------------------------------------------------------------------------*/

 실행계획  해석 방법
 1. 위에서 아래로
 2. 단 자식 노드(들여쓰기)가 있을경우 자식부터 읽는다            //들여쓰기가없으면 형제 노드 이다.
    0 - 1 부터 읽거나
    1 - 0 으로읽거나
----------------------------

EXPLAIN PLAN FOR
SELECT *
FROM MEMBER       
WHERE MEM_ID = 'a001';--실행되었습니다.

 SELECT *
   FROM TABLE(DBMS_XPLAN.DISPLAY);
   
   /*-----------------------------------------------------------------------------------------
| Id  | Operation                   | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |           |     1 |   197 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| MEMBER    |     1 |   197 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_MEM_ID |     1 |       |     0   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------
2 - 1 - 0 순서로 읽는다*/


-----------------------------------------

SELECT ROWID, MEMBER.*
FROM MEMBER
WHERE ROWID = 'AAAE5mAABAAALGBAAA';


EXPLAIN PLAN FOR
SELECT *
FROM MEMBER       
WHERE MEM_ID = 'a001';

SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY);
/*-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |     5 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_MEM_ID |     1 |     5 |     0   (0)| 00:00:01 |
-------------------------------------------------------------------------------
이렇게하면 테이블에 접근하지않고 바로 인덱스값만 계획해서 뱉음*/
-------------------------------------

EXPLAIN PLAN FOR
SELECT*
FROM PROD, LPROD
WHERE PROD.PROD_LGU = LPROD_GU;

SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY);
/*----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |    74 | 18352 |     6  (17)| 00:00:01 |
|*  1 |  HASH JOIN         |       |    74 | 18352 |     6  (17)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| LPROD |     9 |   180 |     2   (0)| 00:00:01 |
|   3 |   TABLE ACCESS FULL| PROD  |    74 | 16872 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------
2-3-1-0*/

