2020-12-02-01)
��)��ǰ���̺��� ��ǰ�� �з��ڵ尡 'P200'���� ��ǰ�� ��ȸ�Ͻÿ�
    Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �з���, �ǸŰ����̴�
    SELECT A.PROD_ID AS ��ǰ�ڵ�,
           A.PROD_NAME AS ��ǰ��,
           A.PROD_LGU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           A.PROD_PRICE AS �ǸŰ���
      FROM PROD A , LPROD B
     WHERE A.PROD_LGU LIKE 'P2%' --�Ϲ�����
       AND A.PROD_LGU=B.LPROD_GU
  ORDER BY 3;
  
(ANSI���� ���);
    SELECT A.PROD_ID AS ��ǰ�ڵ�,
           A.PROD_NAME AS ��ǰ��,
           A.PROD_LGU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           A.PROD_PRICE AS �ǸŰ���
      FROM PROD A   
    INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)    --��������
    WHERE A.PROD_LGU LIKE 'P2%'         --�Ϲ�����
    ORDER BY 3;


 ����)2005�� 1�� 1�� ~ 15�� ���� �߻��� ���������� ��ȸ�Ͻÿ�
     Alias ����, ��ǰ�ڵ�,��ǰ��,����,�ݾ�
  SELECT A.BUY_DATE AS ����,
         A.BUY_PROD AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         A.BUY_QTY AS ����,
         A.BUY_QTY*B.PROD_PRICE AS �ݾ�
    FROM BUYPROD A, PROD B
   WHERE A.BUY_DATE BETWEEN '20050101' AND '20050115'
     AND A.BUY_PROD=B.PROD_ID
   ORDER BY 1;
   
   (ANSI���� ���)
       Alias����, ��ǰ�ڵ�,��ǰ��,����,�ݾ�;
  SELECT A.BUY_DATE AS ����,
         A.BUY_PROD AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         A.BUY_QTY AS ����,
         A.BUY_QTY*B.PROD_PRICE AS �ݾ�
    FROM BUYPROD A
 INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
    WHERE A.BUY_DATE BETWEEN '20050101' AND '20050115'
  ORDER BY 1;
-- INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
--    AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND '20050115');
  
����) 2005�� 5�� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�,��ǰ��,������հ�,���Ծ��հ�
  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         C.PROD_NAME AS ��ǰ��,
         SUM(A.CART_QTY*C.PROD_PRICE) AS ������հ�,
         SUM(B.BUY_QTY*B.BUY_COST) AS ���Ծ��հ�
    FROM CART A, BUYPROD B, PROD C
   WHERE A.CART_PROD=C.PROD_ID
     AND B.BUY_PROD=C.PROD_ID
     AND A.CART_NO LIKE '200505%'
     AND B.BUY_DATE BETWEEN ' 20050501' AND '20050531'
  GROUP BY C.PROD_ID,C.PROD_NAME
  ORDER BY 1;
  
(2005�� 5�� ��ǰ�� ������Ȳ)
  
  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         C.PROD_NAME AS ��ǰ��,
         SUM(A.CART_QTY*C.PROD_PRICE) AS ������հ�
    FROM CART A, PROD C
    WHERE A.CART_PROD=C.PROD_ID
      AND A.CART_NO LIKE '200505%'
    GROUP BY C.PROD_ID,C.PROD_NAME
    ORDER BY 1;

(�ܺ�����-ANSI)
 SELECT C.PROD_ID AS ��ǰ�ڵ�,
         C.PROD_NAME AS ��ǰ��,
         SUM(A.CART_QTY*C.PROD_PRICE) AS ������հ�,
         SUM(B.BUY_QTY*B.BUY_COST) AS ���Ծ��հ�
    FROM CART A
RIGHT OUTER JOIN PROD C ON(A.CART_PROD=C.PROD_ID
     AND A.CART_NO LIKE '200505%')
LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID
     AND B.BUY_DATE BETWEEN ' 20050501' AND '20050531')
  GROUP BY C.PROD_ID,C.PROD_NAME
  ORDER BY 1;


����)2005�� 1~6�� ���� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�
    Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,���Ծ��հ�                 --BUY���̺�� BUYER���̺��� ���� �߸ŵǴ°��� ã������Ѵ�.(PROD)
  SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
         A.BUYER_NAME AS �ŷ�ó��,
         SUM(C.BUY_QTY*C.BUY_COST) AS ���Ծ��հ�
    FROM BUYER A, PROD B, BUYPROD C
    WHERE C.BUY_PROD = B.PROD_ID
      AND A.BUYER_ID = B.PROD_BUYER
      AND C.BUY_DATE BETWEEN '20050101' AND '20050630'
    GROUP BY A.BUYER_ID, A.BUYER_NAME
    ORDER BY 1;
    
(ANSI JOIN���ĺ�ȯ);
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
       A.BUYER_NAME AS �ŷ�ó��,
       SUM(C.BUY_QTY*C.BUY_COST) AS ���Ծ��հ�
  FROM BUYER A
INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
INNER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID
     AND C.BUY_DATE BETWEEN '20050101' AND '20050630')
  GROUP BY A.BUYER_ID, A.BUYER_NAME
    ORDER BY 1;



 ����)��ٱ������̺��� 2005�� 5�� ȸ���� �Ǹűݾ��� ��ȸ�Ͻÿ�          --PROD_PRICE CART_QTY
     Alias�� ȸ����ȣ,ȸ����,���ž�(ANSI INNER JOIN���)
 SELECT A.MEM_ID AS ȸ����ȣ,
        A.MEM_NAME AS ȸ����,
        SUM(B.CART_QTY*C.PROD_PRICE) AS �Ǹž�
    FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.CART_MEMBER)
INNER JOIN PROD C ON(B.CART_PROD=C.PROD_ID
       AND CART_NO LIKE '200505%')
    GROUP BY A.MEM_ID,A.MEM_NAME
    ORDER BY 3 ;
    
    
    (�⺻���);
 SELECT A.MEM_ID AS ȸ����ȣ,
        A.MEM_NAME AS ȸ����,
        NVL(SUM(B.CART_QTY*C.PROD_PRICE),0) AS �Ǹž�
   FROM MEMBER A,CART B,PROD C
  WHERE A.MEM_ID=B.CART_MEMBER
    AND B.CART_PROD=C.PROD_ID
    AND B.CART_NO LIKE '200505%'        --SUBSTR(B.CART_NO,1,6) = '200505'���� ����ð��� ����
    GROUP BY A.MEM_ID,A.MEM_NAME
    ORDER BY 3 ;

--����)������̺��� ������(MANAGER_ID)�� ��������� ��ȸ�Ͻÿ�     --DEPARTMENTS
--    Alias �����ڹ�ȣ,�����ڸ�,�Ҽӻ����,�μ����̴�
--  SELECT MANAGER_ID AS �����ڹ�ȣ,
--         �����ڸ�,
--         AS �Ҽӻ����,
--         DEPARTMENT_NAME AS �μ���
--    FROM EMPLOYEES A,DEPARTMENT B
--    GROUP BY   �ȹ��Ŷ��ϴ�.


        
         
    




