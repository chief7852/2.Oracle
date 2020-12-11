2020-12-11)SQL ���� ����

--�ٽ��ѹ� 
ROWNUM �뵵
. ����¡ ó��(row 1~3)
. �ٸ� ��� ���еǴ� ������ ������ �÷� ����/Ȱ��
. Ʃ�׽�
 - inline view �ȿ��� rownum ���� vuew  merging�� �Ͼ�� �ʴ´�.


--MEMBER ���̺��� �ΰ��� �÷��� ��ȸ : MEM_ID, MEM_NAME
--�̸�(MEM_NAME)�÷� ������������ ��ȸ�� ����� ����¡ ó���ϴ� ������ �ۼ��ϼ���

SELECT *
FROM(SELECT ROWNUM rn , A.*
        FROM(SELECT MEM_ID, MEM_NAME
               FROM MEMBER
              ORDER BY MEM_NAME DESC) A)
WHERE rn BETWEEN (:PAGE-1)* :PAGESIZE + 1 AND :PAGE * :PAGESIZE;


SQL ���� ����



+++++++++++++++++++++++
������ SQL�̶�� ���� ���ڿ��� �Ϻ��ϰ� �����ؾ���
���� , ��ҹ��ڵ� �Ϻ��ϰ� ��ġ�ؾ� ������ SQL���ν�
-----------------------------------------------
(���ε庯���� ���������� �ϳ��ϳ� SQL���������� ���尪�� �������� �����ϳ� ������ ���λ���)
SELECT  /*DDIT*/ MEM_ID, MEM_NAME
FROM MEMBER
WHERE MEM_ID = 'a001';

(���ε� ������ ���������� �ؿ� �͸� ����ǰ� ���븸 �ٲ�)
SELECT  /*DDIT*/ MEM_ID, MEM_NAME
FROM MEMBER
WHERE MEM_ID = :id;
        
        
        

+++++++++++++++

�����ȹ Ȯ�� ���
1. ������ SQL ���� EXPLAIN PLAN FOR �� �ۼ��ϰ� ����
2. ���� ��ȹ ��ȸ
   SELECT *
   FROM TABLE(DBMS_XPLAN.DISPLAY);      --�ڹٿ� ��Ű�� ������ = (DBMS_XPLAN.DISPLAY)
-----------------------
EXPLAIN PLAN FOR
SELECT *
FROM MEMBER   --����Ǿ����ϴ�.

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);         
/*Plan hash value: 3441279308
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |    24 |  4728 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| MEMBER |    24 |  4728 |     2   (0)| 00:00:01 |        --��� �鿩���Ⱑ �����ϱ� �ڽĳ���̴�.
----------------------------------------------------------------------------*/

 �����ȹ  �ؼ� ���
 1. ������ �Ʒ���
 2. �� �ڽ� ���(�鿩����)�� ������� �ڽĺ��� �д´�            //�鿩���Ⱑ������ ���� ��� �̴�.
    0 - 1 ���� �аų�
    1 - 0 �����аų�
----------------------------

EXPLAIN PLAN FOR
SELECT *
FROM MEMBER       
WHERE MEM_ID = 'a001';--����Ǿ����ϴ�.

 SELECT *
   FROM TABLE(DBMS_XPLAN.DISPLAY);
   
   /*-----------------------------------------------------------------------------------------
| Id  | Operation                   | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |           |     1 |   197 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| MEMBER    |     1 |   197 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_MEM_ID |     1 |       |     0   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------
2 - 1 - 0 ������ �д´�*/


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
�̷����ϸ� ���̺� ���������ʰ� �ٷ� �ε������� ��ȹ�ؼ� ����*/
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

