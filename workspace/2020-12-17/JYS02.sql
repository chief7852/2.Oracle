2020-12-17-01) ���� ���ν���(Stored Procedure : Procedure)

 - Ư�� ����� �����Ͽ� �ϳ��� ����� �����ϱ� ���� ����� ����
 - �̸� �����ϵǾ� ������ ����
 - ����ڴ� ���డ���� ���ν����� ȣ��(��Ʈ��ũ�� Ʈ���� ����, ����ȿ�� ����, ����Ȯ��)
 - ��ȯ���� ����      --���ν����̸����� ����ϸ� �ȶ� �Ű������θ� ����
 (�������)
  CREATE [OR REPLACE] PROCEDURE ���ν�����[(                     //����:OR REPLACE�� �����Ѵٴ°ǰ���? ALTER�� �ٸ��� ����
    �Ű����� [IN|OUT|INOUT] Ÿ�Ը� [:=|DEFAULT ��],                 --INOUT�� �����������, �ٻ����ϸ� IN�� �ȴ�.
            :
    �Ű����� [IN|OUT|INOUT] Ÿ�Ը� [:=|DEFAULT ��]                  --Ÿ�Ը� ����ؾ��Ѵ� ������� VARCHAR2()    ��ȣ�ȿ� ũ�⸦ �����ϸ� �������.
    IS|AS
        �����;
    BEGIN
        �����
        [EXCEPTION
            ����ó����;
        ]
    END;

(���๮ �������)
 EXEC|EXECUTE ���ν�����(�Ű�����,...); --�ܵ�����
 
 �͸����̳� �ٸ� �Լ� ����� 
 ���ν�����(�Ű�����,...);
 
 
 **���������̺��� �����Ͻÿ�
  ���̺�� : REMAIN
  �÷���         ������Ÿ��          NULLABLE     PK/FK����   DEFAULT VALUE
  -----------------------------------------------------------------------
  REMAIN_YEAR   CHAR(4)            N.N          PK
  REMAIN_PROD   VARCHAR2(10)       N.N          PK/FK
  REMAIN_J_00   NUMVER(5)                                     0
  REMAIN_I      NUMVER(5)                                     0
  REMAIN_O      NUMVER(5)                                     0
  REMAIN_J_99   NUMVER(5)                                     0
  REMAIN_       DATE                                                        --�����Ǿ��� ��¥

--������ ���̺�� ������ֱ�
CREATE TABLE REMAIN(
  REMAIN_YEAR   CHAR(4),
  REMAIN_PROD   VARCHAR2(10),
  REMAIN_J_00   NUMBER(5) DEFAULT 0,                                     
  REMAIN_I      NUMBER(5) DEFAULT 0,                                       
  REMAIN_O      NUMBER(5) DEFAULT 0,                                       
  REMAIN_J_99   NUMBER(5) DEFAULT 0,                                       
  REMAIN_DATE       DATE,
  
  CONSTRAINT pk_remain PRIMARY KEY (REMAIN_YEAR,REMAIN_PROD),
  CONSTRAINT fk_remain_reod FOREIGN KEY(REMAIN_PROD)
    REFERENCES PROD(PROD_ID));


** PROD ���̺��� ��ǰ��ȭ�� �������(PROD_PROPERSTOCK)�� REMAIN���̺��� REMAIN_PROD��
   REMAIN_J_00(�������)�� �����Ͻÿ�. �� REMAIN_YEAR�� '2005'�̰� ��¥��
   '2005/01/01'�̴�
   
   --INSERT���� ���������� �����ϰ� ��ȣ�� �ȵ���.
   INSERT INTO REMAIN(REMAIN_YEAR,REMAIN_PROD,REMAIN_J_00,REMAIN_J_99,REMAIN_)
   SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20050101')
   FROM PROD;

SELECT * FROM REMAIN;


��) 2005�� 1�� ��� ��ǰ�� ���Լ����� ��ȸ�ϰ� ���������̺��� UPDATE�Ͻÿ�
    PROCEDURE ���    (��� ��ǰ�� ���Լ���) (���ν��� ���)
    --��ȸ
SELECT PROD_ID,NVL(SUM(BUY_QTY),0)
FROM PROD
LEFT OUTER JOIN BUYPROD ON (PROD_ID=BUY_PROD
 AND BUY_DATE BETWEEN '20050101' AND '20050131')
 GROUP BY PROD_ID
 ORDER BY PROD_ID;
 
    -- PROCEDURE���
CREATE OR REPLACE PROCEDURE PROC_BUYPROD01(         --���ν����� PROC_�� �����ϴ°� ���ǰ����� ������
  P_ID IN PROD.PROD_ID%TYPE,
  P_QTY IN NUMBER)
 IS
BEGIN
  UPDATE REMAIN
    SET REMAIN_I = REMAIN_I + P_QTY,
        REMAIN_J_99 = REMAIN_J_99 + P_QTY,
        REMAIN_DATE = TO_DATE('20050131')
  WHERE REMAIN_PROD = P_ID
    AND REMAIN_YEAR = '2005';               --�⺻Ű�� ����Ű�ΰ�쿡�� �ΰ����� �⺻Ű�� �� �־�����Ѵ� �ƴϸ� �ڷᰡ �����̵ɼ� �ִ�.

END;

(����)
declare 
    cursor cur_buyprod01
    is
    SELECT PROD_ID,NVL(SUM(BUY_QTY),0) AS AMT
    FROM PROD
    LEFT OUTER JOIN BUYPROD ON (PROD_ID=BUY_PROD
     AND BUY_DATE BETWEEN '20050101' AND '20050131')
     GROUP BY PROD_ID
     ORDER BY PROD_ID;

BEGIN
    FOR REC_BUYPROD IN cur_buyprod01 LOOP
     PROC_BUYPROD01(REC_BUYPROD.PROD_ID, REC_BUYPROD.AMT);
    END LOOP;
    
END;

SELECT *FROM REMAIN;

��)�Ѹ��� ȸ�� ID�� �Է¹޾� ȸ���� �̸��� �ּ�, ���ϸ����� ����ϴ� PROCEDURE�� �ۼ��Ͻÿ�
--1��° ��� ���ν��� �ȿ��� 
CREATE OR REPLACE PROCEDURE PROC_MEM01(
 P_ID MEMBER.MEM_ID%TYPE)
