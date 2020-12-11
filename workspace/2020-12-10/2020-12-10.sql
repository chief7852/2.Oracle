2020-12-10)
복습
분석함수
1. 문법 : OVER, PARTITION, ORDER BY
   함수 :순위 RANK, DENSE_RANK, ROW_NUMBER
        집계함수 SUM, AVG, MAX, MIN, COUNT

SELECT empno, ename, deptno
FROM emp;

SELECT *                        --크로스조인, 묻지마 조인 : 낼수있는 모든값을 곱해서 구해낸다
FROM emp,dept;



SELECT *                        --크로스조인, 묻지마 조인 에서 서로같은 deptno값을 제외한 나머지값을 구해낸다
FROM emp,dept
WHERE emp.deptno != dept.deptno;


분석함수 /window함수 (그룹내 행 순서)
 LAG(col)
.파티션별 윈도우에서 이전행의 컬럼값
 LEAD(col)
.파티션별 윈도우에서 이후 행의 컬럼 값
==> 이전 이후행의 특정 컬럼을 참조하는 함수

7369	SMITH	20      --이전
7499	ALLEN	30--이전
7521	WARD	30--이전
7566	JONES	20--이전
7654	MARTIN	30--이전
7698	BLAKE	30      --기준
7782	CLARK	10--이후
7788	SCOTT	20--이후
7839	KING	10--이후
7844	TURNER	30--이후
7876	ADAMS	20--이후
7900	JAMES	30--이후
7902	FORD	20--이후
7934	MILLER	10--이후


예) 사원번호, 사원이름, 입사일자, 급여, 자신보다 급여순위가 한단계 낮은 사람의 급여
급여순위:1. 급여가 높은사람
        2. 급여가 같을 경우 입사일자가 빠른사람

SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER(ORDER BY sal DESC, hiredate ASC) LEAD,
       LEAD(sal,3) OVER(ORDER BY sal DESC, hiredate ASC) LEAD2      --3번째 건너뛰고 측정하라는 뜻
FROM emp
ORDER BY sal DESC, hiredate ASC;


예제)
분석함수/window함수 (그룹내 행 순서 실습 ana5)
.window fruction을 이용하여 모든 사원에 대해 사원번호,사원이름,입사일자,급여,전체사원 중 급여 순위가 1단계 높은사람
의 급여를 조회하는 쿼리를 작성하세요(급여가 같을 경우 입사일이 빠른 사람이 높은순위)

SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER(ORDER BY sal DESC, hiredate ASC),
       LAG(sal,3) OVER(ORDER BY sal DESC, hiredate ASC) LEAD2 
  FROM emp
ORDER BY sal DESC, hiredate ASC;

분석함수/window함수 (그룹내 행 순서 실습 ana5-1)
.window fruction을 이용하지 않고 모든 사원에 대해 사원번호,사원이름,입사일자,급여,전체사원 중 급여 순위가 1단계 높은사람
의 급여를 조회하는 쿼리를 작성하세요(급여가 같을 경우 입사일이 빠른 사람이 높은순위)

SELECT empno, ename, hiredate, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC, hiredate ASC )
FROM emp;



a가 2위이면 b의 1위와 연결
a가 3위이면 b의 2위와 연결
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


분석함수/window함수 (그룹내 행 순서 실습 ana5-1)
.window function을 이용하여 모든 사원에 대해 사원번호,사원이름,
 입사일자,직군(job),급여 정보와 담당업무(JOB)별 급여순위가 1단계 높은
 사람의 급여를 조회하는 쿼리를 작성하세요
 (급여가 같을 경우 입사일이 빠른사람이 높은 순위);
 
SELECT empno, ename, hiredate, job, sal,
        LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) AS LAG_SAL          --다시한번 PARTITION(영역지정)
FROM emp;




-------
SELECT empno, ename,sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  
FROM emp;

분석함수/window함수 (그룹내 행 순서)
. windowing
  . window 함수에 대상이 되는 행을지정
  .UNBOUNDED PRECEDING                      --범위설정-기본값
    -현재 행기준 모든 이전n행
  .CURRENT ROW
    -현재행
  .UNBOUNDED FOLLOWING:
    -현재행 기준 모든 이후n행
  .ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  --범위설정-기본값


예제)
사원번호, 사원이름, 부서번호,급여정보를 부서별로 급여,사원번호오름차순으로 
정렬했을때, 자신의 급여와 선행하는 사원들의 급여합을 조회하는 쿼리를 작성하세요(window함수 사용);

SELECT empno, ename,deptno,sal,
       SUM (sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  AS C_SUM 
FROM emp;







ROWS / RANGE 차이
분석함수에서 ORDER BY 절 이후에 WINDOWING 절을 생략할 경우 다음의 WINDOWING이 기본으로 적요ㅗㅇ도니다
RANGE UNBOUNDED PRECEDING
==RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
ROWS :물리적인 행의단위
RANGE : 논리적인 행의 단위

SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER (ORDER BY sal) default_sum
FROM emp
                        ROW     RANGE   DEFAULT
7369	SMITH	800	    800	    800	    800
7900	JAMES	950	    1750	1750	1750
7876	ADAMS	1100	2850	2850	2850
7521	WARD	1250	--4100	--5350	5350                --ROW는 물리적  RANGE는 논리적
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




ROWNUM : SELECT 순서대로 반환된 행의 번호를 1부터 부여해주는 함수
특징 : WHERE절에서 사용가능
       행을 건너뛰는 형태로 사용 불가
       ==> ROWNUM이 1부터 순차적으로 사용된 경우에만 사용가능
       WHERE ROWNUM = 1; (O)
       WHERE ROUWNUM = 2; (X) //1을 건너 뛰었기 때문에 정상적으로 조회되지 않음
       WHERE ROWNUM < 5; (0) 1~4까지 순차적으로 읽었기때문에 됨
       WHERE ROWNUM > 5; (X) 1~4까지를 읽지않고 건너뜀;
       

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

1PAGE 페이즈 사이즈가 10 일때
1PAGE :1~10
2PAGE : 11~20
n PAGE :(:page-1) * :pageSize + 1 ~ :page *:pageSize

1PAGE 페이즈 사이즈가 5 일때
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
