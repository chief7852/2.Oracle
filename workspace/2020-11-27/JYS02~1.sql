2020-11-27-02) �����Լ�                 =========================�ܿ�����
  - �� ���̺��� �����͵��� Ư�� �÷��� �������� �׷�ȭ�ϰ� 
    �� �׷쳻�� �����Ϳ� ���Ͽ� ����ó��(�հ�,��,����,�ִ밪,�ּҰ�)
  - SUM,AVG,COUNT,MIN,MAX
  - SELECT ���� �����Լ��� �Ϲ��÷��� ���� ���Ǹ� �ݵ�� GROUP BY ���� ����Ǿ����    --�Ϲ��÷��� �����̵Ǿ �׷��� �����.
  (�������)
  SELECT [�÷���1,..,]
          SUM(�÷���)|COUNT(*|�÷���)|AVG(�÷���)|MAX(�÷���)|MIN(�÷���)
     FROM ���̺��
  [WHERE ����]
  [GROUP BY �÷���1,..]
 [HAVING ����]
  [ORDER BY �÷���|�÷��ε���];
    . SELECT ������ '[�÷���1,..,]'�� �����Ǹ� GROUP BY���� �ʿ� ����(���̺� ��ü�� �ϳ��� �׷�)
    . '[GROUP BY �÷���1,..]' �� ����Ǵ� �÷����� SELECT������ ���� �����Լ� �̿���
     �÷����� ����ϰ� �ʿ信 ���� SELECT������ ������� ���� �÷��� ��� ����
    . 'GROUP BY' ������ ����Ǵ� �÷��� ������ �׷��� �Ǵ� ������
    . '[HAVING ����]' : �����Լ� ��ü�� ������ �ο��� ��� ���
    
    
1. SUM(column)
  - 'column'�� ����� �� �׷캰 �հ踦 ���Ͽ� ��ȯ
  ��)��� ���̺��� ��ü ������� �޿��հ踦 ���Ͻÿ�
  SELECT SUM(SALARY)
    FROM EMPLOYEES;
    
 ��) ������̺��� �� �μ��� ������� �޿��հ踦 ���Ͻʽÿ�
  SELECT DEPARTMENT_ID,     --�Ϲ��Լ�
         COUNT(*),
         SUM(SALARY)  --�����Լ�
    FROM EMPLOYEES  
    GROUP BY DEPARTMENT_ID
    ORDER BY 1;
    
 ��)ȸ�����̺��� ���� ȸ���� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
 SELECT CASE  WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                   SUBSTR(MEM_REGNO2,1,1)='3'
                   '����ȸ��'
              ELSE
                   '����ȸ��'
                   END AS ����,
                   SUM(MEM_MILEAGE) AS ���ϸ��� �հ�
      FROM MEMBER
      GROUP BY CASE  WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                   SUBSTR(MEM_REGNO2,1,1)='3'
                   '����ȸ��'
              ELSE
                   '����ȸ��'
                   END;

��) 2005�� 2-3�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
    Alias�� ��ǰ�ڵ�, ���Լ���, ���Աݾ�, ��¥
SELECT BUY_PROD AS ��ǰ�ڵ�,
        SUM(BUY_QTY) AS ���Լ���,
        TO_CHAR(SUM(BUY_QTY*BUY_COST),'99,999,999') AS ���Աݾ�
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331')
  GROUP BY BUY_PROD
  ORDER BY 1;
  
��) 2005�� 2-3�� ��ǰ�� ������Ȳ�� ��ȸ�ϵ� ���Լ����� 100�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
    
SELECT BUY_PROD AS ��ǰ�ڵ�,
        SUM(BUY_QTY) AS ���Լ���,
        TO_CHAR(SUM(BUY_QTY*BUY_COST),'99,999,999') AS ���Աݾ�
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050331') 
    HAVING SUM(BUY_QTY) >= 100                          --HAVING�� �����Լ� ���ǰɶ� ���
  GROUP BY BUY_PROD
  ORDER BY 1;    
    
 ** ��ǰ���̺��� ����� �����Ͻÿ�
    ����� ��������� 130%�̸� �����̴�.
UPDATE PROD SET PROD_TOTALSTOCK = PROD_PROPERSTOCK*1.3;
      
��)��ǰ���̺��� ��ǰ�з��� ��� �հ踦 ���Ͻÿ�,�� ��� 250�� �̻� �����ִ�
   �ڷḦ ��ȸ�Ͻÿ�

SELECT  PROD_LGU AS ��ǰ�з��ڵ�,
        SUM(PROD_TOTALSTOCK) AS ����հ�
        FROM PROD
    GROUP BY PROD_LGU
 HAVING  SUM(PROD_TOTALSTOCK)>= 250
    ORDER BY 1;
    
��)��ٱ������̺��� 2005�� 5�� ���ں� ȸ���� ���� ���踦 ���Ͻÿ�
   Alias�� ȸ����ȣ, ��������հ�

SELECT CART_MEMBER AS ȸ����ȣ,
       SUM(CART_QTY) AS ��������հ�
    FROM CART
    WHERE SUBSTR(CART_NO,1,6) = '200505'
    GROUP BY CART_MEMBER
    ORDER BY 1;
     ��)��ٱ������̺��� 2005�� 5�� ���ں� ȸ���� ���� ���踦 ���Ͻÿ�
   Alias�� ��ǰ�ڵ�, ��������հ�

SELECT CART_PROD AS ��ǰ�ڵ�,
       SUM(CART_QTY) AS ��������հ�
    FROM CART
    WHERE SUBSTR(CART_NO,1,6) = '200505'
    GROUP BY CART_PROD
    ORDER BY 1;
    
 ��)��ٱ������̺��� 2005�� 5�� ���ں� ȸ���� ���� ���踦 ���Ͻÿ�
   Alias�� ��¥,��ǰ�ڵ�, ��������հ�
    SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
           CART_MEMBER AS ȸ����ȣ,
       SUM(CART_QTY) AS ��������հ�
    FROM CART
    WHERE SUBSTR(CART_NO,1,6) = '200505'
    GROUP BY TO_DATE(SUBSTR(CART_NO,1,8)),CART_MEMBER
    ORDER BY 1,2;
     
 
 
����) 2005�� ��ݱ�(1-6��) �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�                            --�߸����̺��� �ϳ��ִ�.
     Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,���Լ���,���Աݾ�
 
 
����) ������̺��� �̿��Ͽ� �μ��� �޿��հ踦 ���Ͻÿ�      --����Ǯ������ ���� JOIN�� �̿���
      Alias�� �μ��ڵ�, �μ���,�޿��հ�     --�μ����� DEPARTMENTS���̺��̰���������
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           B.DEPARTMENT_NAME AS �μ���,
           SUM(A.SALARY) AS �޿��հ�
        FROM EMPLOYEES A, DEPARTMENTS B
       WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID --JOIN����
        GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
        ORDER BY 1;
 
 
    
    