2020-12-04-01)서브쿼리
 - 쿼리안에 포함된 또다른 쿼리를 서브쿼리라고 함
 - 서브쿼리는 '()' 안에 기술
 - 각 절에서 제일 먼저 실행됨
 - 연산자와 같이 사용될 경우 연산자 오른쪽에 사용해야 함
  (서브쿼리의 종류)
 - 메인쿼리와 연관성 여부에 따라 : 연관성 있는 서브쿼리 (Correlated Subquery)와 비연관성 서브쿼리
    (Noncorrelated subquery)로 구분
 - 사용되는 위치에 따라 : 일반 서브쿼리 (Select 절에 사용), 인라인 서브쿼리(From 절에 사용),
                        중첩 서브쿼리 (Where절에 사용)로 구분
 - 반환하는 행/열의 수에 따라 : 단일행/단일열, 다중행/단일열, 다중행/다중렬 등으로 구분되며 이는
    사용하는 연산자에 의해 구별됨
    
1. 연관성없는 서브쿼리
 - 메인쿼리와 서브쿼리 사이에 조인이 발생되지 않는 서브쿼리
예) 사원테이블에서 평균급여보다 많은 급여를 받는 사원정보(사원번호,사원명,부서코드,급여)조회
    (메인쿼리: 사원번호,사원명,부서코드,급여 조회)
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서코드,
         SALARY AS 급여
    FROM EMPLOYEES
   WHERE SALARY >= (평균급여);
   
   (서브쿼리:평균급여)
  SELECT AVG(SALARY)
    FROM EMPLOYEES;

 (결합)
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서코드,
         SALARY AS 급여
    FROM EMPLOYEES
   WHERE SALARY >= (SELECT AVG(SALARY)
                        FROM EMPLOYEES);


예)부모부서코드(PRARENT_ID)가 NULL인 부서에 소속된 사원정보를 조회하시오
   Alias는 사원번호,사원명,부서코드,직책코드(JOB_ID)
(메인쿼리:사원테이블에서 사원정보를 조회)
 SELECT EMPOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        JOB_ID AS 직책코드
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID =  (부모부서코드(PARENT_ID)가 NULL인 부서코드)
  
  (서브쿼리 : 부서테이블에서 부모부서코드(PARENT_ID)가 NULL인 부서코드)
  SELECT DEPARTMENT_ID AS 사원번호
    FROM DEPARTMENTS
  WHERE PARENT_ID IS NULL;
  
  
** 부서테이블에서 부서코드 60(IT)의 부모부서코드를 NULL로 변경하시오
  UPDATE DEPARTMENTS
  SET PARENT_ID=NULL
  WHERE DEPARTMENT_ID = 60;
  
   SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        JOB_ID AS 직책코드
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID IN  (SELECT DEPARTMENT_ID AS 사원번호 --
                            FROM DEPARTMENTS
                           WHERE PARENT_ID IS NULL);
  
 SELECT A.EMPLOYEE_ID AS 사원번호,
        A.EMP_NAME AS 사원명,
        A.DEPARTMENT_ID AS 부서코드,
        A.JOB_ID AS 직책코드
   FROM EMPLOYEES A
  WHERE EXISTS (SELECT 1 
                        FROM DEPARTMENTS B
                        WHERE B.PARENT_ID IS NULL
                         AND A.DEPARTMENT_ID = A.DEPARTMENT_ID);
  

2.연관성 서브쿼리
 - 메인쿼리와 서브쿼리 사이에 조인이 발생되는 서브쿼리
 
 
 예) 직무이력테이블(JOB_HISTORY)에서 사원정보를 조회하시오
     Alias는 사원번호,사원명,부서코드,부서명
 SELECT A.EMPLOYEE_ID AS 사원번호,
        (SELECT B.EMP_NAME
            FROM EMPLOYEES B
            WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID) AS 사원명,
            A.DEPARTMENT_ID AS 부서코드,
            (SELECT C.DEPARTMENT_NAME
                FROM DEPARTMENTS C
                WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID) AS 부서명
        FROM JOB_HISTORY A;
        

 예제) 상품테이블에서 서브쿼리를 사용하여 'P300'번대의 상품의 
        상품코드,상품명,분류코드,분류명을 출력하시오.
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         A.PROD_LGU AS 분류코드,
                (SELECT B.LPROD_NM
                   FROM LPROD B
                  WHERE A.PROD_LGU=B.LPROD_GU)AS  분류명
    FROM PROD A
   WHERE A.PROD_ID LIKE 'P3%';
  
