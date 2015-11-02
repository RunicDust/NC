DROP VIEW empvu111;
DROP VIEW empvu112;
DROP VIEW empvu113;
DROP TABLE emp_sale CASCADE CONSTRAINTS;
DROP TABLE sale CASCADE CONSTRAINTS;
DROP TABLE purchase CASCADE CONSTRAINTS;
DROP TABLE mngr CASCADE CONSTRAINTS;
DROP TABLE job CASCADE CONSTRAINTS;
DROP TABLE loc CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;
DROP TABLE employee_drop CASCADE CONSTRAINTS;
DROP sequence emp_id;
DROP sequence dept_id ;
DROP sequence loc_id;
DROP sequence job_id;
DROP sequence mngr_id;
DROP sequence sale_id;
DROP sequence purchase_id;
/*******************************************************************************
���� 1. �������� ������������� (VIEW) c ������������� ���������� ( ������ �� )
��������� ��������� ������ �� � ������ ���������� ������������ ��� ������ old_db
(�����"������� hr_create.sql � hr_popul.sql)
*******************************************************************************/
/*
1.1 � ������ �� ������� ������������� � ������������� ����������
� ���������� ��������
1.1.1 ������� �������������, �������:
- �������� ������� ����������� � ���������� �������, ��������� � ������� ����� ��
������;
- ������� ����������� ����������� ���: ������ ����� � ������� ��������, ��������� - �
������;
- ���������� ������� ��������� �� ���������� ������;
- ������������� ����������� �� �������� ������� ������.
��������� ������ � ���������� �������������.
*/
CREATE VIEW empvu111 AS
SELECT INITCAP(last_name) lastname,
  ROUND(MONTHS_BETWEEN(sysdate, hire_date)) months
