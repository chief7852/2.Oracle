2020-11-25-01)�����Լ�
1. ������ �Լ�
  - ABS(n) : n�� ���밪 ��ȯ
  - SIGN(n) : n�� ��ȣ�� ���� 0�ΰ�� 0, ����̸� 1, �����̸� -1 �� ��ȯ
  - SQRT(n) : n�� ����(ROOT)
  - POWER(n1,n2) : n1�� n2�� ���� ��ȯ
  
  
 ��) ��ǰ���̺��� ��ǰ�� ���Դܰ��� ���� �Ǹ� �ܰ��� ���Ͽ�
    ���� ������ ��Ÿ�� �� �ֵ��� ��ȸ�Ͻÿ�
    Alias�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�,�����ǸŰ�,���Ϳ���
    *����� ������ �߻��Ǹ� '����', ������ ������ '�����ǸŻ�ǰ',
    ���ذ� �߻��Ǹ�'���ó�л�ǰ'�̶�� ����Ͻÿ�
UPDATE PROD 
   SET PROD_SALE=PROD_COST
 WHERE PROD_ID LIKE 'P101%';

UPDATE PROD 
   SET PROD_SALE=PROD_COST
 WHERE PROD_ID LIKE 'P102%';

SELECT PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        PROD_COST AS ���Դܰ�,
        PROD_SALE AS �����ǸŰ�,
        CASE WHEN SIGN(PROD_SALE-PROD_COST) = 1 THEN
            '������ǰ'
             WHEN SIGN(PROD_SALE-PROD_COST) = 0 THEN
            '�����ǸŻ�ǰ'
            ELSE '���ó�л�ǰ' END AS ���
    FROM PROD;


**ǥ���� (CASE WHEN THEN ~ END)
  -������ �Ǵ��Ͽ� ó���� ����� �ٸ��� ������ �� ���(IF���� ����� ���)
  - SELECT ������ ���
  (�������)
  CASE WHEN ����1 THEN
            ���1
    WHEN    ����2 THEN
            ���2
             :
        ELSE
            ���n
END
                
                
                
��) ȸ�����̺��� �ֹι�ȣ�� �̿��Ͽ� ������ �����Ͻÿ�. ��, ���������� �����ϴ�
    ȸ���������� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ,ȸ����,�ּ�,����
SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
        CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                  SUBSTR(MEM_REGNO2,1,1)='4' THEN
                  '����ȸ��'
             WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                  SUBSTR(MEM_REGNO2,1,1)='3' THEN
                  '����ȸ��'
                  ELSE
                    '�����Ϳ���' END AS ����
    FROM MEMBER
WHERE MEM_ADD1 LIKE '����%';
              
              
2. GREATEST(n1,n2[,n3,...]), LEAST((n1,n2[,n3,...])
    - GREATEST : �־��� ��n1,n2[,n3,...] �� ���� ū ���� ��ȭ
    - LEAST : �־��� �� n1,n2[,n3,...] �� ���� ���� ���� ��ȯ        --���ڿ��� ��쿡�� �ƽ�Ű�ڵ�� ��ȯ�Ȱ��߿� ���� �������� ã�´� 
        
        
��)  --���ڿ��� ��쿡�� �ƽ�Ű�ڵ�� ��ȯ�Ȱ��߿� ���� �������� ã�´� 
SELECT GREATEST(20,-15,70), LEAST('������','������','������')
    FROM DUAL;
    
����) ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ������ ���ϸ����� 1000����
     �ο��Ϸ� �Ѵ� �̸� �����Ͻÿ�((GREATEST) ���)
     Alias�� ȸ����ȣ, ȸ����, ���ϸ���
SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       GREATEST(MEM_MILEAGE,1000) AS ���ϸ���
FROM MEMBER             
                
3. ROUND(n [,1]), TRUNC(n [,1])
  - ROUND : �־��� �ڷ� n�� 1+11��° �ڸ����� �ݿø��Ͽ� 1�ڸ����� ǥ��
  - TRUNC : �־��� �ڷ� n�� 1+1��° �ڸ����� �ڸ������Ͽ� 1�ڸ����� ǥ��
  - 1�� �����̸� �����κ� 1�ڸ����� �ݿø�(ROUND), �ڸ�����(TRUNC)
  - 1 �� �����Ǹ� 0���� ����
  
��)������̺��� �� �μ��� ����ӱ��� ��ȸ�Ͻÿ�     --�ӱ� ���� /�μ��ο�
    ����ӱ��� �Ҽ� 2�ڸ����� ����Ͻÿ�
    Alias �μ��ڵ�,�μ���,����ӱ�

SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
        DEPARTMENTS.DEPARTMENT_NAME AS �μ���,
        TO_CHAR(ROUND(AVG(A.SALARY),2),'99,999.99') AS ����ӱ�
    FROM EMPLOYEES A, DEPARTMENTS
    WHERE A.DEPARTMENT_ID =DEPARTMENTS.DEPARTMENT_ID
    GROUP BY A.DEPARTMENT_ID,DEPARTMENTS.DEPARTMENT_NAME
    ORDER BY 1;
                
����] ������̺��� �̿��Ͽ� ������� �̹��� �޿��� �����Ϸ��Ѵ�.
     ���޾��� ���ʽ�+�޿�-�����̰� ���ʽ��� ��������(COMMISION_PCT)*�޿��̴�.
     �� ������ ���ʽ�+�޿��� 3%�̴�.
     Alias�� �����ȣ,�����,�μ��ڵ�,�޿�,���ʽ�,����,���޾��̸�
            �Ҽ� ù�ڸ����� ��Ÿ���ÿ�
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ��ڵ�,
       SALARY AS �޿�,
       ROUND(NVL(COMMISSION_PCT*SALARY,0),1) AS ���ʽ�,
       TRUNC((SALARY+NVL(COMMISSION_PCT*SALARY,0))*0.03,1) AS ����,
       SALARY+ROUND(NVL(COMMISSION_PCT*SALARY,0),1)-
       TRUNC((SALARY+NVL(COMMISSION_PCT*SALARY,0))*0.03,1) AS ���޾�
FROM EMPLOYEES;

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
    
    
    
    
    
    
    
    
    
    