예제)사원들의 평균급여를 계산하여 평균급여보다 더 많은 급여를 받는 사원들이
    소속된 부서코드와 부서명을 출력하시오(SUBQUERY 사용)
  (메인쿼리:부서테이블에서 부서코드와 부서명을 출력);
  SELECT A.DEPARTMENT_ID AS 부서코드,
         A.DEPARTMENT_NAME AS 부서명
    FROM DEPARTMENTS A
   WHERE A.DEPARTMENT_ID IN (평균급여보다 더 많은 급여를 받는 사원들이 소속된 부서)
   
   
(서브쿼리1:사원테이블에서 평균급여보다 더 많은 급여를 받는 사원들이소속된 부서);
 SELECT B.DEPARTMENT_ID
   FROM EMPLOYEES B
  WHERE B.SALARY > (평균급여);
  
(서브쿼리2:평균급여);
 SELECT AVG(SALARY)
   FROM EMPLOYEES;
   
   
(결합하기 : IN);
  SELECT A.DEPARTMENT_ID AS 부서코드,
         A.DEPARTMENT_NAME AS 부서명
    FROM DEPARTMENTS A
   WHERE A.DEPARTMENT_ID IN ( SELECT B.DEPARTMENT_ID
                                FROM EMPLOYEES B
                               WHERE B.SALARY > (SELECT AVG(SALARY)
                                                   FROM EMPLOYEES))
  ORDER BY 1;                                               
  
  
  (결합하기 : EXISTS사용);
    SELECT A.DEPARTMENT_ID AS 부서코드,
         A.DEPARTMENT_NAME AS 부서명
    FROM DEPARTMENTS A
   WHERE EXISTS  ( SELECT 1
                    FROM EMPLOYEES B
                   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                     AND B.SALARY > (SELECT AVG(SALARY)
                                        FROM EMPLOYEES))
  ORDER BY 1;                                               
  
  
 예) 상위부서가 90번부서(기획부)인 사원들의 급여를 자신이 속해있는 부서의
     평균급여의 10%에 해당하는 만큼 급여를 인상하시오
     
   (메인쿼리: 상위부서가 90번부서(기획부)인 부서의 평균급여);
   SELECT A.DEPARTMENT_ID,
          AVG(A.SALARY) 
     FROM EMPLOYEES A, DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND B.PARENT_ID=90
  GROUP BY A.DEPARTMENT_ID;
  
  
  
   CREATE OR REPLACE VIEW V_EMP01
  AS
        SELECT A.EMP_NAME, A.SALARY, A.DEPARTMENT_ID
          FROM EMPLOYEES A
        WHERE A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                  WHERE PARENT_ID=90)
        ORDER BY 3
        WITH READ ONLY;
SELECT * FROM V_EMP01;
--  (UPDATE);
  UPDATE EMPLOYEES C
     SET C.SALARY= (SELECT ROUND(C.SALARY+TBLA.SAL)
                    FROM (SELECT A.DEPARTMENT_ID AS DEPTID,
                                 AVG(A.SALARY)*0.1 AS SAL 
                            FROM EMPLOYEES A, DEPARTMENTS B
                           WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                             AND B.PARENT_ID=90
                         GROUP BY A.DEPARTMENT_ID) TBLA
                    WHERE C.DEPARTMENT_ID = TBLA.DEPTID)
        WHERE C.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                   WHERE PARENT_ID = 90);
                                   
                                   
    SELECT * FROM V_EMP01;


  ROLLBACK;
  
  
  
   SELECT A.EMP_NAME, A.SALARY, A.DEPARTMENT_ID
     FROM EMPLOYEES A
    WHERE A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                  WHERE PARENT_ID=90)
        ORDER BY 3;
  
  
  
  
  
  
  
  
  
  