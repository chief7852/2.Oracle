2020-12-21-02)트리거(trigger)
  - 어떤 이벤트가 발생되면 그 이벤트르로 인하여 다른 테이블의 값이 자동으로
    변경(삽입/update,삭제)되도록 구성된 프로시져
    (사용형식)
  create trigger 트리거명
     [before|after] [insert|update|delete]           --after자주씀
    on 테이블명
    [for each row]
    [when 조건]
  begin
     트리거 처리문;
     end;
 . 'before|after' :트리거의 timming, 생략하면 after로 간주
                   트리거 수행(트리거 처리문) 이 이벤트 발생 전이면 before,
                   이벤트 발생 후이면 after를 기술
 . 'insert|update|delete' : 트리거 이벤트, 트리거를 발생시키는 원인으로
                            or 연산자를 이용하여 복수개 정의가능(ex insert or delete)
 . 'for each row' : 행단위 트리거 발생시 기술, 생략하면 문장단위 트리거
 . 'when 조건' : 행단위 트리거에서만 사용하며 트리거 이벤트에서 정의된 테이블에 이벤트가
                발생할 때 보다 구체적인 데이터 검색 조건 부여시 사용
** 행단위와 문장단위 트리거
  (1) 문장단위 트리거 :이벤트 발생시 오직 한번만 트리거 발생(많이 사용하지 않음)
  (2) 행단위 투리거 : 'for each row' 기술
                     이벤트 결과 각 행마다 트리거 수행,
                     의사레코드(pesudo record)인 :new, :old 사용가능
                     대부분의 트리거가 속함
                     단, 한 트리거 수행이 완료되지 않은 상태에서 또다른 트리거를 호출할
                     경우 시스템에 의해 트리거 강제종료
    
예) 분류테이블에 새로운 자료를 입력하고    입력이 정상적으로 처리되었으면
    '신규 분류자가 정상 입력되었습니다.!!' 메세지를 출력하는 트리거를 작성하시오
    [자료]
    분류코드 : p502
    순번  :12
    분류명 :농산물
    
    create trigger tg_lprod()1
    after insert on lprod
begin
    dbms_iutput.put_line('신규 분류자료가 정상 입력되었습니다.!!');
END;


INSERT INTO LPROD
   VALUES(12,'P502','농산물');
SELECT * FROM LPROD;
    
    
    
예) 입고테이블(BUYPROD)에서 2월과 3월 입고된 상품별 매입수량을 조회하여 재고수불테이블을
    수집하시오
  SELECT BUY_PROD,
         SUM(BUY_QTY) 
   FROM BUYPROD
   WHERE BUY_DATE BETWEEN '20050201' AND '20050331'
   GROUP BY BUY_PROD
   ORDER BY 1;
    
    
 UPDATE REMAIN A 
 SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE) = 
        (SELECT A.REMAIN_I +B.IAMT,A.REMAIN_J_99+B.IAMT,TO_DATE('20050331')
        FROM (SELECT BUY_PROD AS BID,
                SUM(BUY_QTY) AS IAMT
               FROM BUYPROD
              WHERE BUY_DATE BETWEEN '20050201'AND '20050331'
              GROUP BY BUY_PROD) B
              WHERE A.REMAIN_PROD=B.BID)
    WHERE A.REMAIN_YEAR = '2005'
    AND A.REMAIN_PROD IN (SELECT DISTINCT BUY_PROD
                            FROM BUYPROD
                            WHERE BUY_DATE BETWEEN '20050201 ' AND '20050331');
    
    ROLLBACK;
    
    SELECT * FROM REMAIN;


예) 오늘이 2005년 4월 1일이라고 가정하고 다음자료를 장바구니 테이블에 입력하시오
    장바구니테이블에 입력된 후 재고수불 테이블을 수정하시오

  입력자료 : (29,21,0,50,2005-01-31 : REMAIN테이블의 자료)
   구매회원 : C001
   구매상품 : P302000014
   구매수량 : 5
   -------------------------------------
   (트리거)
   CREATE OR REPLACE TRIGGER TG_CART_INSERT
    AFTER INSERT ON CART
    FOR EACH ROW
  BEGIN
  UPDATE REMAIN
    SET REMAIN_O=REMAIN_O+:NEW.CART_QTY,
        REMAIN_J_99=REMAIN_J_99-:NEW.CART_QTY),
         REMAIN_DATE = '20050401'    
  WHERE REMAIM_PROD =: NEW.CART_PROD 
    AND REMAIN_YEAR ='2005';
    END;
    
    실행 : CART 테이블에 자료가 삽입된 후)
 INSERT INTO CART 
    SELECT 'C001',MAX(CART_NO)+1, 'P302000014',5
      FROM CART
    WHERE SUBSTR(CART_NO,1,8) ='20050401';
    
    
    SELECT * FROM REMAIN;
    SELECT * FROM CART;
    
    
    
    
    
    
    
    
    
    
                                               
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    