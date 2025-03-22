#1. Liste des entrepôts et leurs niveaux de stock
SELECT warehouseCode, stock, totalSales, (totalSales / (totalSales + stock)) as percent
FROM (SELECT 
    w.warehouseCode, 
    SUM(p.quantityInStock) AS stock,
    COALESCE(SUM(od.totalSales), 0) AS totalSales
FROM mintclassics.warehouses w
LEFT JOIN mintclassics.products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN (
    SELECT productCode, SUM(quantityOrdered) AS totalSales
    FROM mintclassics.orderdetails
    GROUP BY productCode
) od ON p.productCode = od.productCode
GROUP BY w.warehouseCode) as B
ORDER BY percent desc;

#2. Les types de produits dans les entrepôts
SELECT w.warehouseCode, w.warehouseName, 
       p.productLine
FROM mintclassics.warehouses w
JOIN mintclassics.products p ON w.warehouseCode = p.warehouseCode
GROUP BY p.productLine, w.warehouseCode, w.warehouseName;


#3. Les produits et leur entrepôt actuel
SELECT p.productCode, p.productName, w.warehouseName, p.quantityInStock
FROM mintclassics.products p
JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY w.warehouseName, p.quantityInStock DESC;


#4. Les délais de livraison moyens des commandes expédiées depuis chaque entrepôt
SELECT w.warehouseCode, w.warehouseName, AVG(DATEDIFF(o.shippedDate, o.orderDate)) AS avgShippingTime
FROM mintclassics.orders o
JOIN mintclassics.orderdetails od ON o.orderNumber = od.orderNumber
JOIN mintclassics.products p ON od.productCode = p.productCode
JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName;


#5. Produits en surstocks
SELECT 	
		p.productCode, 
		p.productName, 
		p.quantityInStock, 
		p.warehouseCode,
		COALESCE(SUM(od.quantityOrdered), 0) AS totalSales
		FROM mintclassics.products p
		LEFT JOIN mintclassics.orderdetails od ON p.productCode = od.productCode
		LEFT JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
		GROUP BY p.productCode, p.productName, p.quantityInStock, p.warehouseCode
		HAVING p.quantityInStock > 2 * COALESCE(SUM(od.quantityOrdered), 1) 
		ORDER BY COALESCE(SUM(od.quantityOrdered), 0);


#6. Type produits en surstocks 
SELECT warehouseCode, count(productCode), productLine
FROM (
        SELECT 
		p.productCode, 
		p.productName, 
		p.quantityInStock, 
		p.warehouseCode,
        p.productLine,
		COALESCE(SUM(od.quantityOrdered), 0) AS totalSales
		FROM mintclassics.products p
		LEFT JOIN mintclassics.orderdetails od ON p.productCode = od.productCode
		LEFT JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
		GROUP BY p.productCode, p.productName, p.quantityInStock, p.warehouseCode, p.productLine
		HAVING p.quantityInStock > 2 * COALESCE(SUM(od.quantityOrdered), 1) 
		ORDER BY COALESCE(SUM(od.quantityOrdered), 0)) as D
GROUP BY warehouseCode, productLine;


#7. Produits en sous stocks
SELECT 
    p.productCode, 
    p.productName, 
    p.quantityInStock, 
    p.warehouseCode,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSales
FROM mintclassics.products p
LEFT JOIN mintclassics.orderdetails od ON p.productCode = od.productCode
LEFT JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY p.productCode, p.productName, p.quantityInStock, p.warehouseCode
HAVING p.quantityInStock < 2 * COALESCE(SUM(od.quantityOrdered), 1) 
ORDER BY p.quantityInStock;


#8. Type produits en soustocks
SELECT warehouseCode, count(productCode), productLine
FROM (SELECT 
    p.productCode, 
    p.productName, 
    p.quantityInStock, 
    p.warehouseCode,
    p.productLine,
    COALESCE(SUM(od.quantityOrdered), 0) AS totalSales
FROM mintclassics.products p
LEFT JOIN mintclassics.orderdetails od ON p.productCode = od.productCode
LEFT JOIN mintclassics.warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY p.productCode, p.productName, p.quantityInStock, p.warehouseCode, p.productLine
HAVING p.quantityInStock < 2 * COALESCE(SUM(od.quantityOrdered), 1) 
ORDER BY p.quantityInStock) as D
GROUP BY warehouseCode, productLine;


# 9. Evolution des stock au fil des mois
WITH ventes AS (
    SELECT 
        od.productCode, 
        DATE_FORMAT(o.orderDate, '%Y-%m') AS mois, 
        SUM(od.quantityOrdered) AS total_vendu
    FROM mintclassics.orderdetails od
    JOIN mintclassics.orders o ON od.orderNumber = o.orderNumber
    GROUP BY od.productCode, mois
),
cumul_ventes AS (
    SELECT 
        v.productCode, 
        v.mois, 
        SUM(v.total_vendu) OVER (PARTITION BY v.productCode ORDER BY v.mois) AS ventes_cumulees
    FROM ventes v
),
stock_initial AS (
    SELECT 
        p.productCode, 
        p.productName, 
        (p.quantityInStock + COALESCE(SUM(od.quantityOrdered), 0)) AS stock_initial
    FROM mintclassics.products p
    LEFT JOIN mintclassics.orderdetails od ON p.productCode = od.productCode
    LEFT JOIN mintclassics.orders o ON od.orderNumber = o.orderNumber
    WHERE o.orderDate BETWEEN '2003-01-01' AND '2005-05-31'
    GROUP BY p.productCode, p.productName, p.quantityInStock
)
SELECT 
    si.productCode, 
    si.productName, 
    c.mois, 
    (si.stock_initial - COALESCE(c.ventes_cumulees, 0)) AS stock_restant
FROM stock_initial si
LEFT JOIN cumul_ventes c ON si.productCode = c.productCode
ORDER BY si.productCode, c.mois;
