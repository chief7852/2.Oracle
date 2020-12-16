2020-12-16-01)
2)반복문
 - 애플리케이션 개발언어의 반복문과 같은 기능 제공
 - loop while for문이 제공
 (1) loop문
 . 반복문 중 가장 기본적인 구조 제공
    (사용형식)
  LOOP
    반복처리문(들);
    EXIT [WHEN 조건];
        :
    END LOOP;
    - 'EXIT [WHEN 조건];' 조건이 '참'이면 LOOP문을 벗어나고, 거짓이면 다음 명령 수행
    
 예) 구구단의 5단을 출력하는 로직을 LOOP구문을 사용하여 작성하시오
 
 DECLARE
  V_BASE NUMBER := 5; -- 단을 보관하는 변수
  V_CNT NUMBER :=0;  -- 곱해지는 수(1~9) 보관
  V_RES NUMBER :=0;  -- 결과 보관  
BEGIN
 LOOP
  V_CNT:=V_CNT+1;
  EXIT WHEN V_CNT>9;
  V_RES:= V_BASE*V_CNT;
  DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_RES);
  END LOOP;
 END;
    
    
예) 부서번호를 입력받아 해당부서에 소속된 사원번호와 사원이름을 출력하는 커서를 정의하시오
ACCEPT P_ID PROMPT ' 부서번호 : '
DECLARE
    V_EMPID  EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_NAME   EMPLOYEES.EMP_NAME%TYPE;
    
  CURSOR CUR_EMP02(P_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE)
  IS
    SELECT EMPLOYEE_ID, EMP_NAME
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID = P_DEPT;
BEGIN
    OPEN CUR_EMP02('&P_ID');
    
    LOOP
      FETCH CUR_EMP02 INTO V_EMPID,V_NAME;
       EXIT WHEN CUR_EMP02%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE(V_EMPID||', '||V_NAME);
       DBMS_OUTPUT.PUT_LINE('----------------------------------');
   END LOOP;
      DBMS_OUTPUT.PUT_LINE('처리건수 :'  ||CUR_EMP02%ROWCOUNT);
    CLOSE CUR_EMP02;
END;
    
SET SERVEROUTPUT ON;    
    
    (2)WHILE 문
    . 개발언어의 WHILE과 같은 기능 제공
    (사용형식)
    WHILE 조건 LOOP
        반복처리 명령문(들);
           :
    END LOOP;
    . '조건' 이 참이면 반복수행, '조건'이 거짓이면 LOOP를 벗어남
    
    
    
예) 구구단의 5단을 WHILE을 이용하여 작성

DECLARE
    V_CNT NUMBER := 0;
BEGIN
    WHILE V_CNT <= 9 LOOP
      DBMS_OUTPUT.PUT_LINE('5*'||V_CNT||'='||5*V_CNT);
      V_CNT:=V_CNT+1;
    END LOOP;
END;


예)1~50사이에 존재하는 FIBONACCI NUMBER를 인쇄하시오
    FIBONACCI NUMBER : 1,1는 주어지고 그 이후 수는 전 두수의 합이 현재수
    
DECLARE
 VP_NUM NUMBER := 1; --전수
 VPP_NUM NUMBER := 1;  --전전수
 VCUR_NUM NUMBER := 0; --현재수
 V_RES VARCHAR2(100); --결과
 BEGIN
 V_RES := '1, 1,';
 WHILE VCUR_NUM <= 50 LOOP
    VCUR_NUM := VP_NUM+VPP_NUM ;
    V_RES := V_RES||VCUR_NUM||', ';
    VPP_NUM:= VP_NUM;
    VP_NUM:=VCUR_NUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('피보나치 수 :' ||V_RES);
END;
    
    
    
    
    DECLARE
 VP_NUM NUMBER := 1; --전수
 VPP_NUM NUMBER := 1;  --전전수
 VCUR_NUM NUMBER := 0; --현재수
 V_RES VARCHAR2(100); --결과
 BEGIN
 V_RES := '1, 1,';
 WHILE VCUR_NUM <= 50 LOOP
    VCUR_NUM := VP_NUM+VPP_NUM ;
    V_RES := V_RES||VCUR_NUM||', ';
    VPP_NUM:= VP_NUM;
    VP_NUM:=VCUR_NUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('피보나치 수 :' ||V_RES);
