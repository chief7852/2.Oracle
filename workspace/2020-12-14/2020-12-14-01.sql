2020-12-14-01)
. registdept_test procedure ����
. param : deptno, dname, loc
. logic : �Է¹��� �μ� ������ dept���̺��� �ű� �Է�
. exec registdept_test ( 99, 'ddit' , 'daejeon');
. dept_test ���̺��� ���������� �Է� �Ǿ����� Ȯ��(SQL-������)

CREATE  PROCEDURE REGISTDEPT_TEST(DEPTNO DEPT_TEST.DEPTNO%TYPE,
                                DNAME DEPT_TEST.DNAME%TYPE,
                                LOC DEPT_TEST.LOC%TYPE) IS

BEGIN
INSERT INTO DEPT_TEST VALUES (DEPTNO,DNAME, LOC);

END;
/


EXEC REGISTDEPT_TEST(98,'DDIT','����');

SELECT*
FROM DEPT_TEST;



--CTAS-- : CHECK ������ ������ ������ �������ǵ��� ������� �ʴ´�.
CREATE TABLE DEPT_TEST AS 
SELECT *
FROM DEPT
WHERE 1 = 2;

SELECT *
FROM DEPT_TEST;

INSERT INTO DEPT_TEST VALUES (99, 'DDIT', 'DAEJEON');
ROLLBACK;

DROP TABLE DEPT_TEST;



(����)
. UPDATE DEPT_TEST PROCEDURE ����
. PARAM : DEPTNO, DNAME , LOC
. LOGUC : �Է¹��� �μ� ������ DEPT_TEST ���̺��� ��������
. EXEC UPDATE DEPT_TEST (99, 'DDIT_M', 'DAEJEON');
. DEPT_TEST ���̺��� ���������� ���� �Ǿ����� Ȯ��(SQL-������)

CREATE OR REPLACE PROCEDURE UPDATEDEPT_TEST (P_DEPTNO DEPT_TEST.DEPTNO%TYPE,
                                            P_DNAME DEPT_TEST.DNAME%TYPE,
                                            P_LOC DEPT_TEST.LOC%TYPE) IS

BEGIN
  UPDATE DEPT_TEST SET DNAME = P_DNAME, LOC = P_LOC
  WHERE DEPTNO = P_DEPTNO;
  

END;
/

EXEC UPDATEDEPT_TEST (98, 'DDIT_M', '����');

SELECT *
FROM DEPT_TEST;


--�������� ����
SELECT EMPNO, ENAME, SAL
FROM EMP;


--�޿����
SELECT *
FROM SALGRADE;

SELECT A.EMPNO, A.ENAME, A.SAL, B.GRADE
FROM EMP A, SALGRADE B
WHERE A.SAL >= B.LOSAL
  AND A.SAL <= B.HISAL;
  

����)
. ������� ���� �����ȣ, ����̸�,�Ի�����,�޿��� �޿��� ����������
  ��ȸ�� ����. �޿��� ������ ��� �����ȣ�� ��������� �켱������ ����
. �켱������ ���� ���� ������� ���α����� �޿� ���� ���ο� �÷����� ����
. WINDOW �Լ�����

SELECT A.EMPNO,A.ENAME, A.SAL, SUM(B.SAL)
FROM
(SELECT EMPNO, ENAME , SAL
FROM EMP
ORDER BY SAL, EMPNO) A,
(SELECT EMPNO, ENAME , SAL
FROM EMP
ORDER BY SAL, EMPNO) B
WHERE A.SAL >= B.SAL
GROUP BY A.EMPNO, A.ENAME, A.SAL
ORDER BY A.SAL;

���� �İ� ������ ��(���� ���� ������ ��ȿ���� �ǹ̰����� IN LINE VIEW)
SELECT A.EMPNO,A.ENAME, A.SAL, SUM(B.SAL)
FROM EMP A, EMP B
WHERE A.SAL >= B.SAL
GROUP BY A.EMPNO, A.ENAME, A.SAL
ORDER BY A.SAL;



SELECT A.EMPNO, A.ENAME, A.SAL, SUM(A.SAL) OVER (ORDER BY SAL, EMPNO)
FROM EMP A;


SELECT A.EMPNO , A.ENAME, A.SAL, SUM(B.SAL) C_SUM
FROM
(SELECT A.*, ROWNUM RN
FROM
(SELECT EMPNO, ENAME, SAL
 FROM EMP
 ORDER BY SAL, EMPNO) A) A,
 (SELECT A.*, ROWNUM RN
FROM
(SELECT EMPNO, ENAME, SAL
 FROM EMP
 ORDER BY SAL, EMPNO) A) B
WHERE A.RN >= B.RN
GROUP BY A.EMPNO, A.ENAME, A.SAL
ORDER BY A.SAL, A.EMPNO;



SELECT *
FROM EMP
WHERE LOWER(ENAME) =  'smith';

SELECT *
FROM EMP
WHERE UPPER(LOWER(ENAME)) = UPPER('smith');



����)
1. ���� ���Ƿ� ����

SINGLE ROW FUNCTION : LENGTH, LOWER
MULTI ROW FUNCTION : MAX, SUM, MIN

SELECT LENGTH('HELLO,WORLD')
FROM DUAL;

SELECT EMP.* ,LENGTH('HELLO,WORLD')
FROM EMP;


SELECT

SELECT EMPNO,SAL,LEVEL
FROM DUAL
CONNECT BY LEVEL <= 10;



SELECT LEVEL RN
FROM DUAL
CONNECT BY LEVEL <= (SELECT COUNT(*) FROM EMP);


SELECT DEPTNO, COUNT(*) CNT
FROM EMP
GROUP BY DEPTNO;

SELECT ROWNUM R,B.*
FROM
(SELECT  A.DEPTNO, B.RN
FROM
(SELECT DEPTNO, COUNT(*) CNT
FROM EMP
GROUP BY DEPTNO)A,
(SELECT LEVEL RN
FROM DUAL
CONNECT BY LEVEL <= (SELECT COUNT(*) FROM EMP))B
WHERE  A. CNT >=B.RN
ORDER BY A.DEPTNO, B.RN)B;







SELECT  A.empno, a.sal, a.deptno, B.rn
FROM
(SELECT ROWNUM r, a.*
FROM 
(SELECT empno, sal, deptno
 FROM emp
 ORDER BY deptno, sal, empno) a ) a, 
 
 (SELECT ROWNUM r, b.*
FROM 
(SELECT a.deptno, b.rn
FROM
(SELECT deptno, COUNT(*) cnt
 FROM emp
 GROUP BY deptno) a,

(SELECT LEVEL rn
 FROM dual
 CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp)) b
WHERE a.cnt >= b.rn
ORDER BY a.deptno, b.rn) b ) b
WHERE a.r = b.r;


PL/SQL (���պ���)















