DROP TABLE emp_sale CASCADE CONSTRAINTS;
DROP TABLE sale CASCADE CONSTRAINTS;
DROP TABLE purchase CASCADE CONSTRAINTS;
DROP TABLE mngr CASCADE CONSTRAINTS;
DROP TABLE job CASCADE CONSTRAINTS;
DROP TABLE loc CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;

CREATE TABLE emp (
	emp_id NUMBER(10),
	emp_surname NVARCHAR2(20),
	emp_name NVARCHAR2(20),
	job_id NUMBER(4),
	emp_hiredate DATE,
	emp_sal NUMBER(7,2),
	emp_comm NUMBER(7,2),
	dept_id NUMBER(6)
);

CREATE TABLE dept(
	dept_id NUMBER(6),
	dept_name NVARCHAR2(20),
	loc_id NUMBER(6),
	mngr_id	NUMBER(6)
);

CREATE TABLE loc(
	loc_id NUMBER(6),
	loc_name NVARCHAR2(20)
);

CREATE TABLE job(
	job_id NUMBER(4),
	job_name NVARCHAR2(20)
);

CREATE TABLE mngr(
	mngr_id NUMBER(6),
	emp_id NUMBER(6),
	dept_id NUMBER(6)
);

CREATE TABLE purchase(
	purchase_id NUMBER(6),
	purchase_name NVARCHAR2(20),
	purchase_price NUMBER(7,2),
	mngr_id NUMBER(6)
);

CREATE TABLE sale(
	sale_id NUMBER(6),
	sale_name NVARCHAR2(20),
	sale_price NUMBER(7,2)
);


CREATE TABLE emp_sale(
	emp_id NUMBER(6),
	sale_id NUMBER(6)
);

commit;

ALTER TABLE emp add CONSTRAINT emp_pk
	PRIMARY KEY (emp_id);
ALTER TABLE dept add CONSTRAINT dept_pk
	PRIMARY KEY (dept_id);
ALTER TABLE loc add CONSTRAINT loc_pk
	PRIMARY KEY (loc_id);
ALTER TABLE job add CONSTRAINT job_pk
	PRIMARY KEY (job_id);
ALTER TABLE mngr add CONSTRAINT mngr_pk
	PRIMARY KEY (mngr_id);
ALTER TABLE purchase add CONSTRAINT purchase_pk
	PRIMARY KEY (purchase_id);
ALTER TABLE sale add CONSTRAINT sale_pk
	PRIMARY KEY (sale_id);
ALTER TABLE emp_sale add CONSTRAINT emp_sale_pk
	PRIMARY KEY (emp_id,sale_id);


ALTER TABLE emp add CONSTRAINT emp_job_FK
	FOREIGN KEY (job_id) REFERENCES job(job_id);
ALTER TABLE emp add CONSTRAINT emp_dept_FK
	FOREIGN KEY (dept_id) REFERENCES dept(dept_id);

ALTER TABLE dept add CONSTRAINT dept_loc_FK
	FOREIGN KEY (loc_id) REFERENCES loc(loc_id);
ALTER TABLE dept add CONSTRAINT dept_mngr_FK
	FOREIGN KEY (mngr_id) REFERENCES mngr(mngr_id);


ALTER TABLE mngr add CONSTRAINT mngr_dept_FK
	FOREIGN KEY (dept_id) REFERENCES dept(dept_id);

ALTER TABLE purchase add CONSTRAINT purchase_mngr_FK
	FOREIGN KEY (mngr_id) REFERENCES mngr(mngr_id);



ALTER TABLE emp_sale add CONSTRAINT emp_sale_emp_FK
	FOREIGN KEY (emp_id) REFERENCES emp(emp_id);
ALTER TABLE emp_sale add CONSTRAINT emp_sale_sale_FK
	FOREIGN KEY (sale_id) REFERENCES sale(sale_id);



ALTER TABLE emp add CONSTRAINT emp_surname_not_null
	CHECK (trim(emp_surname) IS NOT NULL);
ALTER TABLE emp add CONSTRAINT emp_name_not_null
	CHECK (trim(emp_name) IS NOT NULL);
ALTER TABLE emp add CONSTRAINT emp_hiredate_not_null
	CHECK (trim(emp_hiredate) IS NOT NULL);


ALTER TABLE dept add CONSTRAINT dept_name_not_null
	CHECK (trim(dept_name) IS NOT NULL);

ALTER TABLE loc add CONSTRAINT loc_name_not_null
	CHECK (trim(loc_name) IS NOT NULL);

ALTER TABLE job add CONSTRAINT job_name_not_null
	CHECK (trim(job_name) IS NOT NULL);

ALTER TABLE purchase add CONSTRAINT purchase_name_not_null
	CHECK (trim(purchase_name) IS NOT NULL);
	

ALTER TABLE sale add CONSTRAINT sale_name_not_null
	CHECK (trim(sale_name) IS NOT NULL);	


ALTER TABLE emp MODIFY (emp_name NOT NULL);
ALTER TABLE emp MODIFY (emp_surname NOT NULL);
ALTER TABLE emp MODIFY (job_id NOT NULL);
ALTER TABLE emp MODIFY (emp_hiredate NOT NULL);
ALTER TABLE emp ADD CONSTRAINT emp_pot_key UNIQUE (emp_name, emp_surname, job_id, emp_hiredate); 