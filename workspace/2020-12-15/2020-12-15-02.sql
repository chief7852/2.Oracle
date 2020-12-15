2020-12-15-02) 커서(CURSOR)
 - 쿼리의 실행에 영향받은 행들의 집합
 - 묵시적 커서와 명시적 커서로 구분
 - 선언부에서 선언될수있다
1) 묵시적 커스 (IMPLICIT CURSOR)
    . SQL 명령이 실행되면 자동으로 생성되는 커서
    . 익명커서
    . 실행결과의 출력이 종료됨과 동시에 CLOSE되어 사용자가 접근할 수 없음
    . 커서 속성
---------------------------------------------------------------------
    속성명         설명
---------------------------------------------------------------------
  SQL%FOUND       커서에 하나의 행이라도 존재하면 참(TRUE) 반환
  SQL%NOTFOUND    커서에 하나의 행이라도 존재하면 거짓(FALSE) 반환
  SQL%ISOPEN      커서가 OPEN되었으면 참(익명커서는 항상 FALSE)
  SQL%ROWCOUNT    커서에 포함된 행의 수
  
  
예)회원테이블에서 거주지가 '대전'인 회원의 이름을 자신의 이름으로 변경하고 
   몇건이 처리 되었는지 확인하는 익명블록을 작성하시오

DECLARE

BEGIN
    UPDATE MEMBER
      SET  MEM_NAME = MEM_NAME
     WHERE MEM_ADD1 LIKE '대전%';
     
      DBMS_OUTPUT.PUT_LINE('처리건수 : '||SQL%ROWCOUNT);
END; 
 
 
 
 
 
 
 
 SELECT COUNT (*)
 FROM MEMBER
 WHERE MEM_ADD1 LIKE '대전%';

2)명시적 커서(EXPLICIT CURSOR) 
 . 사용자가 선언부에서 선언한 커서
 . 커서의 사용단계는 생성 ->OPEN->FETCH->CLOSE이다
 . 커서 결과집합을 행단위로 접근하여 참조된 데이터를 이용한 조작처리가 목적(SELECT 문에 의한 커서 생성)
 (1)생성
 (선언형식)CURSOR 커서명[(매개변수[,매개변수,...])]
    IS SELECT 문;
    
 예) 부서번호를 입력받아 해당부서에 소속된 사원번호와 사원이름을 출력하는 커서를 정의하시오
 
 DECLARE
  CURSOR CUR_EMP01(P_DEPT_ID  DEPARTMENTS.DEPARTMENT_ID%TYPE)
  IS
   SELECT EMPLOYEE_ID, EMP_NAME
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 60;--P_DEPT_ID;     --여기까지가 커서

(2) OPEN 
 . 커서를 사용하기 전에 반드시(FOR문 제외) OPEN 해야함
 . OPEN명령은 실행부(BEGIN ~ END)에서 작성
 
 (사용형식)
 OPEN 커서명[(매개변수[,매개변수,...])];
 
 
 예)2005년 1월 분류코드별 매입수량과 매입금액합계를 구하는 커서
 DECLARE
  V_GU LPROD.LPROD_GU%TYPE;
  V_NAME LPROD.LPROD_NM%TYPE;
  V
  CURSOR CUR_BUY01
  IS
    SELECT LPROD_GU, LPROD_NM
      FROM LPROD;
 BEGIN
  OPEN CUR_BUY01;
  
  LOOP
    FETC