IS
 V_NAME MEMBER.MEM_NAME%TYPE;
 V_ADDR VARCHAR2(100);
 V_MILE MEMBER.MEM_MILEAGE%TYPE;
BEGIN
  SELECT MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_MILEAGE INTO V_NAME,V_ADDR,V_MILE
    FROM MEMBER
   WHERE MEM_ID=P_ID;

    DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);    
    
END;


--����
EXECUTE PROC_MEM01('d001');

SELECT * FROM MEMBER;
SET SERVEROUTPUT ON;

--2��° ��� �Ű������� �����
CREATE OR REPLACE PROCEDURE PROC_MEM01(
 P_ID IN MEMBER.MEM_ID%TYPE,
 P_NAME OUT MEMBER.MEM_NAME%TYPE,
 P_ADDR OUT VARCHAR2,
 P_MILE OUT MEMBER.MEM_MILEAGE%TYPE)
IS
BEGIN
  SELECT MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_MILEAGE INTO P_NAME,P_ADDR,P_MILE
    FROM MEMBER
   WHERE MEM_ID=P_ID;

END;




--����
DECLARE
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
BEGIN
    PROC_MEM01('b001',V_NAME,V_ADDR,V_MILE);
    
    DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);    
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);   
END;                                                          --��� �͸����̶� EXEC,EXCUTE ����
    
 --���� : �������� �泲�� ȸ���� ���� ���ν��� ����   
 
 DECLARE
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_MILE MEMBER.MEM_MILEAGE%TYPE;
    
    CURSOR CUR_MEM02
    IS
      SELECT MEM_ID FROM MEMBER
       WHERE MEM_ADD1 LIKE '�泲%';
BEGIN
    FOR RMEM IN CUR_MEM02 LOOP
    PROC_MEM01(RMEM.MEM_ID,V_NAME,V_ADDR,V_MILE);
    
    DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);    
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);   
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  END LOOP;
END;                  

����] ��ǰ�ڵ�� ���� �Է¹޾� �ش��ǰ�� �԰������ �������� ��ȸ�Ͽ� ����ϴ� ���ν����� 
      �ۼ��Ͻÿ�(PROCEDURE �̸� : PROC_CB_INFO)
CREATE OR REPLACE PROCEDURE PROC_CN_INFO(
 P_CODE IN PROD.PROD_ID%TYPE,
 P_MONTH IN CHAR,
 P_OAMT OUT NUMBER,
 P_IAMT OUT NUMBER)
 IS
 V_DATE DATE:=TO_DATE('2005'||P_MONTH||'01');
BEGIN
 SELECT SUM(BUY_QTY) INTO P_IAMT
   FROM BUYPROD
  WHERE BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
    AND BUY_PROD= P_CODE;
    
    SELECT SUM(CART_QTY) INTO P_OAMT
   FROM CART
  WHERE SUBSTR(CART_NO,1,6)=SUBSTR(REPLACE(TO_CHAR(V_DATE),'/'),1,6)
    AND CART_PROD= P_CODE;
     
END;


 DECLARE
    V_IAMT NUMBER := 0;
    V_OAMT NUMBER := 0;
    V_NAME PROD.PROD_NAME%TYPE;
BEGIN
 SELECT PROD_NAME INTO V_NAME
   FROM PROD
   WHERE PROD_ID='P101000006';
   
 PROC_CN_INFO('P101000006','04',V_OAMT,V_IAMT);
 
  DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : P101000006');
  DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_NAME);
  DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||V_OAMT);
  DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||V_IAMT);
END;
    
    
    
    
    
 
 EXECUTE PROC_CN_INFO('p101000001','04') ;
 SELECT SUBSTR(PROD_INSDATE,6 ,2)
 FROM PROD;
 
 
 
 
 
 
 