2020-12-04-01)��������
 - �����ȿ� ���Ե� �Ǵٸ� ������ ����������� ��
 - ���������� '()' �ȿ� ���
 - �� ������ ���� ���� �����
 - �����ڿ� ���� ���� ��� ������ �����ʿ� ����ؾ� ��
  (���������� ����)
 - ���������� ������ ���ο� ���� : ������ �ִ� �������� (Correlated Subquery)�� �񿬰��� ��������
    (Noncorrelated subquery)�� ����
 - ���Ǵ� ��ġ�� ���� : �Ϲ� �������� (Select ���� ���), �ζ��� ��������(From ���� ���),
                        ��ø �������� (Where���� ���)�� ����
 - ��ȯ�ϴ� ��/���� ���� ���� : ������/���Ͽ�, ������/���Ͽ�, ������/���߷� ������ ���еǸ� �̴�
    ����ϴ� �����ڿ� ���� ������
    
1. ���������� ��������
 - ���������� �������� ���̿� ������ �߻����� �ʴ� ��������
��) ������̺��� ��ձ޿����� ���� �޿��� �޴� �������(�����ȣ,�����,�μ��ڵ�,�޿�)��ȸ
    (��������: �����ȣ,�����,�μ��ڵ�,�޿� ��ȸ)
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ��ڵ�,
         SALARY AS �޿�
    FROM EMPLOYEES
   WHERE SALARY >= (��ձ޿�);
   
   (��������:��ձ޿�)
  SELECT AVG(SALARY)
    FROM EMPLOYEES;

 (����)
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ��ڵ�,
         SALARY AS �޿�
    FROM EMPLOYEES
   WHERE SALARY >= (SELECT AVG(SALARY)
                        FROM EMPLOYEES);


��)�θ�μ��ڵ�(PRARENT_ID)�� NULL�� �μ��� �Ҽӵ� ��������� ��ȸ�Ͻÿ�
   Alias�� �����ȣ,�����,�μ��ڵ�,��å�ڵ�(JOB_ID)
(��������:������̺��� ��������� ��ȸ)
 SELECT EMPOYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        DEPARTMENT_ID AS �μ��ڵ�,
        JOB_ID AS ��å�ڵ�
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID =  (�θ�μ��ڵ�(PARENT_ID)�� NULL�� �μ��ڵ�)
  
  (�������� : �μ����̺��� �θ�μ��ڵ�(PARENT_ID)�� NULL�� �μ��ڵ�)
  SELECT DEPARTMENT_ID AS �����ȣ
    FROM DEPARTMENTS
  WHERE PARENT_ID IS NULL;
  
  
** �μ����̺��� �μ��ڵ� 60(IT)�� �θ�μ��ڵ带 NULL�� �����Ͻÿ�
  UPDATE DEPARTMENTS
  SET PARENT_ID=NULL
  WHERE DEPARTMENT_ID = 60;
  
   SELECT EMPLOYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        DEPARTMENT_ID AS �μ��ڵ�,
        JOB_ID AS ��å�ڵ�
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID IN  (SELECT DEPARTMENT_ID AS �����ȣ --
                            FROM DEPARTMENTS
                           WHERE PARENT_ID IS NULL);
  
 SELECT A.EMPLOYEE_ID AS �����ȣ,
        A.EMP_NAME AS �����,
        A.DEPARTMENT_ID AS �μ��ڵ�,
        A.JOB_ID AS ��å�ڵ�
   FROM EMPLOYEES A
  WHERE EXISTS (SELECT 1 
                        FROM DEPARTMENTS B
                        WHERE B.PARENT_ID IS NULL
                         AND A.DEPARTMENT_ID = A.DEPARTMENT_ID);
  

2.������ ��������
 - ���������� �������� ���̿� ������ �߻��Ǵ� ��������
 
 
 ��) �����̷����̺�(JOB_HISTORY)���� ��������� ��ȸ�Ͻÿ�
     Alias�� �����ȣ,�����,�μ��ڵ�,�μ���
 SELECT A.EMPLOYEE_ID AS �����ȣ,
        (SELECT B.EMP_NAME
            FROM EMPLOYEES B
            WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID) AS �����,
            A.DEPARTMENT_ID AS �μ��ڵ�,
            (SELECT C.DEPARTMENT_NAME
                FROM DEPARTMENTS C
                WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID) AS �μ���
        FROM JOB_HISTORY A;
        

 ����) ��ǰ���̺��� ���������� ����Ͽ� 'P300'������ ��ǰ�� 
        ��ǰ�ڵ�,��ǰ��,�з��ڵ�,�з����� ����Ͻÿ�.
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         A.PROD_LGU AS �з��ڵ�,
                (SELECT B.LPROD_NM
                   FROM LPROD B
                  WHERE A.PROD_LGU=B.LPROD_GU)AS  �з���
    FROM PROD A
   WHERE A.PROD_ID LIKE 'P3%';
  
