
-- Ex1 : Créez la procédure stockée Lst_Suppliers correspondant à la requête afficher le nom des fournisseurs pour lesquels une commande a été passée.

DELIMITER |

CREATE PROCEDURE Lst_Suppliers ()
BEGIN
SELECT sup_name,sup_id FROM suppliers
JOIN products
ON suppliers.sup_id=products.pro_sup_id
JOIN orders_details
ON products.pro_id=orders_details.ode_pro_id
WHERE pro_id in (SELECT ode_pro_id from orders_details )
group by sup_name;
END |

DELIMITER ;

CALL Lst_Suppliers
--Ex2 : Créer la procédure stockée Lst_Rush_Orders, qui liste les commandes ayant le libelle "commande urgente".

DELIMITER |

CREATE PROCEDURE Lst_Rush_Orders (IN p_ord varchar(25))
BEGIN
SELECT * FROM orders
WHERE ord_status = p_ord;
END |

DELIMITER ;
 
 CALL Lst_Rush_Orders('commande urgente');


--3Créer la procédure stockée CA_Supplier, qui pour un code fournisseur et une année entrée en paramètre, calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée.

DELIMITER $$

CREATE PROCEDURE CA_Supplier (in p_four int,IN p_annee INT)
BEGIN
IF p_four in (SELECT sup_id FROM suppliers)
THEN
select sup_id,sum((ode_unit_price-(ode_unit_price*ode_discount/100))*ode_quantity) as chiffre_aff FROM suppliers

JOIN products
ON suppliers.sup_id=products.pro_sup_id
JOIN orders_details
ON products.pro_id=orders_details.ode_pro_id
JOIN orders
on orders_details.ode_ord_id=orders.ord_id
WHERE YEAR(ord_order_date)=p_annee and sup_id=p_four;
   
ELSE 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le fournisseur  n'existe pas ";
END IF;
END $$

DELIMITER ;
 CALL CA_Supplier(1,2012);






























from suppliers,countries,customers,orders
WHERE suppliers.sup_countries_id=countries.coi_id and countries.cou_id=customers.cus_countries_id and customers.cus_id=orders.ord_cus_id and 