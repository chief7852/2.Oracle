SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;  



SELECT MAX(salary)
FROM employees;


SELECT employee_id, MAX(salary)
FROM employees
GROUP BY employee_id;

--14건
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD'), SYSDATE
FROM emp;

--4건
SELECT *
FROM dept;

제약조건
1. UNIQUE :값에 중복을 허용하지 않음. 단 NULL은 가능
2.primary key == UNIQUE + NOT NULL
    ==>해당컬럼 값이 테이블에서 유일함을 보장 또는 null값이 들어갈수 없다.
3.FK  : 참조 무결성
4.CHECK

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP','DEPT');

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME='PK_LPROD';





분석함수 : 행간 연산 지원을 해주는 함수
분석함수 / WINDOW 함수

(사용형식)
SELECT window_function([arg])           --[] 있을수도있고 없을수도있다(필요에따라 유무 결정)
    OVER([PARTITION BY columns][ORDER BY columns][WINDOWING])

--교수님버전
SELECT 분석함수([인자] OVER ( 영역설정 순서설정 범위설정)
FROM .....

.영역설정
PARTITION BY 컬럼
.순서설정                           --집계함수 SUM, AVG,COUNT,MIN,MAX에 OVER가 붙으면 분석함수가 된다
ORDER BY 컬럼
.범위설정
PARTITION 내에서 특정 행 까지 범위를 지정...

예) 지금하려는것 
:emp 테이블을 이용하여 부서번호 별로 급여 랭킹을 계산
        (급여 랭크 기준 : sal 값이 높은 사람이 랭크가 높은것으로 계산);
영역설정 : deptno
순서설정 : sal DESC

분석함수 : 행간 연산 지원을 해주는 함수
분석함수 / WINDOW 함수 (실습 ana0)(순위)
SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_rank,     --중복되는 월급은 둘다 같은 순위가된다 (ex.공동금메달)
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_dense_rank, --중복되는 월급은 둘다 같은 순위가된다
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_row_numver  --중복되는 월급은 다른 구분으로 중복안되게 준다.
FROM emp;

--PARTITION BY deptno : 같은 부서코드를 갖는 ROW를 그룹으로 묶는다

예)
분석함수 / WINDOW 함수 (실습 ana1)
.사원의 전체 급여 순위를 rank,dese_rank,row_number를 이용하여 구하세요
.단, 급여가 동일할 경우 사번이 빠른 사람이 높은 순위가 되도록 작성하세요 (정렬하고 중복되었을때 다른 기준으로 중복을 재정렬한다.)

SELECT empno, ename, sal, deptno,
       RANK() OVER (ORDER BY sal DESC, empno) AS sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) AS sal_dense_rank,
       ROW_NUMBER() OVER ( ORDER BY sal DESC, empno) AS sal_row_numver
FROM emp;

정렬
SELECT *
FROM emp
ORDER BY job, ;

예)
분석함수 / WINDOW 함수 (실습 ana2)
. 기존의 배운 내용을 활용하여,
  모든 사원에 대해 사원번호, 사원이름 해당사원이 속한 부서의 사원수를
  조회하는 쿼리를 작성하세요
  (방법1)
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
    
    --(방법2) 단점 효율 극악 행의 갯수만큼 실행
SELECT E.EMPNO,E.ENAME,E.DEPTNO,
        (SELECT COUNT(*)
        FROM emp
        WHERE e.deptno = emp.deptno)
FROM emp e
ORDER BY 1;

--WHERE : 조회되는 행을 제한, WHERE절에 기술한 조건이 해당행을 대상으로 참(TRUE)으로 판단될 경우 조회


--(방법3)부서별 부서원수를 4번째 컬럼으로 조회 효율 엄청좋음
SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno) AS CNT
FROM emp;


분석함수/window함수 (실습ana2)
.window fuction을 이용하여 모든 사원에 대해 사원번호, 사원이름,본인급여,부서번호와 해당 사원이 속한
 부서의 급여 평균을 조회하는 쿼리를 작성하세요( 급여 평균은 소수점 둘째 자리까지 구한다)
 
 SELECT empno, ename ,sal, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) AS AVG
  FROM EMP
  
  
  
  
  
  분석함수/window함수 (실습ana2)
.window fuction을 이용하여 모든 사원에 대해 사원번호, 사원이름,본인급여,부서번호와 해당 사원이 속한
 부서의 급여 평균을 조회하는 쿼리를 작성하세요( 급여 평균은 소수점 둘째 자리까지 구한다)(최댓값 최솟값구하기);
 
  SELECT empno, ename ,sal, deptno,
        ROUND(AVG(sal) OVER (PARTITION BY deptno),2) AS sal_avg,
        MAX(sal)OVER (PARTITION BY deptno) max_sal,
        MIN(sal)OVER (PARTITION BY deptno) min_sal
  FROM EMP;
  
  




과제 : 위의 SQL을 분석함수를 사용하지 않고 작성하기

SELECT A.EMPNO, A.ENAME ,A.SAL,A.DEPTNO, B.SAL_AVG, B.MAX_SAL, B.MIN_SAL
  FROM EMP A,(SELECT DEPTNO AS DEO,
                     ROUND(AVG(SAL),2) AS SAL_AVG,
                     MAX(SAL) AS MAX_SAL,
                     MIN(SAL) AS MIN_SAL
                     FROM EMP
                     GROUP BY DEPTNO) B
  
  WHERE A.DEPTNO = B.DEO
  ORDER BY B.SAL_AVG DESC, A.DEPTNO ;




급여 평균을 조회);
SELECT  DEPTNO,
        ROUND(AVG(SAL),2),
        GREATEST(SAL)
   FROM EMP
   GROUP BY DEPTNO;
   
   SELECT GREATEST(SAL)
   FROM EMP;
   








