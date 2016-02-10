
CREATE TABLE TEMPS (TID Numeric(4), annee Numeric(4), trimestre Numeric(2),mois Numeric(2), jour Numeric(2));

CREATE TABLE CLIENTS (CL_ID Numeric(2),CL_NAME varchar(50), CL_CITY varchar(30), CL_R varchar(30), CL_STATE varchar(30));

CREATE TABLE PRODUITS (PID Numeric(2), PNAME varchar(50), CATEGORY varchar(40),SUBCAT varchar(30));

CREATE TABLE VENTES (TID Numeric(4),PID Numeric(2),CID Numeric(2),QTE Numeric(3), PU Numeric(6,2));
