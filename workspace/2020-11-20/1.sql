2020-11-20-01) 연산자와 함수
SELECT 문                                    --SELECT절 FROM절(사용할 테이블) WHERE절(조건 출력할 행을조절)로 이루워져있음
 - 데이터를 조회하는 명령                         
 - SQL 명령 중 가장 많이 사용되는 명령
 
 (사용형식)     -- 실행순서 FROM => WHERE => SELECT 순으로 컴퓨터에서 실행한다.
 SELECT [DISTINCT]|*|컬럼명 [AS]["]컬럼별칭["],                --DISTINCT : 중복된걸 배제시킨다.        |*|테이블 전부를 조회하라
        컬럼명 [AS]["]컬럼별칭["],
                :
        컬럼명 [AS]["]컬럼별칭["],
    FROM 테이블명                   --테이블 명이 2개이상이면 JOIN이됨
 [WHERE 조건]         
 [GROUP BY 컬럼명[,컬럼명,...]]
[HAVING 조건]
 [ORDER BY 컬럼명|컬럼인덱스[ASC|DESC][.컬럼명|컬럼인덱스[ASC|DESC],...];       --ORDER BY = 정렬         --ASC오름차순 | DESC내림차순 선택
 
 '[DISTINCT]' : 중복된 자료를 배제할 때 사용
 '컬럼별칭' : 컬럼에 부여된 또 다른 이름
  - 컬럼명 AS 별칭
  -컬럼명 별칭
  -컬럼명 "별칭" : 별칭에 특수문자(공백포함)가 포함된 경우 반드시 " "로 묶어 사용
  -'컬럼인덱스' : SELECT 절에서 기술된 해당 컬럼의 순번(1부터 COUNTING)
  -'ASC|DESC' : 정렬방법(ASC:오름차순으로 기본값,DESC는 오름차순)
  - SELECT문의 실행 순서 : FROM 절 -> WHERE 절 이하 ->SELECT 절
 
 예) 회원 테이블에서 회원번호와 회원명을 조회하시오
 SELECT MEM_ID,MEM_NAME
    FROM MEMBER;
    
SELECT MEM_ID AS "회원번호",                                -- "" 형변환, 컬럼별칭에 사용 (특히, 공백이나 오라클특수문자 사용할때)
MEM_NAME AS "회원이름"
    FROM MEMBER; 
    
SELECT *                            -- 모든 행과 모든절을 출력하십시오 라는뜻
    FROM LPROD;                     --
 
 
 1. 연산자
  - 산술연산자(+,-,*,/)          --% 나머지연산자는 없다.
  - 관계연산자(<,>,>=,<=,=,!=(<>))
  - 논리연산자(AND, OR, NOT)
  
 2. 함수(FUNCTION)    --자바에서 메소드같은것
  - 특정 기능을 수행하여 하나의 결과를 반환하도록 설계된 모듈
  - 컴파일 되어 실행 가능한 상태로 제공
  - 문자열, 숫자, 변환, 집계함수의 형태로 제공
 
    1)문자열 함수
    - 문자열 조작한 결과를 반환
** 문자열 연산자 '||'
   자바의 문자열 연산자 '+'와 같이 두 문자열을 결합하여 하나의
   문자열을 반환
   
예)
SELECT 'Oracle' || ', ' || 'Modeling' FROM DUAL;

예)회원테이블에서 회원번호, 회원명, 주민번호를 조회하시오
  단, 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력하시오

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호
    FROM MEMBER;
    
    
예) 회원테이블에서 여성회원들의 정보를 조회하시오.
    Alias는 회원번호,회원명,주소,마일리지
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_ADD1||' '||MEM_ADD2 AS 주소,
       MEM_MILEAGE AS 마일리지
       
FROM MEMBER
 WHERE SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4'
 ORDER BY 4 DESC
 
 1)CONCAT
  - 주어진 두 개의 문자열을 결합하여 하나의 문자열을 반환
  - '||'연산자와 같은 기능
  (사용형식)
  CONCAT(c1,c2)
    .c1과 c2를 결합하여 결과를 반환
    
예)회원테이블에서 회원번호, 회원명, 주민번호를 조회하시오
  단, 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력하되 CONCAT 함수 사용
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       CONCAT (CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS 주민번호
    FROM MEMBER;
    
    
 2)INITCAP
 - 단어의 선두문자만 대문자로 출력
 - 보통 이름 출력시 사용
 
 (사용형태)
 ININCAP(c1)
 . c1에 포함된 단어의 첫 글자를 대문자로 변환
 
 
 예)
 UPDATE EMPLOYEES
    SET EMP_NAME=LOWER(EMP_NAME);
 
 SELECT EMP_NAME FROM EMPLOYEES;                    -- 이름을 소문자로 바꿈
 
 SELECT INITCAP(EMP_NAME) FROM EMPLOYEES;           -- 다시 단어의 시작글자들을 대문자로 바꿈

 
 ROLLBACK;
 COMMIT;