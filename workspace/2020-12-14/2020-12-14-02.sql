2020-12-14-02)
PL/SQL (���պ���)
��(�÷�)   - ��(��)    - ��(���̺�)
. TYPE     %ROWTYPE  TABLE TYQE
        RECORD TYPE
        
        
ROWTYPE : �� ��ü�� ������ �� �ִ� ����
          �÷��� ���� ���̺��� ���� ������ ���� �� �÷����� ������ �������� �ʰ�
          ������� �ѹ��� ������ �ϰ� ����ϹǷ� ���Ǽ��� ����ȴ�
          
DEPT ���̺��� 10�� �μ������� ���� �� �ִ� ROWTYPE�� �����Ͽ� Ȱ��
SET SERVEROUTPUT ON;

 DECLARE
    --������ ����Ÿ��
    V_DEPT_ROW  DEPT%ROWTYPE;
 BEGIN
  SELECT * INTO V_DEPT_ROW
  FROM DEPT
  WHERE DEPTNO =10;
  
  --�÷��� �� ���� : ROWTYPE.�÷���
  DBMS_OUTPUT.PUT_LINE( V_DEPT_ROW.DNAME || ' / ' || V_DEPT_ROW.LOC);
  
  END;
  /
  
  
    RECORD TYPE : �����ڰ� �����Ϸ��ϴ� �÷��� ���� �����Ͽ� �࿡���� Ÿ���� ����
                  (JAVA���� Ŭ������ ����)
������
TYPE Ÿ�Ը� IS RECORD(
    �÷��� �÷�Ÿ��,
    �÷���2 �÷�Ÿ��,
)
 ��뿹) 
  
 TYPE Ÿ�Ը� IS RECORD(
 ENAME EMP.ENAME%TYPE,
  DNAME DEPT.DNAME%TYPE(
  
  
  
  
DECLARE
  TYPE NAME_ROW IS RECORD(  
    ENAME EMP.ENAME%TYPE,
    DNAME DEPT.DNAME%TYPE);
    --������ ����Ÿ��
  NAMES NAME_ROW;
BEGIN
  SELECT ENAME, DNAME INTO NAMES
  FROM EMP,DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO
    AND EMPNO = 7839;
    DBMS_OUTPUT.PUT_LINE(NAMES.ENAME ||' /'|| NAMES.DNAME);
END;
/
  






TABLE TYPE : �������� ������ �� �ִ� Ÿ��  

TYPE Ÿ���̸� IS RECORD
TYPE Ÿ���̸� IS TABLE OF ���ڵ� Ÿ�� / %ROWTYPE INDEX BY BINARY_INTEGER
--                                      = int [] arr = new int [50]


DECLARE
  TYPE NAME_ROW IS RECORD(  
    ENAME EMP.ENAME%TYPE,
    DNAME DEPT.DNAME%TYPE);
    
    TYPE NAME_TAB IS TABLE OF NAME_ROW INDEX BY BINARY_INTEGER;
    --������ ����Ÿ��
  NAMES NAME_TAB;
BEGIN
  SELECT ENAME, DNAME BULK COLLECT INTO NAMES
  FROM EMP,DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO;
  
    
    FOR i IN 1..NAMES.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(NAMES(1).ENAME ||' /'|| NAMES(1).DNAME);
    END FOR;
    DBMS_OUTPUT.PUT_LINE(NAMES(1).ENAME ||' /'|| NAMES(1).DNAME);
    DBMS_OUTPUT.PUT_LINE(NAMES(2).ENAME ||' /'|| NAMES(2).DNAME);
    DBMS_OUTPUT.PUT_LINE(NAMES(3).ENAME ||' /'|| NAMES(3).DNAME);
    DBMS_OUTPUT.PUT_LINE(NAMES(14).ENAME ||' /'|| NAMES(14).DNAME);
END;
/
  




DECLARE
  TYPE NAME_ROW IS RECORD(  
    ENAME EMP.ENAME%TYPE,
    DNAME DEPT.DNAME%TYPE);
    
    TYPE NAME_TAB IS TABLE OF NAME_ROW INDEX BY BINARY_INTEGER;
    --������ ����Ÿ��
  NAMES NAME_TAB;
BEGIN
  SELECT ENAME, DNAME BULK COLLECT INTO NAMES
  FROM EMP,DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO;
  
    
    FOR i IN 1..NAMES.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(NAMES(i).ENAME ||' /'|| NAMES(i).DNAME);

    END LOOP;
    END;
    /

  