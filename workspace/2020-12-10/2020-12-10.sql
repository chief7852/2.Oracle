2020-12-10)
����
�м��Լ�
1. ���� : OVER, PARTITION, ORDER BY
   �Լ� :���� RANK, DENSE_RANK, ROW_NUMBER
        �����Լ� SUM, AVG, MAX, MIN, COUNT

SELECT empno, ename, deptno
FROM emp;

SELECT *                        --ũ�ν�����, ������ ���� : �����ִ� ��簪�� ���ؼ� ���س���
FROM emp,dept;



SELECT *                        --ũ�ν�����, ������ ���� ���� ���ΰ��� deptno���� ������ ���������� ���س���
FROM emp,dept
WHERE emp.deptno != dept.deptno;


�м��Լ� /window�Լ� (�׷쳻 �� ����)
 LAG(col)
.��Ƽ�Ǻ� �����쿡�� �������� �÷���
 LEAD(col)
.��Ƽ�Ǻ� �����쿡�� ���� ���� �÷� ��
==> ���� �������� Ư�� �÷��� �����ϴ� �Լ�

7369	SMITH	20      --����
7499	ALLEN	30--����
7521	WARD	30--����
7566	JONES	20--����
7654	MARTIN	30--����
7698	BLAKE	30      --����
7782	CLARK	10--����
7788	SCOTT	20--����
7839	KING	10--����
7844	TURNER	30--����
7876	ADAMS	20--����
7900	JAMES	30--����
7902	FORD	20--����
7934	MILLER	10--����


��) �����ȣ, ����̸�, �Ի�����, �޿�, �ڽź��� �޿������� �Ѵܰ� ���� ����� �޿�
�޿�����:1. �޿��� �������
        2. �޿��� ���� ��� �Ի����ڰ� �������

SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER(ORDER BY sal DESC, hiredate ASC) LEAD,
       LEAD(sal,3) OVER(ORDER BY sal DESC, hiredate ASC) LEAD2      --3��° �ǳʶٰ� �����϶�� ��
FROM emp
ORDER BY sal DESC, hiredate ASC;


����)
�м��Լ�/window�Լ� (�׷쳻 �� ���� �ǽ� ana5)
.window fruction�� �̿��Ͽ� ��� ����� ���� �����ȣ,����̸�,�Ի�����,�޿�,��ü��� �� �޿� ������ 1�ܰ� �������
�� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���(�޿��� ���� ��� �Ի����� ���� ����� ��������)

SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER(ORDER BY sal DESC, hiredate ASC),
       LAG(sal,3) OVER(ORDER BY sal DESC, hiredate ASC) LEAD2 
  FROM emp
ORDER BY sal DESC, hiredate ASC;

�м��Լ�/window�Լ� (�׷쳻 �� ���� �ǽ� ana5-1)
.window fruction�� �̿����� �ʰ� ��� ����� ���� �����ȣ,����̸�,�Ի�����,�޿�,��ü��� �� �޿� ������ 1�ܰ� �������
�� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���(�޿��� ���� ��� �Ի����� ���� ����� ��������)

SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC )
FROM emp;



a�� 2���̸� b�� 1���� ����
a�� 3���̸� b�� 2���� ����
SELECT a.empno, a.ename,a.hiredate, a.sal,B.sal
FROM
(SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC ) rn
FROM emp) a,
(SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC ) rn
FROM emp)b
WHERE A.rn=B.rn(+)-1
ORDER BY A.RN;
--ORDER BY A.SAL


SELECT a.empno, a.ename,a.hiredate, a.sal,B.sal
FROM
(SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC ) rn
FROM emp) a LEFT OUTER JOIN
(SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC ) rn
FROM emp)b ON(b.rn=a.rn-1)
ORDER BY A.RN;


�м��Լ�/window�Լ� (�׷쳻 �� ���� �ǽ� ana5-1)
.window function�� �̿��Ͽ� ��� ����� ���� �����ȣ,����̸�,
 �Ի�����,����(job),�޿� ������ ������(JOB)�� �޿������� 1�ܰ� ����
 ����� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���
 (�޿��� ���� ��� �Ի����� ��������� ���� ����);
 
