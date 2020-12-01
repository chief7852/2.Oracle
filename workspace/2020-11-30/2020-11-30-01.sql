2020-11-30-01)
2. AVG(column)
 - 'column'�� �������� �׷����� ���� ���ܿ� ���� ��հ� ��ȯ
 ��)������̺��� �� �μ��� ��� �޿��� �Ҽ� 1�ڸ����� ���Ͻÿ�
 SELECT DEPARTMENT_ID AS �μ��ڵ�,
        -- EMP_NAME AS ����̸�, 
        ROUND(AVG(SALARY),1)
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID --EMP_NAME
ORDER BY 1;
  
  ��)��ǰ���̺��� ��ǰ�з��� ��ո��԰��� ���غ��ÿ�.
 SELECT PROD_LGU AS ��ǰ�з�,
        ROUND(AVG(PROD_COST),-1) AS ��ո��԰�
    FROM PROD
  GROUP BY PROD_LGU
  ORDER BY 1;
  
  
 ����)2005�� ���� ��ǰ�� ��ո��Լ����� ���Աݾ��հ踦 ���Ͻÿ�
 SELECT EXTRACT(MONTH FROM BUY_DATE) AS ����,
        BUY_PROD AS ��ǰ�ڵ�,
        ROUND(AVG(BUY_QTY)) AS ��ո��Լ���,
        SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
 FROM BUYPROD
 WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
 GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD
 ORDER BY 1;
 
 ����)2005�� 5�� ���ں� ����Ǹ� ������ ���Ͻÿ�
  SELECT TO_DATE(SUBSTR((CART_NO),1,8)) AS ����,
         ROUND(AVG(CART_QTY)) AS "����Ǹ� ����"
    FROM CART
WHERE CART_NO LIKE '200505%'
GROUP BY TO_DATE(SUBSTR((CART_NO),1,8))
ORDER BY 1;

 ����)������̺��� �� �μ��� ��ձ޿����� ���� �޿��� �޴� ���������
     ����Ͻÿ�                                              --���μ��� ��ձ޿� ��������ϱ�      SELECT DEPARMENT_ID AS DID,
                                                            --                                      AVG(SALATY) AS ASAL ,
     Alias�� �����ȣ, �����, �μ��ڵ�, �μ���, ��ձ޿�
  SELECT DEPARTMENT_ID AS DID,
         AVG(SALARY) AS ASAL
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID;
        
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����, 
         A.SALARY AS �޿�,
         A.DEPARTMENT_ID AS �μ��ڵ�,
         B.DEPARTMENT_NAME AS �μ���,
         ROUND(C.ASAL) AS ��ձ޿�
    FROM EMPLOYEES A, DEPARTMENTS B,
      (  SELECT DEPARTMENT_ID AS DID,
             AVG(SALARY) AS ASAL
         FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) C
  WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
    AND A.DEPARTMENT_ID = C.DID
    AND A.SALARY>=C.ASAL
ORDER BY 4,3;

3. COUNT(*|column)
 - �׷����� ���� �� �׷쿡 ���Ե� �ڷ� ��(���� ��)
 - �ܺ����ο� COUNT�Լ��� ����� ��� '*' ��� �÷����� ����ؾ� ��
 
 ��)������̺��� �� �μ��� �ο����� ���Ͻÿ�
 SELECT DEPARTMENT_ID AS �μ��ڵ�,
        COUNT(*) AS �ο���,
        COUNT(EMP_NAME) AS �����
    FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
  
 ��)2005�� 6�� ��ǰ�� �ǸŰǼ��� ��ȸ�Ͻÿ�
 SELECT PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        COUNT(CART_MEMBER) AS �ǸŰǼ�
    FROM CART 
    RIGHT OUTER JOIN PROD ON(CART_PROD =PROD_ID
    AND  CART_NO LIKE '200506%')
  GROUP BY PROD_ID,PROD_NAME
  ORDER BY 1;
  
  ����)��ǰ���̺��� �� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
 SELECT  PROD_LGU AS ��ǰ�з�,
        COUNT(*) AS ��ǰ�Ǽ�
    FROM PROD
    GROUP BY PROD_LGU
    ORDER BY 1;
  ����)ȸ�����̺��� �� ���ɴ뺰 ȸ������ ��ȸ�Ͻÿ�
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'������' AS ���ɴ�,
         COUNT(*)||'��' AS ȸ����
  FROM MEMBER
  GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)
  ORDER BY 1;
  
  ����)ȸ�����̺��� ���� ������ ȸ������ ���Ͻÿ�
  SELECT MEM_JOB AS ��������,
         COUNT(*) AS ȸ����,
         COUNT(DISTINCT MEM_JOB) AS "ȸ����(DISTINCT)"
    FROM MEMBER
 GROUP BY MEM_JOB
 ORDER BY 1;
  
  
  ����)ȸ�����̺��� ������ ������ ����Ͻÿ�
      Alias ������
SELECT DISTINCT MEM_JOB AS ��������
FROM MEMBER


4.MAX(column),MIN(column)
 - 'coloumn'���� ��� �÷��� ����� �� �� �ִ밪�� �ּҰ��� ���Ͽ� ��ȯ
 - ���������� ��� �ϴ� ����� 'column'�� �������� ������������(MIN), �Ǵ� 
   �������� ���� �� �� �� ù��° ���� ���� ��ȯ
   ���� ó���ð��� �ټ� ���� �ҿ��

*** �ǻ��÷� ROWNUM
 - ���� ���(��)�� ���࿡ �ο��� ���� ��
 - ���� 5�� �Ǵ� ���� 5�� �� �ʿ��� ������ ������� ����� �� ���(�ٸ� DBMS������ TOP �Լ��� ������)
 
 ��)ȸ���� ���ϸ��� �� �ִ븶�ϸ��� ���� ���Ͻÿ�
 SELECT MAX(MEM_MILEAGE)
    FROM MEMBER;
    
 SELECT MEM_MILEAGE
   FROM MEMBER
  ORDER BY 1 DESC;
  
  SELECT A.MILE                     --�� ���� MAX�� ���������� �̷��� �ϳ� �������� �̾Ƴ�����
  FROM(SELECT MEM_MILEAGE AS MILE
        FROM MEMBER
        ORDER BY 1 DESC)A
   WHERE ROWNUM <=1;

--�̴ϸ����Ϸ���
SELECT A.MILE 
  FROM(SELECT MEM_MILEAGE AS MILE
        FROM MEMBER
        ORDER BY 1 ASC) A
   WHERE ROWNUM =1;
   
 ��) ������̺��� �μ��� �ִ�޿��� �ּұ޿��� ��ȸ�Ͻÿ�
 SELECT DEPARTMENT_ID AS �μ��ڵ�,
        MAX(SALARY) AS �ִ�޿�,
        MIN(SALARY) AS �ּұ޿�
    FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
  
 
  
        
  
  
  
  
  
  