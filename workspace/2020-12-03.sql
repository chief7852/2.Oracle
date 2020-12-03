2020-12-03-01)�ܺ�����
  - ���������� ���� ������ �������� �ʴ� ��(ROW)�� �˻����� ����
  - �ܺ������� ������ ���̺� NULL������ ä���� ���� �����Ͽ� ���� ����
  - �������� ����� ������ ���̺� ���Ե� �÷��ڿ� �ܺ����� ������ '(+)'��
    ��� : �Ϲ� �ܺ�����
  - �ϳ� �̻��� ���������� �ܺ����εǴ� ��� ��� ���� ���ǿ� '(+)'������ ���
  - �ϳ��� ���̺��� ���ÿ� Ȯ��Ǵ� �ܺ������� ������ ����. ��, A,B,C,���̺��� �ܺ������ϴ� ���
    A�� �������� B�� �ܺ������ϴ� ���ÿ� C�� �������� B�� �ܺ����� ���� ����
    ex) WHERE A.Col = B.Col(+)
          AND C.Col = B.Col(+) -- ��� �ȵ�
  - �Ϲ������� �߰��� �ܺ������� �Ϲ� �ܺ������� ����ϸ� �������� ����� ��ȯ
        -->ANSI �ܺ������̳� Subquery�� �̿��ؾ���

 (ANSI�ܺ����� ��� ����)
 SELECT �÷� list
   FROM ���̺��[��Ī]
 FULL|RIGHT|LEFT OUTER JOIN ���̺��[��Ī] ON(��������
    [AND �Ϲ�����1])
  FULL|RIGHT|LEFT OUTER JOIN ���̺��[��Ī] ON(��������
    [AND �Ϲ�����2])
  [WHERE �Ϲ�����]
  . FULL : ���� ���̺� ��� Ȯ��
  . RIGHT : ���̺��2�� ���̺��1 ���� �� ���� ������ �ڷᰡ �ִ� ���(
    ���̺��1�� Ȯ��Ǵ°��)
  . LEFT : ���̺��1�� ���̺��2 ���� �� ���� ������ �ڷᰡ �ִ� ���(
    ���̺��2�� Ȯ��Ǵ°��)
  . �Ϲ�����1,�Ϲ�����2�� �ش� ���̺��� ����Ǵ� ����
  . WHERE ���� �Ϲ������� ��ü�� ����� ����
  
  ��) ��� ȸ���鿡 ���� �������踦 ��ȸ�Ͻÿ�;
      Alias�� ȸ����ȣ,ȸ����,������հ�
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         NVL(SUM(B.CART_QTY*C.PROD_PRICE),0) AS ������հ�
    FROM MEMBER A,CART B,PROD C
    WHERE A.MEM_ID=B.CART_MEMBER(+)
     AND B.CART_PROD=C.PROD_ID(+)
     GROUP BY A.MEM_ID, A.MEM_NAME
     ORDER BY 1;
     
     
  (ANSI ����)
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         NVL(SUM(B.CART_QTY*C.PROD_PRICE),0) AS ������հ�
    FROM MEMBER A
    LEFT OUTER JOIN CART B ON(A.MEM_ID=B.CART_MEMBER)
    LEFT OUTER JOIN PROD C ON(B.CART_PROD=C.PROD_ID)
     GROUP BY A.MEM_ID, A.MEM_NAME
     ORDER BY 1;
  
 ��)2005�� 3�� ������ ��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
    Alias�� ��ǰ�ڵ�,��ǰ��,���Լ���,���Աݾ�
 (ANSI FORMAT)
  SELECT B.PROD_ID AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
         NVL(SUM(A.BUY_QTY*A.BUY_COST),0) AS ���Աݾ�
    FROM BUYPROD A
    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
     AND A. BUY_DATE BETWEEN '20050201' AND '20050228')
   GROUP BY  B.PROD_ID,B.PROD_NAME
    ORDER BY 4 DESC;
    
 (SUBQUERY)
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         NVL(A.CNT,0) AS ���Լ���,
         NVL(A.AMT,0) AS ���Աݾ�
    FROM (SELECT BUY_PROD AS BID,
                 NVL(SUM(BUY_QTY),0) AS CNT,
                 NVL(SUM(BUY_QTY*BUY_COST),0) AS AMT
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN '20050201' AND '20050228'
            GROUP BY BUY_PROD) A,
           PROD B
   WHERE A.BID(+)=B.PROD_ID
   ORDER BY 4 DESC;
    