SELECT empno, ename, hiredate, job, sal,
        LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) AS LAG_SAL          --�ٽ��ѹ� PARTITION(��������)
FROM emp;




-------
SELECT empno, ename,sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  
FROM emp;

�м��Լ�/window�Լ� (�׷쳻 �� ����)
. windowing
  . window �Լ��� ����� �Ǵ� ��������
  .UNBOUNDED PRECEDING                      --��������-�⺻��
    -���� ����� ��� ����n��
  .CURRENT ROW
    -������
  .UNBOUNDED FOLLOWING:
    -������ ���� ��� ����n��
  .ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  --��������-�⺻��


����)
�����ȣ, ����̸�, �μ���ȣ,�޿������� �μ����� �޿�,�����ȣ������������ 
����������, �ڽ��� �޿��� �����ϴ� ������� �޿����� ��ȸ�ϴ� ������ �ۼ��ϼ���(window�Լ� ���);

SELECT empno, ename,deptno,sal,
       SUM (sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  AS C_SUM 
FROM emp;







ROWS / RANGE ����
�м��Լ����� ORDER BY �� ���Ŀ� WINDOWING ���� ������ ��� ������ WINDOWING�� �⺻���� ����Ǥ����ϴ�
RANGE UNBOUNDED PRECEDING
==RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
ROWS :�������� ���Ǵ���
RANGE : ������ ���� ����

SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER (ORDER BY sal) default_sum
FROM emp
                        ROW     RANGE   DEFAULT
7369	SMITH	800	    800	    800	    800
7900	JAMES	950	    1750	1750	1750
7876	ADAMS	1100	2850	2850	2850
7521	WARD	1250	--4100	--5350	5350                --ROW�� ������  RANGE�� ����
7654	MARTIN	1250	5350	5350	5350
7934	MILLER	1300	6650	6650	6650
7844	TURNER	1500	8150	8150	8150
7499	ALLEN	1600	9750	9750	9750
7782	CLARK	2450	12200	12200	12200
7698	BLAKE	2850	15050	15050	15050
7566	JONES	2975	18025	18025	18025
7788	SCOTT	3000	--21025	--24025	24025          
7902	FORD	3000	24025	24025	24025
7839	KING	5000	29025	29025	29025




ROWNUM : SELECT ������� ��ȯ�� ���� ��ȣ�� 1���� �ο����ִ� �Լ�
Ư¡ : WHERE������ ��밡��
       ���� �ǳʶٴ� ���·� ��� �Ұ�
       ==> ROWNUM�� 1���� ���������� ���� ��쿡�� ��밡��
       WHERE ROWNUM = 1; (O)
       WHERE ROUWNUM = 2; (X) //1�� �ǳ� �پ��� ������ ���������� ��ȸ���� ����
       WHERE ROWNUM < 5; (0) 1~4���� ���������� �о��⶧���� ��
       WHERE ROWNUM > 5; (X) 1~4������ �����ʰ� �ǳʶ�;
       

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 1;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM < 5;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM > 5;


1PAGE :1~10
2PAGE : 11~20

1PAGE ������ ����� 10 �϶�
1PAGE :1~10
2PAGE : 11~20
n PAGE :(:page-1) * :pageSize + 1 ~ :page *:pageSize

1PAGE ������ ����� 5 �϶�
1PAGE :1~5
2PAGE : 6~10


SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate DESC)A
WHERE ROWNUM BETWEEN 1 AND 10; --1PAGHE
2PAGE 

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM(SELECT empno, ename, hiredate
      FROM emp
      ORDER BY hiredate DESC) a)
WHERE rn BETWEEN 11 AND 20; 


SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM(SELECT empno, ename, hiredate
      FROM emp
      ORDER BY hiredate DESC) a)
WHERE rn BETWEEN (:page-1) * :pageSize+1 AND :page * :pageSize;
