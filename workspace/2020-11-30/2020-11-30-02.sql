2020-11-30-02) ROLLUP�� CUBE
  - SUM �Լ��� �׷캰 ���踸 ��ȯ�ϸ� ��ü �հ踦 ��ȯ���� ����
  - GROUP BY ���� ����� �÷��� �������θ� �����ȯ
  ex)
   SELECT PERIOD, GUBUN,
            SUM(LOAN_JAN_AMT)
        FROM KOR_LOAN_STATUS
      GROUP BY PERIOD, GUBUN
      ORDER BY 1,2;
      
 1.ROLLUP
  - GROUP BY ���� ���
  - ROLLUP ������ ����� �÷����� �������� ������ ���谡 �ʿ��� ��� ���
  (�������)
     GROUP BY ROLLUP(�÷���1[�÷���2,..])
      . ROLLUP ���� ����� �÷��� ���� n���϶� n+! ������ ���� ��ȯ
      . �÷���1�� �÷���2�� ������ ����(GROUP BY �� ����)
        �÷���1�� �������� ������ ����
        ��ü����
        
    SELECT PERIOD, GUBUN,
            SUM(LOAN_JAN_AMT)
        FROM KOR_LOAN_STATUS
      GROUP BY ROLLUP(PERIOD, GUBUN)
      ORDER BY 1,2;
     
     SELECT SUM(LOAN_JAN_AMT)
        FROM KOR_LOAN_STATUS;
      
      
  ��)����ü�̺��� �Ⱓ��,������,���к� �����ܾ��� �հ踦 ��ȸ�Ͻÿ�
  (GROUP BY �������)
    SELECT PERIOD, REGION, GUBUN,
       SUM(LOAN_JAN_AMT)
      FROM KOR_LOAN_STATUS
  GROUP BY ROLLUP(PERIOD, REGION, GUBUN)
  ORDER BY 1,2;
  
  (GROUP BY �������)
    SELECT PERIOD, REGION, GUBUN,
       SUM(LOAN_JAN_AMT)
      FROM KOR_LOAN_STATUS
  GROUP BY CUBE(PERIOD, REGION, GUBUN)
  ORDER BY 1,2;