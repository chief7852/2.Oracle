2020-12-15-02) Ŀ��(CURSOR)
 - ������ ���࿡ ������� ����� ����
 - ������ Ŀ���� ����� Ŀ���� ����
 - ����ο��� ����ɼ��ִ�
1) ������ Ŀ�� (IMPLICIT CURSOR)
    . SQL ����� ����Ǹ� �ڵ����� �����Ǵ� Ŀ��
    . �͸�Ŀ��
    . �������� ����� ����ʰ� ���ÿ� CLOSE�Ǿ� ����ڰ� ������ �� ����
    . Ŀ�� �Ӽ�
---------------------------------------------------------------------
    �Ӽ���         ����
---------------------------------------------------------------------
  SQL%FOUND       Ŀ���� �ϳ��� ���̶� �����ϸ� ��(TRUE) ��ȯ
  SQL%NOTFOUND    Ŀ���� �ϳ��� ���̶� �����ϸ� ����(FALSE) ��ȯ
  SQL%ISOPEN      Ŀ���� OPEN�Ǿ����� ��(�͸�Ŀ���� �׻� FALSE)
  SQL%ROWCOUNT    Ŀ���� ���Ե� ���� ��
  
  
��)ȸ�����̺��� �������� '����'�� ȸ���� �̸��� �ڽ��� �̸����� �����ϰ� 
   ����� ó�� �Ǿ����� Ȯ���ϴ� �͸����� �ۼ��Ͻÿ�

DECLARE

BEGIN
    UPDATE MEMBER
      SET  MEM_NAME = MEM_NAME
     WHERE MEM_ADD1 LIKE '����%';
     
      DBMS_OUTPUT.PUT_LINE('ó���Ǽ� : '||SQL%ROWCOUNT);
END; 
 
 
 
 
 
 
 
 SELECT COUNT (*)
 FROM MEMBER
 WHERE MEM_ADD1 LIKE '����%';

2)����� Ŀ��(EXPLICIT CURSOR) 
 . ����ڰ� ����ο��� ������ Ŀ��
 . Ŀ���� ���ܰ�� ���� ->OPEN->FETCH->CLOSE�̴�
 . Ŀ�� ��������� ������� �����Ͽ� ������ �����͸� �̿��� ����ó���� ����(SELECT ���� ���� Ŀ�� ����)
 (1)����
 (��������)CURSOR Ŀ����[(�Ű�����[,�Ű�����,...])]
    IS SELECT ��;
    
 ��) �μ���ȣ�� �Է¹޾� �ش�μ��� �Ҽӵ� �����ȣ�� ����̸��� ����ϴ� Ŀ���� �����Ͻÿ�
 
 DECLARE
  CURSOR CUR_EMP01(P_DEPT_ID  DEPARTMENTS.DEPARTMENT_ID%TYPE)
  IS
   SELECT EMPLOYEE_ID, EMP_NAME
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 60;--P_DEPT_ID;     --��������� Ŀ��

(2) OPEN 
 . Ŀ���� ����ϱ� ���� �ݵ��(FOR�� ����) OPEN �ؾ���
 . OPEN����� �����(BEGIN ~ END)���� �ۼ�
 
 (�������)
 OPEN Ŀ����[(�Ű�����[,�Ű�����,...])];
 
 
 ��)2005�� 1�� �з��ڵ庰 ���Լ����� ���Աݾ��հ踦 ���ϴ� Ŀ��
 DECLARE
  V_GU LPROD.LPROD_GU%TYPE;
  V_NAME LPROD.LPROD_NM%TYPE;
  V
  CURSOR CUR_BUY01
  IS
    SELECT LPROD_GU, LPROD_NM
      FROM LPROD;
 BEGIN
  OPEN CUR_BUY01;
  
  LOOP
    FETC