2020-12-15-01)제어문
    - 프로그램의 진행 순서를 변경
    - IF문이 제공
    1) IF 문
    . 애플리케이션 언어의 IF문과 같은 기능
      (사용형식)
    IF 조건식1 THEN
      명령1
    [ELSE
      명령2;]
      END IF;
      
      1-2)
      (사용형식)

    IF 조건식1 THEN
      명령1
    [ELSIF 조건식2 THEN
      명령2;
      ELSE
      명령3;]
      
      END IF;
      
      
      1-3)
      (사용형식)
    IF 조건식1 THEN
      명령1
      IF 조건식2 THEN
      명령2;
      ELSE
      명령3;
      END IF;
    ELSE
    명령어4
      
      END IF;
      
      
예) 키보드로 년도를 입력 받아 윤년인지 평년인지 판별하는 프로그램작성

ACCEPT P_YEAR PROMPT '년도 입력 :';

DECLARE
    V_YEAR NUMBER := 0; --입력받은 년도를 보관할 변수       -- 초기화시켜야함        -- 입력받은 문자를 숫자로 바꿔줌--'&'의 역할은 값을 지정해서 오라클이 알수있게해줌
    V_MESSAGE VARCHAR2(30); --결과를 저장

BEGIN
    V_YEAR := TO_NUMBER('&P_YEAR');              -- 입력받은 문자를 숫자로 바꿔줌
   --윤년(4의 배수이면서 100의 배수가 아니거나, 400의 배수가 되는 년도)인지 평년인지 판별
    IF(MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)<>0) OR (MOD(V_YEAR,400)=0) THEN
    V_MESSAGE := V_YEAR||'는 윤년입니다.';
    ELSE
    V_MESSAGE := V_YEAR||'는 윤년입니다.';
    END IF;
    
    
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;
/       
    
set serveroutput on;
    
    
 예) 임의의 정수를 (1~100) 입력하여 짝수인지 홀수인지 판단
 --난수발생
 DECLARE
    V_NUM NUMBER:=0;
    V_RES VARCHAR2(500);
 BEGIN
    V_NUM := ROUND(DBMS_RANDOM.VALUE(1,100));
    IF MOD(V_NUM,2)= 0 THEN
        V_RES:=V_NUM||'은 짝수';
    ELSE
        V_RES:=V_NUM||'은 짝수';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_RES);
    
END;


(익명블록 사용)
예) LPROD 테이블에 다음 데이터를 입력하시오
    분류코드 : P501
    분류명   : '축산가공식품'
    
DECLARE
    V_CNT NUMBER := 0;   --SELECT문의 결과(VIEW)의 행의 수
BEGIN
SELECT COUNT (*) INTO V_CNT           
FROM LPROD
WHERE LPROD_GU ='P501';

    IF V_CNT = 0 THEN
      INSERT INTO LPROD                             -- INSERT문은 지금 서브쿼리이지만 원래부터 ()묶지않는다.
        SELECT MAX(LPROD_ID)+1,'P501','축산가공식품'
          FROM LPROD;
     END IF;
     COMMIT;
     EXCEPTION WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;


SELECT *
FROM LPROD;
    
    
문제] 위 예제에서 'P501'분류코드에 분류명이 '임산물'로 입력하시오
     단, 자료가 존재하면 갱신하시오
DECLARE
    V_CNT NUMBER := 0;
    V_LPROD_NM LPROD.LPROD_NM%TYPE:='임산물';
BEGIN
SELECT COUNT(*) INTO V_CNT
FROM LPROD
WHERE LPROD_GU = 'P501';

    IF V_CNT = 0 THEN
      INSERT INTO LPROD
        SELECT MAX(LPROD_ID)+1,'P501',V_LPROD_NM
          FROM LPROD;
    ELSE
        UPDATE LPROD  
            SET LPROD_NM = V_LPROD_NM
            WHERE UPPER(LPROD_GU) = 'P501';
             
    END IF;
     EXCEPTION WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;
    
    
    SELECT *
    FROM LPROD;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    