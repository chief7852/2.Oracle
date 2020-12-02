2020-12-02-02) JOIN
3. SELF JOIN
  - 하나의 테이블을 테이블 별칭을 이용하여 2개의 테이블처럼
    자신의 테이블을 자신의 테이블과 JOIN하는 방식
    
 예)회원테이블에서 회원번호 'T001' 회원이 보유한 마일리지보다 많은
    마일리지를 보유한 회원을 조회하시오.
   Alias 회원번호,회원명,마일리지
   
  SELECT B.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         B.MEM_MILEAGE AS 마일리지
    FROM MEMBER A, MEMBER B         --A : 'r001" 회원, B: 전체회원
   WHERE UPPER(A.MEM_ID)='T001'
     AND A.MEM_MILEAGE <= B.MEM_MILEAGE
     ORDER BY 3 DESC;
     
 (SUB QUERY);
  SELECT A.MEM_ID AS 회원번호,
         A.MEM_NAME AS 회원명,
         A.MEM_MILEAGE AS 마일리지,
         B.MILE AS "T001 회원의 마일리지"
    FROM MEMBER A, (SELECT MEM_MILEAGE AS MILE
                      FROM MEMBER
                     WHERE UPPER(MEM_ID)='T001') B
     WHERE A.MEM_MILEAGE > B.MILE
     ORDER BY 3 DESC;
     (또다른방식)
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지
    FROM MEMBER   
   WHERE MEM_MILEAGE > (SELECT MEM_MILEAGE 
                         FROM MEMBER
                     WHERE UPPER(MEM_ID)='T001')
     ORDER BY 3 DESC;
     
예)'마르죠' 거래처와 같은 지역에 주소지를 두고있는 거래처를 조회하시오
    Alias는 거래처코드,거래처명,주소,담당자
  SELECT B.BUYER_ID AS 거래처코드,
         B.BUYER_NAME AS 거래처명,
         B.BUYER_ADD1||' '||B.BUYER_ADD2 AS 주소,
         B.BUYER_CHARGER AS 담당자
    FROM BUYER A, BUYER B
   WHERE A.BUYER_NAME = '마르죠'
     AND SUBSTR(A.BUYER_ADD1,1,2)=SUBSTR(B.BUYER_ADD1,1,2);
     
     
     
     
예)장바구니테이블에서 't001'회원에게 판매한 2005년월별 판매현황을
   조회하시오
   Alias는 회원명,주민번호,월,구매액합계
   SELECT 
    
    
    
    
    
    
    
    
    
    