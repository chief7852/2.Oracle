2020-12-22-01)
** �ǽ� ���ڵ�
    1) :new
      - insert�� update���� ���
      - �����Ͱ� ����(����)�ɶ� ���� �Է��� ���� ��Ī��
      - delete �ÿ��� ��� �÷��� null���� ��

    2) :old
      - delete�� update���� ���
      - �����Ͱ� ����(����)�ɶ� ����Ǿ� �ִ� ��
      - insert �ÿ��� ��� �÷��� null���� ��

** Ʈ���� �Լ�
  - Ʈ���Ÿ� �˹߽�Ų event�� ������ �Ǵ��� �� ���
  1) inserting : Ʈ���ŵ� ������ insert�̸� true
  2) updating : Ʈ���ŵ� ������ update�̸� true
  3) deleting : Ʈ���ŵ� ������ delete�̸� true
  
  
��) ������ 2005�� 4�� 20���̶�� �����ϰ� ���Ի�ǰ 'P201000001'�� ���Լ����� 15������
    25���� �����Ͻÿ�
    ���� �� ������ ���̺��� �ڷᵵ ����� �� �ִ��� Ʈ���Ÿ� �ۼ��Ͻÿ�
    **REMAIN ���̺� 'P201000001'�ڷ��� ����
(������ ���� �Ǵ� ����)
DECLARE
  V_CNT NUMBER := 0; -- 2005�� 4�� 20�� 'P201000001' ��ǰ���� ���翩�� �Ǵ�
  V_QTY NUMBER := 10;
  
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM BUYPROD
     WHERE BUY_PROD = 'P201000001'
       AND BUY_DATE = TO_DATE('20050420');
       
  IF V_CNT = 1 THEN   --���������� UPDATE�ʿ�
     UPDATE BUYPROD
        SET BUY_QTY = BUY_QTY+V_QTY
      WHERE BUY_PROD = 'P201000001'
       AND BUY_DATE = TO_DATE('20050420');
  ELSE
        INSERT INTO BUYPROD
         VALUES('20050420','P201000001',V_QTY,21000);
  END IF;
END;


(Ʈ���� ����)
CREATE OR REPLACE TRIGGER TG_BUYPROD_UPDATE
  AFTER INSERT OR UPDATE OR DELETE ON BUYPROD
  FOR EACH ROW
 DECLARE
  V_QTY NUMBER:=0;          --��ǰ���Լ���
  V_PROD PROD.PROD_ID%TYPE; --��ǰ�ڵ�
 BEGIN
  IF INSERTING THEN
    V_QTY:=NVL(:NEW.BUY_QTY,0);
    V_PROD:=:NEW.BUY_PROD;

 ELSIF UPDATING THEN
    V_QUY :=: NEW.BUY_QTY -:OLD.BUY_QTY;
    V_PROD :=: NEW.BUY_PROD;
 ELSE 
    V_QTY := : OLD.BUY_QTY;
    V_PROD := : OLD.BUY_PROD;
 END IF;
 
 UPDATE REMAIN
    SET REMAIN_I = REMAIN_I+V_QTY,
        REMAIN_J_99 = REMAIN_J_99+V_QGT
  WHERE REMAIN_YEAR = '2005'
    AND REMAIN_PROD=V_PROD;
    
DBMS_OUTPUT.PUT_LINE('�߰� ���� ���� :' ||V_QTY);

EXCEPTION
   WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('���ܹ߻� : ' || SQLERRM);



END;