(�Ϲݿܺ�����);
  SELECT A.BUY_PROD AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         SUM(A.BUY_QTY) AS ���Լ���,
         SUM(A.BUY_QTY*A.BUY_COST) AS ���Աݾ�
    FROM BUYPROD A, PROD B
   WHERE A.BUY_PROD=B.PROD_ID
    -- AND A. BUY_DATE BETWEEN '20050201' AND '20050228'
   GROUP BY  A.BUY_PROD,B.PROD_NAME;
    
(4���� �Ǹŵ� ��ǰ�� ����)
SELECT COUNT(DISTINCT BUY_PROD)
FROM BUYPROD
WHERE BUY_DATE BETWEEN '20050401' AND '20050430';

����) ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
     Alias�� ��ǰ�з��ڵ�,�з���,��ǰ�Ǽ�
     (ANSI ����);
 SELECT A.LPROD_GU AS ��ǰ�з��ڵ�,
        A.LPROD_NM AS �з���,
        COUNT(B.PROD_ID) AS ��ǰ�Ǽ�
   FROM LPROD A 
   LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.PROD_LGU)
  GROUP BY A.LPROD_GU, A.LPROD_NM;

(�Ϲ�);
 SELECT A.LPROD_GU AS ��ǰ�з��ڵ�,
        A.LPROD_NM AS �з���,
        COUNT(B.PROD_ID) AS ��ǰ�Ǽ�
   FROM LPROD A , PROD B 
   WHERE A.LPROD_GU=B.PROD_LGU(+)
  GROUP BY A.LPROD_GU, A.LPROD_NM;
 
����) ������̺��� ��� �μ��� ��ձ޿��� ����Ͻÿ� EMP(NULL),DEP(NOT NULL),
      ��� �޿��� �Ҽ������� ����ϰ�, �μ��ڵ�,�μ���,��ձ޿��� ����Ұ�
 SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
        NVL(B.DEPARTMENT_NAME,'����') AS �μ���,
        NVL(ROUND(AVG(A.SALARY)),0) AS ��ձ޿�
   FROM EMPLOYEES A
   LEFT OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   
    GROUP BY  B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1 DESC;
    
    
    
     SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
        NVL(B.DEPARTMENT_NAME,'����') AS �μ���,
        NVL(ROUND(AVG(A.SALARY)),0) AS ��ձ޿�
   FROM EMPLOYEES A
   FULL OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
    GROUP BY  B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1,3 DESC;
    
����) 2005�� 6�� ��� ��ǰ�� ����� ��Ȳ�� ��ȸ�Ͻÿ�
     Alias�� ��ǰ�ڵ�, ��ǰ��, �԰����, ���Ծ�, ������, �����
  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         C.PROD_NAME AS ��ǰ��,
         NVL(SUM(A.BUY_QTY),0) AS �԰����,
         NVL(SUM(A.BUY_QTY*C.PROD_COST),0) AS ���Ծ�,
         NVL(SUM(B.CART_QTY),0) AS ������,
         NVL(SUM(B.CART_QTY*C.PROD_PRICE),0) AS �����
    FROM BUYPROD A
       RIGHT OUTER JOIN PROD C ON(A.BUY_PROD=C.PROD_ID
       AND A.BUY_DATE BETWEEN '20050601' AND '20050630')
       LEFT OUTER JOIN CART B ON(B.CART_PROD=C.PROD_ID
        AND SUBSTR(B.CART_NO,1,6) = '200506')
        GROUP BY C.PROD_ID,C.PROD_NAME
       ORDER BY 1;


    
   
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  