--v_Details correspondant à la requête : _A partir de la table orders_details, afficher par code produit, la somme des quantités commandées et le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot.


CREATE VIEW v_Details 
AS
SELECT pro_ref,round(sum((ode_unit_price-(ode_unit_price*ode_discount/100))*ode_quantity),2) as 'PrixTot',sum(ode_quantity) as 'QteTot' FROM orders_details
JOIN products
ON ode_pro_id= pro_id
GROUP BY pro_ref;


--v_Ventes_Zoom correspondant à la requête : Afficher les ventes dont le code produit est ZOOM (affichage de toutes les colonnes de la table orders_details).

CREATE VIEW v_Ventes_Zoom
AS
SELECT * FROM orders_details
JOIN products
ON  ode_pro_id=pro_id
WHERE pro_ref = "ZOOM";