����)������� ��ձ޿��� ����Ͽ� ��ձ޿����� �� ���� �޿��� �޴� �������
    �Ҽӵ� �μ��ڵ�� �μ����� ����Ͻÿ�(SUBQUERY ���)
  (��������:�μ����̺��� �μ��ڵ�� �μ����� ���);
  SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
         A.DEPARTMENT_NAME AS �μ���
    FROM DEPARTMENTS A
   WHERE A.DEPARTMENT_ID IN (��ձ޿����� �� ���� �޿��� �޴� ������� �Ҽӵ� �μ�)
   
   
(��������1:������̺��� ��ձ޿����� �� ���� �޿��� �޴� ������̼Ҽӵ� �μ�);
 SELECT B.DEPARTMENT_ID
   FROM EMPLOYEES B
  WHERE B.SALARY > (��ձ޿�);
  
(��������2:��ձ޿�);
 SELECT AVG(SALARY)
   FROM EMPLOYEES;
   
   
(�����ϱ� : IN);
  SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
         A.DEPARTMENT_NAME AS �μ���
    FROM DEPARTMENTS A
   WHERE A.DEPARTMENT_ID IN ( SELECT B.DEPARTMENT_ID
                                FROM EMPLOYEES B
                               WHERE B.SALARY > (SELECT AVG(SALARY)
                                                   FROM EMPLOYEES))
  ORDER BY 1;                                               
  
  
  (�����ϱ� : EXISTS���);
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
         A.DEPARTMENT_NAME AS �μ���
    FROM DEPARTMENTS A
   WHERE EXISTS  ( SELECT 1
                    FROM EMPLOYEES B
                   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                     AND B.SALARY > (SELECT AVG(SALARY)
                                        FROM EMPLOYEES))
  ORDER BY 1;                                               
  
  
 ��) �����μ��� 90���μ�(��ȹ��)�� ������� �޿��� �ڽ��� �����ִ� �μ���
     ��ձ޿��� 10%�� �ش��ϴ� ��ŭ �޿��� �λ��Ͻÿ�
     
   (��������: �����μ��� 90���μ�(��ȹ��)�� �μ��� ��ձ޿�);
   SELECT A.DEPARTMENT_ID,
          AVG(A.SALARY) 
     FROM EMPLOYEES A, DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND B.PARENT_ID=90
  GROUP BY A.DEPARTMENT_ID;
  
  
  
   CREATE OR REPLACE VIEW V_EMP01
  AS
        SELECT A.EMP_NAME, A.SALARY, A.DEPARTMENT_ID
          FROM EMPLOYEES A
        WHERE A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                  WHERE PARENT_ID=90)
        ORDER BY 3
        WITH READ ONLY;
SELECT * FROM V_EMP01;
--  (UPDATE);
  UPDATE EMPLOYEES C
     SET C.SALARY= (SELECT ROUND(C.SALARY+TBLA.SAL)
                    FROM (SELECT A.DEPARTMENT_ID AS DEPTID,
                                 AVG(A.SALARY)*0.1 AS SAL 
                            FROM EMPLOYEES A, DEPARTMENTS B
                           WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                             AND B.PARENT_ID=90
                         GROUP BY A.DEPARTMENT_ID) TBLA
                    WHERE C.DEPARTMENT_ID = TBLA.DEPTID)
        WHERE C.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                   WHERE PARENT_ID = 90);
                                   
                                   
    SELECT * FROM V_EMP01;


  ROLLBACK;
  
  
  
   SELECT A.EMP_NAME, A.SALARY, A.DEPARTMENT_ID
     FROM EMPLOYEES A
    WHERE A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM DEPARTMENTS
                                  WHERE PARENT_ID=90)
        ORDER BY 3;
  
  
  
  
  
  
  
  
  
  