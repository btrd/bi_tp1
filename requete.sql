/* Exo 1 */

/* A. */
SELECT EMP.DEPTNO, ENAME, SAL, RANK () OVER (PARTITION BY EMP.DEPTNO ORDER BY SAL DESC) "Rank" FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO WHERE EMP.DEPTNO = 10 OR EMP.DEPTNO = 30 ORDER BY EMP.DEPTNO, EMP.SAL DESC;

/* B. */
SELECT EMP.DEPTNO, ENAME, SAL, Dense_RANK () OVER (PARTITION BY EMP.DEPTNO ORDER BY SAL DESC) "Rank" FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO WHERE EMP.DEPTNO = 10 OR EMP.DEPTNO = 30 ORDER BY EMP.DEPTNO, EMP.SAL DESC;

/* C. */
SELECT DISTINCT EMP.DEPTNO, SAL, Dense_RANK () OVER (PARTITION BY EMP.DEPTNO ORDER BY SAL DESC) "Rank" FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO WHERE EMP.DEPTNO = 10 OR EMP.DEPTNO = 20 ORDER BY EMP.DEPTNO, EMP.SAL DESC;

/* D. */
SELECT EMP.JOB, SUM(EMP.SAL) AS "TOT_SAL_JOB" FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO GROUP BY EMP.JOB;
SELECT
  DISTINCT EMP.JOB, SUM(EMP.SAL) OVER(PARTITION BY EMP.JOB) AS "TOT_SAL_JOB"
FROM EMP
INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

/* E. */
PARTITION BY est un agrégat et GROUP BY est un regroupement

/* F. */
SELECT EMP.DEPTNO, EMP.JOB, SUM(EMP.SAL) AS "SUM_SAL" FROM EMP GROUP BY ROLLUP(EMP.DEPTNO, EMP.JOB) ORDER BY EMP.DEPTNO, EMP.JOB, SUM_SAL DESC;

/* G. */
SELECT
 DECODE(EMP.DEPTNO, NULL, 'TousDepartement', EMP.DEPTNO) AS "DEPTNO",
 DECODE(EMP.JOB, NULL, 'TousEmployes', EMP.JOB) AS "JOB",
 SUM(EMP.SAL) AS "SUM_SAL"
 FROM EMP
 GROUP BY ROLLUP(EMP.DEPTNO, EMP.JOB)
 ORDER BY EMP.DEPTNO, EMP.JOB, SUM_SAL;
SELECT
 NVL(TO_CHAR(EMP.DEPTNO), 'TousDepartement') AS "DEPTNO",
 NVL(EMP.JOB, 'TousEmployes') AS "JOB",
 SUM(EMP.SAL) AS "SUM_SAL"
 FROM EMP
 GROUP BY ROLLUP(EMP.DEPTNO, EMP.JOB)
 ORDER BY EMP.DEPTNO, EMP.JOB, SUM_SAL;

/* Exo 2 */
/* 1 */
SELECT temps.annee, clients.cl_r, produits.category, avg(ventes.pu*ventes.qte) AS "ca"
FROM ventes
INNER JOIN clients ON clients.cl_id = ventes.cid
INNER JOIN produits ON produits.pid = ventes.pid
INNER JOIN temps ON temps.tid = ventes.tid
WHERE temps.annee IN (2009, 2010)
GROUP BY ROLLUP(temps.annee, clients.cl_r, produits.category)
ORDER BY temps.annee, clients.cl_r, produits.category;

/* 2 */
SELECT temps.annee, clients.cl_r, produits.category, avg(ventes.pu*ventes.qte) AS "ca"
FROM ventes
INNER JOIN clients ON clients.cl_id = ventes.cid
INNER JOIN produits ON produits.pid = ventes.pid
INNER JOIN temps ON temps.tid = ventes.tid
WHERE temps.annee IN (2009, 2010)
GROUP BY CUBE(temps.annee, clients.cl_r, produits.category)
ORDER BY temps.annee, clients.cl_r, produits.category;

/* 3 */
SELECT temps.annee, produits.category, produits.pname,
RANK() OVER (PARTITION BY temps.annee, produits.category ORDER BY (SELECT sum(qte) from ventes) DESC)
FROM ventes
INNER JOIN clients ON clients.cl_id = ventes.cid
INNER JOIN produits ON produits.pid = ventes.pid
INNER JOIN temps ON temps.tid = ventes.tid
GROUP BY temps.annee, produits.category, produits.pname, ventes.qte;

/* 4 */
SELECT temps.annee, produits.category, SUM(ventes.pu*ventes.qte) AS "ca"
FROM ventes
INNER JOIN clients ON clients.cl_id = ventes.cid
INNER JOIN produits ON produits.pid = ventes.pid
INNER JOIN temps ON temps.tid = ventes.tid
GROUP BY temps.annee, ROLLUP(produits.category);

/* 5 */
SELECT
temps.annee, temps.mois, SUM(ventes.pu*ventes.qte) AS "ca", RANK () OVER (ORDER BY ca DESC) "Rank"
FROM ventes
INNER JOIN produits ON produits.pid = ventes.pid
INNER JOIN temps ON temps.tid = ventes.tid
WHERE produits.pid = 61
GROUP BY  ROLLUP(temps.annee, temps.mois);
