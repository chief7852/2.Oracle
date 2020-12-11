2020-12-11-02) PL/SQL
--JAVA ����Ÿ�� ������ = ������;    PL/SQL ������ ����Ÿ�� := ������;
. Procedural Language/SQL

. ����Ŭ���� �����ϴ� ���α׷��� ���

++. ������ ������ ���� SQL�� �Ϲ� ���α׷��� ��� ��Ҹ� �߰�
    - SQL���� �������� �ʴ� �ݺ���,���ǹ��� ����
   
. �����͸� ���������� ó���ϴµ� �� ����

. �⺻����                      
  - Declare(�����)            //sql�� ������ ����ϱ����� �� ������ �̸� ������ ������Ѵ�.
    _����,��� ����
    _��������
  -Begin(�����)++             //SQL, IF, LOOP
    _���, �ݺ��� ���� ��������
  -Exceptiom(���� ó����)
    _���� ���� �����߻��� catch,�ļ���ġ
    _��������
    
  /�ĺ��� �ۼ���Ģ 30�� �̻�Ѿ��ȵ�


. ������
:= ���� ������
** ���� ������
NOT	�� ������
AND	�� ������
OR	�� ������





��)
1. 10�� �μ��� DANME, LOC �÷� �ΰ��� ������ ��´�
2. �ΰ��� �������� ���(JAVA : SYSTEM.OUT.PRINTLN)
SELECT *
FORM DEPT;

DESC DEPT;              --���̺� Ÿ�� �˾ƺ���
/*DEPTNO    NUMBER(2)    
  DNAME     VARCHAR2(14) 
  LOC       VARCHAR2(13) */

�������� : ������ ����Ÿ��;
PL/SQL : ������ �۸�� V_'XXX' ���ξ� ���''�� �̸�����

SET SERVEROUTPUT ON;

DECLARE
    V_DNAME VARCHAR2(14);
    V_LOC VARCHAR2(13);
BEGIN
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
      FROM DEPT
     WHERE DEPTNO = 10;
     
--     Saytem.out.println(v_dname + " / " + v_loc);       --�׳ɿ�����
     DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);              --PRINT = DBMS_OUTPUT.PUT_LINE ����ϴ°�
END;
/   --PL/SQL �� ����(������)�� ;�� �ƴ� / �����÷� �Ѵ�





----------------
VIEW �� �����̴� ��� �����ϸ� �ɰͰ���.            
---------------



��������++++++++++++++++++++++++++++
(����� : ���̺��.�÷���%TYPE;
 �������� : Ư�����̺��� �÷��� ������ Ÿ���� �ڵ����� ���� => �÷��� ������ Ÿ���� �ٲ�
            PL/SQL ����� ���� ����θ� ������ �ʿ䰡 ������ : ���������� ����);

DECLARE
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
      FROM DEPT
     WHERE DEPTNO = 10;
     
--     System.out.println(v_dname + " / " + v_loc);       --�׳ɿ�����
     DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);              --PRINT = DBMS_OUTPUT.PUT_LINE ����ϴ°�
END;
/


PL/SQL BLOCK ����
1. �͸� �� : inline-view
2. procedure : ����Ŭ ������ ������ pl/sql ��, ���ϰ��� ����
3. function : ����Ŭ ������ ������ pl/sql ��, ���ϰ��� �ִ�


(2. procedure����)
CREATE ����Ŭ��üŸ�� ��ü�̸�....
/*
CREATE TABLE ���̺��
CREATE OR REPLACE VIEW ���̸�*/

(�������)
CREATE PROCEDURE printdept IS 
    --�����
BEGIN
END;
/
------------

CREATE OR REPLACE PROCEDURE printdept IS 
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME , V_LOC
    FROM DEPT
   WHERE DEPTNO = 10;
   
   DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);
END;
/
/*���� ���� ������
EXEC ���ν����� */

EXEC printdept;

-- WHERE DEPTNO = 10; �̰��� �������·� ��ȯ�ؼ�
--�Ұ���
--------------
���� ���ν����� 10�� �μ��� ������ ��ȸ�� �ǰԲ� �ڵ尡 ������(hard coding)
procedure ���ڷ� ��ȸ�ϰ� ���� �μ���ȣ�� �޵��� �����Ͽ� �ڵ带 �����ϰ� ������

���ν����� �����Ҷ� ���ڸ� ���ν����� �ڿ� �����Ҽ� ����
���ڴ� �޼ҵ�� ���������� �������� ���� �� ����

�����ð����� ���ν������� ���� �̸��� P_XXX���ξ ����ϱ�� �սô�.

--CREATE OR REPLACE PROCEDURE[(���ڸ� ���� Ÿ��)] �߰�
CREATE OR REPLACE PROCEDURE printdept(P_DEPTNO DEPT.DEPTNO%TYPE) IS 
    V_DNAME DEPT.DNAME%TYPE;
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT DNAME, LOC INTO V_DNAME , V_LOC
    FROM DEPT
   WHERE DEPTNO = P_DEPTNO;
   
   DBMS_OUTPUT.PUT_LINE(V_DNAME || ' / ' || V_LOC);
END;
/

EXEC printdept(50);

(����)
PL/SQL(PROCEDURE �����ǽ� PRO_1)
 -PRINTEMP PROCEDURE ����
 -PARAM : EMPNO
 -LOGIC : EMPNO�� �ش��ϴ� ����� ������ ��ȸ�Ͽ�
          ����̸�, �μ��̸��� ȭ�鿡 ���
    

CREATE OR REPLACE PROCEDURE PRINTEMP (P_EMPNO EMP.EMPNO%TYPE) IS
    V_ENAME EMP.ENAME%TYPE;
    V_DNAME DEPT.DNAME%TYPE;
BEGIN
    SELECT A.ENAME,B.DNAME INTO V_ENAME , V_DNAME
      FROM EMP A,DEPT B
     WHERE A.EMPNO = P_EMPNO
       AND A.DEPTNO = B.DEPTNO;
     
 DBMS_OUTPUT.PUT_LINE(V_ENAME || ' / ' || V_DNAME);
 END;
 /
 
EXEC PRINTEMP(7902);
