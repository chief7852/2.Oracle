SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;  



SELECT MAX(salary)
FROM employees;


SELECT employee_id, MAX(salary)
FROM employees
GROUP BY employee_id;

--14��
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD'), SYSDATE
FROM emp;

--4��
SELECT *
FROM dept;

��������
1. UNIQUE :���� �ߺ��� ������� ����. �� NULL�� ����
2.primary key == UNIQUE + NOT NULL
    ==>�ش��÷� ���� ���̺��� �������� ���� �Ǵ� null���� ���� ����.
3.FK  : ���� ���Ἲ
4.CHECK

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP','DEPT');

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME='PK_LPROD';





�м��Լ� : �ణ ���� ������ ���ִ� �Լ�
�м��Լ� / WINDOW �Լ�

(�������)
SELECT window_function([arg])           --[] ���������ְ� ���������ִ�(�ʿ信���� ���� ����)
    OVER([PARTITION BY columns][ORDER BY columns][WINDOWING])

--�����Թ���
SELECT �м��Լ�([����] OVER ( �������� �������� ��������)
FROM .....

.��������
PARTITION BY �÷�
.��������                           --�����Լ� SUM, AVG,COUNT,MIN,MAX�� OVER�� ������ �м��Լ��� �ȴ�
ORDER BY �÷�
.��������
PARTITION ������ Ư�� �� ���� ������ ����...

��) �����Ϸ��°� 
:emp ���̺��� �̿��Ͽ� �μ���ȣ ���� �޿� ��ŷ�� ���
        (�޿� ��ũ ���� : sal ���� ���� ����� ��ũ�� ���������� ���);
�������� : deptno
�������� : sal DESC

�м��Լ� : �ణ ���� ������ ���ִ� �Լ�
�м��Լ� / WINDOW �Լ� (�ǽ� ana0)(����)
SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_rank,     --�ߺ��Ǵ� ������ �Ѵ� ���� �������ȴ� (ex.�����ݸ޴�)
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_dense_rank, --�ߺ��Ǵ� ������ �Ѵ� ���� �������ȴ�
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_row_numver  --�ߺ��Ǵ� ������ �ٸ� �������� �ߺ��ȵǰ� �ش�.
FROM emp;

--PARTITION BY deptno : ���� �μ��ڵ带 ���� ROW�� �׷����� ���´�

��)
�м��Լ� / WINDOW �Լ� (�ǽ� ana1)
.����� ��ü �޿� ������ rank,dese_rank,row_number�� �̿��Ͽ� ���ϼ���
.��, �޿��� ������ ��� ����� ���� ����� ���� ������ �ǵ��� �ۼ��ϼ��� (�����ϰ� �ߺ��Ǿ����� �ٸ� �������� �ߺ��� �������Ѵ�.)

SELECT empno, ename, sal, deptno,
       RANK() OVER (ORDER BY sal DESC, empno) AS sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) AS sal_dense_rank,
       ROW_NUMBER() OVER ( ORDER BY sal DESC, empno) AS sal_row_numver
FROM emp;

����
SELECT *
FROM emp
ORDER BY job, ;

��)
�м��Լ� / WINDOW �Լ� (�ǽ� ana2)
. ������ ��� ������ Ȱ���Ͽ�,
  ��� ����� ���� �����ȣ, ����̸� �ش����� ���� �μ��� �������
  ��ȸ�ϴ� ������ �ۼ��ϼ���
  (���1)
SELECT A.EMPNO,
       A.ENAME,
       A.DEPTNO,
       B.CNT
FROM emp A,(SELECT  DEPTNO ,
                    COUNT (*) AS CNT
               FROM emp
           GROUP BY DEPTNO)B
WHERE A.DEPTNO=B.DEPTNO;






10 : SELECT COUNT(*)
      FROM emp
    WHERE deptno = 10;
    
    --(���2) ���� ȿ�� �ؾ� ���� ������ŭ ����
SELECT E.EMPNO,E.ENAME,E.DEPTNO,
        (SELECT COUNT(*)
        FROM emp
        WHERE e.deptno = emp.deptno)
FROM emp e
ORDER BY 1;

--WHERE : ��ȸ�Ǵ� ���� ����, WHERE���� ����� ������ �ش����� ������� ��(TRUE)���� �Ǵܵ� ��� ��ȸ


--(���3)�μ��� �μ������� 4��° �÷����� ��ȸ ȿ�� ��û����
SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno) AS CNT
FROM emp;


�м��Լ�/window�Լ� (�ǽ�ana2)
.window fuction�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�,���α޿�,�μ���ȣ�� �ش� ����� ����
 �μ��� �޿� ����� ��ȸ�ϴ� ������ �ۼ��ϼ���( �޿� ����� �Ҽ��� ��° �ڸ����� ���Ѵ�)
 
 SELECT empno, ename ,sal, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) AS AVG
  FROM EMP
  
  
  
  
  
  �м��Լ�/window�Լ� (�ǽ�ana2)
.window fuction�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�,���α޿�,�μ���ȣ�� �ش� ����� ����
 �μ��� �޿� ����� ��ȸ�ϴ� ������ �ۼ��ϼ���( �޿� ����� �Ҽ��� ��° �ڸ����� ���Ѵ�)(�ִ� �ּڰ����ϱ�);
 
  SELECT empno, ename ,sal, deptno,
        ROUND(AVG(sal) OVER (PARTITION BY deptno),2) AS sal_avg,
        MAX(sal)OVER (PARTITION BY deptno) max_sal,
        MIN(sal)OVER (PARTITION BY deptno) min_sal
  FROM EMP;
  
  




���� : ���� SQL�� �м��Լ��� ������� �ʰ� �ۼ��ϱ�

SELECT A.EMPNO, A.ENAME ,A.SAL,A.DEPTNO, B.SAL_AVG, B.MAX_SAL, B.MIN_SAL
  FROM EMP A,(SELECT DEPTNO AS DEO,
                     ROUND(AVG(SAL),2) AS SAL_AVG,
                     MAX(SAL) AS MAX_SAL,
                     MIN(SAL) AS MIN_SAL
                     FROM EMP
                     GROUP BY DEPTNO) B
  
  WHERE A.DEPTNO = B.DEO
  ORDER BY B.SAL_AVG DESC, A.DEPTNO ;




�޿� ����� ��ȸ);
SELECT  DEPTNO,
        ROUND(AVG(SAL),2),
        GREATEST(SAL)
   FROM EMP
   GROUP BY DEPTNO;
   
   SELECT GREATEST(SAL)
   FROM EMP;
   