FROM employees e
ORDER BY months DESC;
SELECT * FROM empvu111;
/*
LASTNAME                      MONTHS
------------------------- ----------
King                             345
Whalen                           337
Kochhar                          313
Hunold                           310
Ernst                            293
De Haan                          273
Mavris                           262
Baer                             262
Higgins                          262
Gietz                            262
Faviet                           254
*/
/*
1.1.2. ������� �������������, �������:
- �������� �������, ����� �����������;
- �������� ��� ����������� �������� � �������� "Tax", ������� ������������ ���
4% �� ������ ��� ������ ��� Programmer, 3% �� ������ ��� ������ ��� Accountant,
2% �� ������ ��� ������ ��� Sales Manager
� 0.1% �� ������ ��� ������ ��� Administration Assistant.
*/
CREATE VIEW empvu112 AS
SELECT last_name,
  first_name,
  DECODE (job_title, 'Programmer', (0.04*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Accountant',(0.03*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Sales Manager',(0.02*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Administration Assistant',(0.0001*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 0) "Tax"
FROM employees
JOIN jobs USING(job_id);
SELECT * FROM empvu112;
/*
LAST_NAME                 FIRST_NAME                  Tax
------------------------- -------------------- ----------
King                      Steven                        0
Kochhar                   Neena                         0
De Haan                   Lex                           0
Hunold                    Alexander                  9360
Ernst                     Bruce                      5760
Austin                    David                      3648
Pataballa                 Valli                      3456
Lorentz                   Diana                      2856
Greenberg                 Nancy                         0
Faviet                    Daniel                     5670
Chen                      John                       4428
*/
/*
1.1.3. ������� �������������, �������:
- �������� ������� �����������
- ��������  ����������  ��������  ���� (�������,  �����������)
�  �������  ��  ����������  �� ������, ��������, ���� ��������� ��� �������� �
������� �������, � ������� �����������, �� � ���� ��� ���� 2 �������� ���, ����
����� ������ 3 ��� � ������� ��� ����������.
- ���������� ��������� � ���� 1998 ����;
- ������������� ����������� � ������� �������� ���������� �������� ����.
*/
CREATE VIEW empvu113 AS
SELECT last_name,
  2*ROUND((sysdate-hire_date)/7) weekends
FROM employees
WHERE hire_date BETWEEN '01-JUL-1998' AND '31-JUL-1998'
ORDER BY weekends DESC;
SELECT * FROM empvu113;
/*
McCain 1806
Vargas 1804
Gates  1804
*/
/*******************************************************************************
���� 2. ��������� ���������� ������ �� ( ����� �� )
*******************************************************************************/
/*
2.0. ��������� ��������� ����� �� � ������ ���������� ������������ ��� ������ new_db
*/
CREATE TABLE emp
  (
    emp_id NUMBER(10),
    emp_surname NVARCHAR2(20),
    emp_name NVARCHAR2(20),
    job_id       NUMBER(4),
    emp_hiredate DATE,
    emp_sal      NUMBER(7,2),
    emp_comm     NUMBER(7,2),
    dept_id      NUMBER(6)
  );
CREATE TABLE dept
  (
    dept_id NUMBER(6),
    dept_name NVARCHAR2(20),
    loc_id  NUMBER(6),
    mngr_id NUMBER(6)
  );
CREATE TABLE loc
  ( loc_id NUMBER(6), loc_name NVARCHAR2(20)
  );
CREATE TABLE job
  ( job_id NUMBER(4), job_name NVARCHAR2(20)
  );
CREATE TABLE mngr
  ( mngr_id NUMBER(6), emp_id NUMBER(6), dept_id NUMBER(6)
  );
CREATE TABLE purchase
  (
    purchase_id NUMBER(6),
    purchase_name NVARCHAR2(20),
    purchase_price NUMBER(7,2),
    mngr_id        NUMBER(6)
  );
CREATE TABLE sale
  (
    sale_id NUMBER(6),
    sale_name NVARCHAR2(20),
    sale_price NUMBER(7,2)
  );
CREATE TABLE emp_sale
  ( emp_id NUMBER(6), sale_id NUMBER(6)
  );
ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (emp_id);
ALTER TABLE dept ADD CONSTRAINT dept_pk PRIMARY KEY (dept_id);
ALTER TABLE loc ADD CONSTRAINT loc_pk PRIMARY KEY (loc_id);
ALTER TABLE job ADD CONSTRAINT job_pk PRIMARY KEY (job_id);
ALTER TABLE mngr ADD CONSTRAINT mngr_pk PRIMARY KEY (mngr_id);
ALTER TABLE purchase ADD CONSTRAINT purchase_pk PRIMARY KEY (purchase_id);
ALTER TABLE sale ADD CONSTRAINT sale_pk PRIMARY KEY (sale_id);
ALTER TABLE emp_sale ADD CONSTRAINT emp_sale_pk PRIMARY KEY (emp_id,sale_id);
ALTER TABLE dept ADD CONSTRAINT dept_loc_FK FOREIGN KEY (loc_id) REFERENCES loc(loc_id);
ALTER TABLE emp ADD CONSTRAINT emp_dept_FK FOREIGN KEY (dept_id) REFERENCES dept(dept_id);
ALTER TABLE emp_sale ADD CONSTRAINT emp_sale_pk PRIMARY KEY (emp_id,sale_id);
/*
2.1.  ���  ����  ������  �����  ��  �������  ����������  ������������������,
�������������� �������������� �������� ����� �������� �������,
�������� � ��������� ����
*/
CREATE sequence emp_id START WITH 1000 INCREMENT BY 1 NOCACHE;
CREATE sequence dept_id START WITH 10 INCREMENT BY 10 NOCACHE;
CREATE sequence loc_id START WITH 100 INCREMENT BY 100 NOCACHE;
CREATE sequence job_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE sequence mngr_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE sequence sale_id START WITH 10000 INCREMENT BY 1 NOCACHE;
CREATE sequence purchase_id START WITH 10000 INCREMENT BY 1 NOCACHE;
  /*
  2.2. ��� ������ ������� ����� �� ������� 2 ������� �� �������� ������ (������ ��� ������).
  */
  INSERT
  INTO loc VALUES
    (
      loc_id.NEXTVAL,
      'Roma'
    );
  INSERT INTO loc VALUES
    (loc_id.NEXTVAL, 'Odessa'
    );
  INSERT INTO dept VALUES
    (dept_id.NEXTVAL, 'Administration', 200, 1
    );
  INSERT INTO dept VALUES
    (dept_id.NEXTVAL, 'IT', 100, 2
    );
  INSERT
  INTO emp VALUES
    (
      emp_id.NEXTVAL,
      'Skazzi',
      'Radmila',
      10,
      sysdate,
      24000,
      0,10
    );
  INSERT
  INTO emp VALUES
    (
      emp_id.NEXTVAL,
      'Joz',
      'Alex',
      20,
      sysdate,
      24000,
      0,20
    );
  INSERT INTO job VALUES
    (job_id.NEXTVAL, 'Human Resources'
    );
  INSERT INTO job VALUES
    (job_id.NEXTVAL, 'Programmer'
    );
  INSERT INTO mngr VALUES
    (mngr_id.NEXTVAL, 1000,10
    );
  INSERT INTO mngr VALUES
    (mngr_id.NEXTVAL, 1001,20
    );
  INSERT INTO purchase VALUES
    (purchase_id.NEXTVAL, 'Katana',60,1
    );
  INSERT INTO purchase VALUES
    (purchase_id.NEXTVAL, 'Rasengan',50,2
    );
  INSERT INTO sale VALUES
    (sale_id.NEXTVAL, 'Shuriken',30
    );
  INSERT INTO sale VALUES
    (sale_id.NEXTVAL, 'Origami',40
    );
  /*
  2.3. ��������� ������� �� �������� ���� ��������� � ��.
  */
  COMMIT;
  /*
  2.4. ��� ����� �� ������, ���������� ����������� ����������� �������� �����,
  ��������� ������� �� ��������� �������� ������� �������� ����� �� ��������,
  ������������� � ������� ���������� ����� ��������������� �������.
  ��������� ������� ���� �� �������� ���������.
  */
  /*UPDATE emp SET dept_id = 100 WHERE dept_id = 10;
  /*
  SQL Error: ORA-02291: integrity constraint (SKAZZI.DEPT_LOC_FK) violated - parent key not found
  */
  /*
  2.5. ��� ����� �� ������, ���������� ����������� ����������� ���������� �����,
  ��������� ������� �� ��������� �������� ������� ���������� ����� �� ��������,
  ������������� � ������� �������� ����� ��������������� �������.
  ��������� ������� ���� �� �������� ���������.
  */
  /*UPDATE  dept  SET dept_id = 1000 WHERE dept_id = 10;
  /*
  SQL Error: ORA-02292: integrity constraint (SKAZZI.EMP_DEPT_FK) violated - child record found
  /*
  2.6. ��� ����� �� ������, ���������� ����������� ����������� ���������� �����,
  ��������� ����  �������  ��  ��������  ������  ��  ���������  �������
  ����������  �����,  ��������������  � ������� �������� ����� ��������������� �������.
  ��������� ������� ���� �� ���������.
  */
  /*DELETE FROM dept WHERE dept_id=20;
  /*
  SQL Error: ORA-02292: integrity constraint (SKAZZI.EMP_DEPT_FK) violated - child record found
  */
  /*
  2.7.  ���  �����  ��  ������  ��������  �����������  �����������  ��������  �����,
  �������������� ��������� ��������
  */
  ALTER TABLE dept
  DROP CONSTRAINT dept_loc_FK;
  ALTER TABLE dept ADD CONSTRAINT dept_loc_FK FOREIGN KEY(loc_id) REFERENCES loc(loc_id) ON
  DELETE CASCADE;
  ALTER TABLE emp
  DROP CONSTRAINT emp_dept_FK;
  ALTER TABLE emp ADD CONSTRAINT emp_dept_FK FOREIGN KEY (dept_id) REFERENCES dept(dept_id)ON
  DELETE CASCADE;
  DELETE FROM loc WHERE loc_id=200;
  /*1 row deleted.*/
  /*
  2.8. ��������� ������� �� ������ (������) �������� �������� �� ������ 2.6
  */
  ROLLBACK;
  /*******************************************************************************
  ���� 3. ������� �������� ��������� �� ( ������ �� )� ������ �� ��������� ���������
  ��������.
  *******************************************************************************/
  /*
  3.1.  ���������  ������������  ��  n%  ����  �����������,  �������
  ���������  ��  ��������� �Administration Assistant�, ��� n � ���������� ���,
  ������� ����������� ����������.
  */
  UPDATE employees
  SET commission_pct = 0.01*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)*commission_pct+commission_pct
  WHERE job_id            IN
    (SELECT job_id
    FROM employees
    JOIN jobs USING (job_id)
    WHERE jobs.job_title LIKE 'Administration Assistant'
    );
  /*1 row updated.*/
  /*
  3.2. ������� ���� ����������� (������� �� �������), ������� ����������� ����� 20 ��� �� ��������� Shipping Clerk.
  ����� ��������� ��������� ���������� �� �����������  ����������� � ��������� ������� employee_drop,
  ������� �������� ����� �� ���������, ��� � ������� employee.  ��� �������� �������
  ������������ ����������� ���� CREATE TABLE ... AS SELECT ...
  ��������� �������� ������������� ������� ������� � �������� �� ���������� �� ������ �� ������.
  ������� ���������� � ���������� � ������� �������� � ���� ��������� ����������.
  */
  COMMIT;
  SET TRANSACTION NAME 'EMPLOYEE_DROP';
  CREATE TABLE employee_drop AS
    (SELECT *
      FROM employees
      JOIN jobs USING(job_id)
      WHERE jobs.job_title LIKE 'Shipping Clerk'
      AND ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)>=20
    );
  DELETE
  FROM
    (SELECT *
    FROM employees
    JOIN jobs USING(job_id)
    WHERE jobs.job_title LIKE 'Shipping Clerk'
    AND ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)>=20
    );
  COMMIT;
  /*
  Transaction set.
  Table created.
  2 rows deleted.
  Commit complete.
  */
  /*******************************************************************************
  ���� 4. ������� ������ � �������������� � ����������� �� ������ �� � ����� ��
  *******************************************************************************/
  /*
  ��� ����, ����� ��������� ������, ����������� � c����� ��, ���������� ���������
  ������� ������ �� ������ ������ �� � ������� ����� ��.  ���� ��� �������� � �������
  ����� ������ �������� �������������� ��������, �� ���������� �������� ��� ��������
  �� ��������"��������� � ������ ��������� ��������. ������������ ��������� �������
  �������� �� ��������: INSERT INTO NEW_DB.�������_�����_�� (������� ����� ��)
  SELECT .... FROM OLD_DB.�������_������_�� ...; ���������� ������ ��������� ����
  ������� � �������� ������ ��, ��������� �������:
  GRANT SELECT ON OLD_DB.�������_������_��TONEW_DB;
  ��� �������� �������� � ���� ����� ����������.
  */
  GRANT
  SELECT ON OLD_DB.employees TO NEW_DB;
  
  COMMIT;
  SET TRANSACTION NAME 'COPY FROM OLD_DB';
  
  INSERT
  INTO new_db.emp
    (
      emp_id,
      emp_surname,
      emp_name,
      job_id,
      emp_hiredate,
      emp_sal,
      emp_comm,
      dept_id
    )
  SELECT EMPLOYEE_ID,
    LAST_NAME,
    FIRST_NAME,
    JOB_ID,
    HIRE_DATE,
    SALARY,
    COMMISSION_PCT,
    DEPARTMENT_ID
  FROM old_db.employees;
COMMIT;