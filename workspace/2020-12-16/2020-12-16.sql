2020-12-16-01)
2)�ݺ���
 - ���ø����̼� ���߾���� �ݺ����� ���� ��� ����
 - loop while for���� ����
 (1) loop��
 . �ݺ��� �� ���� �⺻���� ���� ����
    (�������)
  LOOP
    �ݺ�ó����(��);
    EXIT [WHEN ����];
        :
    END LOOP;
    - 'EXIT [WHEN ����];' ������ '��'�̸� LOOP���� �����, �����̸� ���� ���� ����
    
 ��) �������� 5���� ����ϴ� ������ LOOP������ ����Ͽ� �ۼ��Ͻÿ�
 
 DECLARE
  V_BASE NUMBER := 5; -- ���� �����ϴ� ����
  V_CNT NUMBER :=0;  -- �������� ��(1~9) ����
  V_RES NUMBER :=0;  -- ��� ����  
BEGIN
 LOOP
  V_CNT:=V_CNT+1;
  EXIT WHEN V_CNT>9;
  V_RES:= V_BASE*V_CNT;
  DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_RES);
  END LOOP;
 END;
    
    
��) �μ���ȣ�� �Է¹޾� �ش�μ��� �Ҽӵ� �����ȣ�� ����̸��� ����ϴ� Ŀ���� �����Ͻÿ�
ACCEPT P_ID PROMPT ' �μ���ȣ : '
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
      DBMS_OUTPUT.PUT_LINE('ó���Ǽ� :'  ||CUR_EMP02%ROWCOUNT);
    CLOSE CUR_EMP02;
END;
    
SET SERVEROUTPUT ON;    
    
    (2)WHILE ��
    . ���߾���� WHILE�� ���� ��� ����
    (�������)
    WHILE ���� LOOP
        �ݺ�ó�� ���ɹ�(��);
           :
    END LOOP;
    . '����' �� ���̸� �ݺ�����, '����'�� �����̸� LOOP�� ���
    
    
    
��) �������� 5���� WHILE�� �̿��Ͽ� �ۼ�

DECLARE
    V_CNT NUMBER := 0;
BEGIN
    WHILE V_CNT <= 9 LOOP
      DBMS_OUTPUT.PUT_LINE('5*'||V_CNT||'='||5*V_CNT);
      V_CNT:=V_CNT+1;
    END LOOP;
END;


��)1~50���̿� �����ϴ� FIBONACCI NUMBER�� �μ��Ͻÿ�
    FIBONACCI NUMBER : 1,1�� �־����� �� ���� ���� �� �μ��� ���� �����
    
DECLARE
 VP_NUM NUMBER := 1; --����
 VPP_NUM NUMBER := 1;  --������
 VCUR_NUM NUMBER := 0; --�����
 V_RES VARCHAR2(100); --���
 BEGIN
 V_RES := '1, 1,';
 WHILE VCUR_NUM <= 50 LOOP
    VCUR_NUM := VP_NUM+VPP_NUM ;
    V_RES := V_RES||VCUR_NUM||', ';
    VPP_NUM:= VP_NUM;
    VP_NUM:=VCUR_NUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('�Ǻ���ġ �� :' ||V_RES);
END;
    
    
    
    
    DECLARE
 VP_NUM NUMBER := 1; --����
 VPP_NUM NUMBER := 1;  --������
 VCUR_NUM NUMBER := 0; --�����
 V_RES VARCHAR2(100); --���
 BEGIN
 V_RES := '1, 1,';
 WHILE VCUR_NUM <= 50 LOOP
    VCUR_NUM := VP_NUM+VPP_NUM ;
    V_RES := V_RES||VCUR_NUM||', ';
    VPP_NUM:= VP_NUM;
    VP_NUM:=VCUR_NUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('�Ǻ���ġ �� :' ||V_RES);
END;V

��) ȸ�����̺����� �������� ������ ȸ���� ã�� �� ȸ���� 2005�� ���� ������ ��ȸ�Ͻÿ�
DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_TOT NUMBER ;
    CURSOR CUR_CART01
    IS
        SELECT MEM_ID,MEM_NAME
          FROM MEMBER
          WHERE MEM_ADD12 LIKE '�泲%';
BEGIN
  OPEN CUR_CART01;
  FETCH CUR_CART02 INTO V_ID,V_NAME;
  WHILE CUR_CART01%FOUND LOOP
  -- V_ID�� ����� ȸ���� ��� ���)
  SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_TOT
    FROM FROM CART A, PROD B
    WHERE A.CART_PROD= B.PROD_ID
    AND A. CART_MEMBER= V_ID
    AND A. CANT_NO LIKE '2005%';
    
    DBMS_OUTPUT.PUT_LINE('ȸ����ȣ :'||V_ID);
    DBMS_OUTPUT.PUT_LINE('ȸ���� :'||V_NAME);
    DBMS_OUTPUT.PUT_LINE('���űݾ� �հ� :' ||V_TOT);
    DBMS_OUTPUT.PUT_LINE('----------------------------');
      FETCH CUR_CART01 INTO V_ID,V_NAME;
  END LOOP; 
END;          


 (3) FOR��
 . ����� (INDEX)�� �̿��� �ݺ� ����
 . �����(INDEX)�� �ý��ۿ��� �ڵ�����(���� ���ʿ�)
 (�������)
 FOR index IN [REVERSE] �ʱⰪ..������ LOOP
 �ݺ�ó�� ���ɹ�(��)
 END LOOP;
 
 
 ��)������ ������ ���ϴ� ���α׷��� �ۼ�
   1) ���� 1�� 1�� 1�Ϻ��� ���� (2019��) 12 31���� ����� �ϼ�
   2)���� 1�� 1�Ϻ��� ���� �������� ���� �ϼ�
   3)�ݿ� 1�Ϻ��� ���ñ��� �ϼ�
   ------------------------------------------------------
   1)2)3)�� �հ踦 8�� ���� ������ ����
   
   DECLARE--1) ���� 1�� 1�� 1�Ϻ��� ���� (2019��) 12 31���� ����� �ϼ�
   V_TOT NUMBER :=0;
   V_YEAR NUMBER :=EXTRACT(YEAR FROM SYSDATE);
   V_MONTH NUMBER :=EXTRACT(MONTH FROM SYSDATE);
    V_DATE NUMBER :=EXTRACT(DAY FROM SYSDATE);
BEGIN
 FOR Y IN 1..V_YEAR-1 LOOP
  IF (MOD(Y,4) = 0 AND MOD(Y,100)<>0) OF (MOD(Y,400)=0) THEN
        V_TOT:=V_TOT+366; --����
    ELSE
        V_TOT:=V_TOT+365;--���
    END IF;
  END LOOP;
  
--       2)���� 1�� 1�Ϻ��� ���� �������� ���� �ϼ�
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
  
  
  
  
  
  
  **Ŀ���� ���Ǵ� FOR��
  (1) �������
  FOR ������ IN Ŀ����[(�Ű�����),...] lOOP
      �ݺ�ó����;
      END LOOP;
      . '���ڵ��'�� �ý����� �ڵ����� �Ҵ���
      . Ŀ������ �÷� ������ ' ���ڵ��.�÷Ÿ�' �������� ����
      . OPEN,FETCH, CLOSE ���� ���ʿ���.
      
 