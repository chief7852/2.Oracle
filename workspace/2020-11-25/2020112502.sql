2020-11-25-02)
 4. MOD(n,c), REMAINDER(n,c)
  - n을 c로 나눈 나머지
  - 내부에서 서로 다른 함수를 사용하여 구함
  MOD : n - c * FLOOR(n/c)
  REMAINDER : n - c * ROUND(n/c)
    ** FLOOR(n) : n과 같거나 작은쪽에서 제일 큰 정수(n을 초과하지 않는 최대 정수)
    
    SELECT MOD(10,3),REMAINDER(10,3) FROM DUAL;
    SELECT MOD(11,3),REMAINDER(11,3) FROM DUAL;
 MOD(11,3)  : 11 -  3*FLOOR(11/3)  
              11 -  3*FLOOR(3.666666)
              11 -  3*3=> 11-9=>2
              
              
 REMAINDER(11,3) :11 -  3*ROUND(11/3) 
                  11 -  3*ROUND(3.66666)
                  11 -  3*4 => 11-12 =>-1
                  
                  
                  
                  
 5. FLOOR(n), CELL(n)
   - FLOOR : n을 초과하지 않는 최대 정수
   - CEIL  : n과 같거나 n보다 큰 제일 작은 정수
            . 소숫점이 허용되지 않는 컬럼에 정수 데이터가 입력된 경우 소숫점을
                무조건 반올림 하여 정수자료만 저장하는 경우 주로 사용(급여,세금 등의 계산 항목에 주로사용)
                
예)
 SELECT FLOOR(-10) ,FLOOR(-10.234) ,CEIL(-10) ,CEIL(-10.001) FROM DUAL;
 SELECT FLOOR(10) ,FLOOR(10.234) ,CEIL(10) ,CEIL(10.001) FROM DUAL;     
 
 
 
 
 
 
 6. WIDTH_BUCKET(n,min,max,b)
  - min과 max 사이을 b개의 구간으로 나누었을 경우 주어진 수 n이 어느 구간에 속하는지를 반환
  
예) 회원테이블에서 회원들의 보유한 마일리지를 1~ 10000사이를 10개의 구간으로 나누고 
    각 회원이 속한 구간 값을 조회하시오
SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_MILEAGE AS 마일리지,
        WIDTH_BUCKET(MEM_MILEAGE, 1,10000,10) AS 구간값      -- 등급을 매기고싶으면 (MEM_MILEAGE, 1,10000,10) > (MEM_MILEAGE, 10000,1,10)
    FROM MEMBER;
    
    
예) 급여 2000~30000 사이의 값을 3개의 구간으로 나눌때 각 사원의 급여가 속한 구간값을 구하고 
    그 값이 1인 경우 '낮은 급여', 2인 경우 '중간 급여', 3인경우 '고 임금' 이라는 메시지를
    비고 란에 출력하시오
    Alias는 사원번호,사원명,부서코드,급여,구간값,비고

SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        SALARY AS 급여,
        WIDTH_BUCKET(SALARY,2000,30000,3) AS 구간값,
        CASE WHEN WIDTH_BUCKET(SALARY,2000,30000,3)=1 THEN
                  '낮은급여'
             WHEN WIDTH_BUCKET(SALARY,2000,30000,3)=2 THEN
                  '중간급여'
             WHEN WIDTH_BUCKET(SALARY,2000,30000,3)=3 THEN
                  '고 임금'
                   ELSE
                    '오류' END AS  비고
       
FROM EMPLOYEES;