END;V

예) 회원테이블에서 거주지가 서울인 회원을 찾아 그 회원의 2005년 매출 정보를 조회하시오
DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_TOT NUMBER ;
    CURSOR CUR_CART01
    IS
        SELECT MEM_ID,MEM_NAME
          FROM MEMBER
          WHERE MEM_ADD12 LIKE '충남%';
BEGIN
  OPEN CUR_CART01;
  FETCH CUR_CART02 INTO V_ID,V_NAME;
  WHILE CUR_CART01%FOUND LOOP
  -- V_ID에 저장된 회원의 출액 계산)
  SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_TOT
    FROM FROM CART A, PROD B
    WHERE A.CART_PROD= B.PROD_ID
    AND A. CART_MEMBER= V_ID
    AND A. CANT_NO LIKE '2005%';
    
    DBMS_OUTPUT.PUT_LINE('회원번호 :'||V_ID);
    DBMS_OUTPUT.PUT_LINE('회원명 :'||V_NAME);
    DBMS_OUTPUT.PUT_LINE('구매금액 합계 :' ||V_TOT);
    DBMS_OUTPUT.PUT_LINE('----------------------------');
      FETCH CUR_CART01 INTO V_ID,V_NAME;
  END LOOP; 
END;          


 (3) FOR문
 . 제어변수 (INDEX)를 이용한 반복 수행
 . 제어변수(INDEX)는 시스템에서 자동설정(선언 불필요)
 (사용형식)
 FOR index IN [REVERSE] 초기값..최종값 LOOP
 반복처리 명령문(들)
 END LOOP;
 
 
 예)오늘의 요일을 구하는 프로그램을 작성
   1) 서기 1년 1월 1일부터 전년 (2019년) 12 31까지 경과된 일수
   2)올해 1월 1일부터 전월 마지막일 까지 일수
   3)금월 1일부터 오늘까지 일수
   ------------------------------------------------------
   1)2)3)의 합계를 8로 나눈 나머지 꼐산
   
   DECLARE--1) 서기 1년 1월 1일부터 전년 (2019년) 12 31까지 경과된 일수
   V_TOT NUMBER :=0;
   V_YEAR NUMBER :=EXTRACT(YEAR FROM SYSDATE);
   V_MONTH NUMBER :=EXTRACT(MONTH FROM SYSDATE);
    V_DATE NUMBER :=EXTRACT(DAY FROM SYSDATE);
BEGIN
 FOR Y IN 1..V_YEAR-1 LOOP
  IF (MOD(Y,4) = 0 AND MOD(Y,100)<>0) OF (MOD(Y,400)=0) THEN
        V_TOT:=V_TOT+366; --윤년
    ELSE
        V_TOT:=V_TOT+365;--평년
    END IF;
  END LOOP;
  
--       2)올해 1월 1일부터 전월 마지막일 까지 일수
    FOR M IN 1.. V_MONTH-1 LOOP
      IF M =1 OR M=3 OR M=5 OR M=7 OR M=8 OR M=10 OR M=12 THEN
        V_TOT:=V_TOT+31;
    ELSIF M=4 OR M=6 OR M=9 V OR M=11 THEN
        V_TOT:=V_TOT+30;
    ELSE 
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)<> 0) OR (MOD(V_YEAR,400)=0) THEN
        V_TOT:=V_TOT+29
    ELSE
        V_TOT:=V_TOT+28
        END IF;
     END LOOP; 
     3)
    V_TOT:=V_TOT+DATE;
    CASE MOD(V_TOT,7) WHEN 1 THEN V_MT
  END;
  
  
  
  
  
  
  **커서와 사용되는 FOR문
  (1) 사용형식
  FOR 레콛명 IN 커서명[(매개변수),...] lOOP
      반복처리문;
      END LOOP;
      . '레코드명'은 시스템이 자동으로 할당함
      . 커서내의 컬럼 접근은 ' 레코드명.컬렴명' 형식으로 접근
      . OPEN,FETCH, CLOSE 문이 불필요함.
      
 