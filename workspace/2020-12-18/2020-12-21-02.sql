2020-12-21-02)Ʈ����(trigger)
  - � �̺�Ʈ�� �߻��Ǹ� �� �̺�Ʈ���� ���Ͽ� �ٸ� ���̺��� ���� �ڵ�����
    ����(����/update,����)�ǵ��� ������ ���ν���
    (�������)
  create trigger Ʈ���Ÿ�
     [before|after] [insert|update|delete]           --after���־�
    on ���̺���
    [for each row]
    [when ����]
  begin
     Ʈ���� ó����;
     end;
 . 'before|after' :Ʈ������ timming, �����ϸ� after�� ����
                   Ʈ���� ����(Ʈ���� ó����) �� �̺�Ʈ �߻� ���̸� before,
                   �̺�Ʈ �߻� ���̸� after�� ���
 . 'insert|update|delete' : Ʈ���� �̺�Ʈ, Ʈ���Ÿ� �߻���Ű�� ��������
                            or �����ڸ� �̿��Ͽ� ������ ���ǰ���(ex insert or delete)
 . 'for each row' : ����� Ʈ���� �߻��� ���, �����ϸ� ������� Ʈ����
 . 'when ����' : ����� Ʈ���ſ����� ����ϸ� Ʈ���� �̺�Ʈ���� ���ǵ� ���̺��� �̺�Ʈ��
                �߻��� �� ���� ��ü���� ������ �˻� ���� �ο��� ���
** ������� ������� Ʈ����
  (1) ������� Ʈ���� :�̺�Ʈ �߻��� ���� �ѹ��� Ʈ���� �߻�(���� ������� ����)
  (2) ����� ������ : 'for each row' ���
                     �̺�Ʈ ��� �� �ึ�� Ʈ���� ����,
                     �ǻ緹�ڵ�(pesudo record)�� :new, :old ��밡��
                     ��κ��� Ʈ���Ű� ����
                     ��, �� Ʈ���� ������ �Ϸ���� ���� ���¿��� �Ǵٸ� Ʈ���Ÿ� ȣ����
                     ��� �ý��ۿ� ���� Ʈ���� ��������
    
��) �з����̺��� ���ο� �ڷḦ �Է��ϰ�    �Է��� ���������� ó���Ǿ�����
    '�ű� �з��ڰ� ���� �ԷµǾ����ϴ�.!!' �޼����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
    [�ڷ�]
    �з��ڵ� : p502
    ����  :12
    �з��� :��깰
    
    create trigger tg_lprod()1
    after insert on lprod
begin
    dbms_iutput.put_line('�ű� �з��ڷᰡ ���� �ԷµǾ����ϴ�.!!');
END;


INSERT INTO LPROD
   VALUES(12,'P502','��깰');
SELECT * FROM LPROD;
    
    
    
��) �԰����̺�(BUYPROD)���� 2���� 3�� �԰��� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ����������̺���
    �����Ͻÿ�
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


��) ������ 2005�� 4�� 1���̶�� �����ϰ� �����ڷḦ ��ٱ��� ���̺��� �Է��Ͻÿ�
    ��ٱ������̺��� �Էµ� �� ������� ���̺��� �����Ͻÿ�

  �Է��ڷ� : (29,21,0,50,2005-01-31 : REMAIN���̺��� �ڷ�)
   ����ȸ�� : C001
   ���Ż�ǰ : P302000014
   ���ż��� : 5
   -------------------------------------
   (Ʈ����)
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
    
    ���� : CART ���̺��� �ڷᰡ ���Ե� ��)
 INSERT INTO CART 
    SELECT 'C001',MAX(CART_NO)+1, 'P302000014',5
      FROM CART
    WHERE SUBSTR(CART_NO,1,8) ='20050401';
    
    
    SELECT * FROM REMAIN;
    SELECT * FROM CART;
    
    
    
    
    
    
    
    
    
    
                                               
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    