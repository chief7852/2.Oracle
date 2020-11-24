2020-11-19-02)��Ÿ �ڷ���
 - 2�� �ڷḦ �����ϱ� ���� �ڷ� Ÿ��
 - BLOB, RW, LONG RAW, BFILE ���� ����              -- RAW, LONG RAW�� ���ǾȾ�
                                                   
 1) RAW
 - ��������� ���� �뷮�� 2�� �ڷḦ ����
 - �ε��� ó���� ����
 - ORACLE���� �ؼ��̳� ��ȯ�۾��� �������� ����
 - �ִ� 2000BYTE ���� ó������
 - 16������ 2���� ����
 
 (�������)
 �÷��� RAW(ũ��)
��)
CREATE TABLE TEMP07(
  COL1 RAW(1000),
  COL2 RAW(2000));
  
INSERT INTO TEMP07 VALUES(HEXTORAW('3DE5FF77'),HEXTORAW('00'));
INSERT INTO TEMP07 VALUES('0011110111011111110111011',
                          '00000000');
SELECT * FROM TEMP07;


2)BFILE
 - �����ڷ� ����
 - ��� �����ڷḦ �����ͺ��̽� �ܺο� ����
 - ��� ����(DIRECTORY ��ü)������ ���̺� ����
 - 4GB ���� ���尡��
 
 (�������)
 �÷��� BFILE
   . ���丮 ��Ī(Alias) ����(30BYTE)�� ���ϸ� (256BYTE) ����
   
 �׸����� �������
 1. �׸������� ����� ����Ȯ��
 2. ���丮 ��ü����-�׸��� ����� ���丮�� ���� �ּ�
 CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\other';
 3. �׸��� ������ ���̺� ����
 CREATE TABLE TEMP08(
    COL1 BFILE);
 4. �׸� ����
 INSERT INTO TEMP08
  VALUES(BFILENAME('TEST_DIR' ,'SAMPLE.PNG'));
  
  SELECT * FROM TEMP08;                 -- �׸����� �ؼ����� �ʴ´�.       //����Ͽ����� ����
  
3)BLOB
 - �����ڷ� ����
 - ��� �����ڷḦ �����ͺ��̽� ���ο� ����
 - 4GB ���� ���� ����
 
 (�������)
 �÷��� BLOB
 
 (�׸� ���� ����)
 1. �׸����� �غ�(SAMPLE.JPG)
 2. ���丮 ��ü ����(TEXT_DIR)
 3. ���̺� ����
 CREATE TABLE TEMP09(
    COL1 BLOB);
 4. �͸��� ����
  DECLARE
   L_DIR VARCHAR2(20):='TEST_DIR';
   L_FILE VARCHAR2(30):='SAMLE.jpg'
   L_FILE BFILE;
   L_BLOB BLOB;
  BEGIN
    INSERT INTO TEMP09(COL1) VALUES(EMPTY_BLOB())
        RETURN COL1 INTO L_BLOB:
        
        L_BFILE := BFILENAME(L_DIR,L_FILE);
        DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
        DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
        DBMS_LOB.FILECLOSE(L_BFILE);
  END;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 