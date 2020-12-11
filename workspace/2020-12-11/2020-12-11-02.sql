2020-12-11-02) PL/SQL
--JAVA 변수타입 변수명 = 변수값;    PL/SQL 변수명 변수타입 := 변수값;
. Procedural Language/SQL

. 오라클에서 제공하는 프로그래밍 언어

++. 집학적 성향이 강한 SQL에 일반 프로그래밍 언어 요소를 추가
    - SQL에서 지원하지 않는 반복문,조건문을 지원
   
. 데이터를 절차적으로 처리하는데 그 목적

. 기본구조                      
  - Declare(선언부)            //sql은 변수를 사용하기전에 그 이전에 미리 선언을 해줘야한다.
    _변수,상수 선언
    _생략가능
  -Begin(실행부)++             //SQL, IF, LOOP
    _제어문, 반복문 등의 로직실행
  -Exceptiom(예외 처리부)
    _실행 도중 에러발생을 catch,후속조치
    _생략가능
    
  /식별자 작성규칙 30자 이상넘어가면안됨


. 연산자
:= 대입 연산자
** 제곱 연산자
NOT	논리 연산자
AND	논리 연산자
OR	논리 연산자





예)
1. 10번 부서의 DANME, LOC 컬럼 두개를 변수에 담는다
2. 두개의 변수값을 출력(JAVA : SYSTEM.OUT.PRINTLN)
SELECT *
FORM DEPT;

DESC DEPT;              --테이블 타입 알아보기
/*DEPTNO    NUMBER(2)    
  DNAME     VARCHAR2(14) 
  LOC       VARCHAR2(13) */

변수선언 : 변수명 변수타입;
PL/SQL : 변수명 작명시 V_'XXX' 접두어 사용''에 이름적음

SET SERVEROUTPUT ON;

DECLARE
    V_DNAME VARCHAR2(14);
    V_LOC VARCHAR2(13);
BEGIN
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
      FROM DEPT
     WHERE DEPTNO = 10;
     
--     Saytem.out.println(v_dname + " / " + v_loc);       --그냥예시임
     DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);              --PRINT = DBMS_OUTPUT.PUT_LINE 출력하는거
END;
/   --PL/SQL 의 종료(마무리)는 ;가 아닌 / 슬래시로 한다





----------------
VIEW 는 쿼리이다 라고 생각하면 될것같다.            
---------------



참조변수++++++++++++++++++++++++++++
(사용방법 : 테이블명.컬럼명%TYPE;
 쓰는이유 : 특정테이블의 컬럼의 데이터 타입을 자동으로 참조 => 컬럼의 데이터 타입이 바뀌어도
            PL/SQL 블록의 변수 선언부를 수정할 필요가 없어짐 : 유지보수에 유리);

DECLARE
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
      FROM DEPT
     WHERE DEPTNO = 10;
     
--     System.out.println(v_dname + " / " + v_loc);       --그냥예시임
     DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);              --PRINT = DBMS_OUTPUT.PUT_LINE 출력하는거
END;
/


PL/SQL BLOCK 구분
1. 익명 블럭 : inline-view
2. procedure : 오라클 서버에 저장한 pl/sql 블럭, 리턴값은 없다
3. function : 오라클 서버에 저장한 pl/sql 블럭, 리턴값이 있다


(2. procedure예제)
CREATE 오라클객체타입 객체이름....
/*
CREATE TABLE 테이블명
CREATE OR REPLACE VIEW 뷰이름*/

(사용형식)
CREATE PROCEDURE printdept IS 
    --선언부
BEGIN
END;
/
------------

CREATE OR REPLACE PROCEDURE printdept IS 
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME , V_LOC
    FROM DEPT
   WHERE DEPTNO = 10;
   
   DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);
END;
/
/*프로 시져 실행은
EXEC 프로시져명 */

EXEC printdept;

-- WHERE DEPTNO = 10; 이값을 인자형태로 변환해서
--할거임
--------------
현재 프로시져는 10번 부서의 정보만 조회가 되게끔 코드가 구성됨(hard coding)
procedure 인자로 조회하고 싶은 부서번호를 받도록 수정하여 코드를 유연하게 만들어보자

프로시져를 생성할때 인자를 프로시져명 뒤에 선언할수 있음
인자는 메소드와 마찬가지로 여러개를 받을 수 있음

수업시간에는 프로시져에서 인자 이름을 P_XXX접두어를 사용하기로 합시다.

--CREATE OR REPLACE PROCEDURE[(인자명 인자 타입)] 추가
CREATE OR REPLACE PROCEDURE printdept(P_DEPTNO DEPT.DEPTNO%TYPE) IS 
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME , V_LOC
    FROM DEPT
   WHERE DEPTNO = P_DEPTNO;
   
   DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);
END;
/

EXEC printdept(50);

(예제)
PL/SQL(PROCEDURE 생성실습 PRO_1)
 -PRINTEMP PROCEDURE 생성
 -PARAM : EMPNO
 -LOGIC : EMPNO에 해당하는 사원의 정보를 조회하여
          사원이름, 부서이름을 화면에 출력
    

CREATE OR REPLACE PROCEDURE PRINTEMP (P_EMPNO EMP.EMPNO%TYPE) IS
    V_ENAME EMP.ENAME%TYPE;
    V_DNAME DEPT.DNAME%TYPE;
BEGIN
    SELECT A.ENAME,B.DNAME INTO V_ENAME , V_DNAME
      FROM EMP A,DEPT B
     WHERE A.EMPNO = P_EMPNO
       AND A.DEPTNO = B.DEPTNO;
     
 DBMS_OUTPUT.PUT_LINE(V_ENAME || ' / ' || V_DNAME);
 END;
 /
 
EXEC PRINTEMP(7902);
