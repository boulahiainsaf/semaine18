--trigger(ajouter un produit)
DELIMITER |
CREATE TRIGGER maj_totall 
AFTER INSERT ON lignedecommande
FOR EACH ROW
BEGIN
    DECLARE id_c INT;
    DECLARE tot DOUBLE;
    SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
    SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
    UPDATE commande SET total=tot WHERE id=id_c; -- on stock le total dans la table commande

END|

DELIMITER ;
-- trigger suppremer un produit

DELIMITER |
CREATE TRIGGER delet_maj_totall 
AFTER DELETE ON lignedecommande
FOR EACH ROW
BEGIN
    DECLARE id_c INT;
    DECLARE tot DOUBLE;
    DECLARE verf decimal;
    SET id_c = old.id_commande; -- nous captons le numéro de commande concerné
    SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
    set verf = (select total from commande WHERE id =id_c);
    if verf=0 
    THEN
    update commande set total = tot-(tot*remise/100) where id=id_c;
    ELSE
      UPDATE commande SET total=total-tot-((total-tot)*remise/100) WHERE id=id_c; -- on stock le total dans la table commande  
    END IF;
END|
DELIMITER ;
DELETE FROM lignedecommande where id_commande=2 and id_produit=1;

-- trigger modifier un produit

DELIMITER |
CREATE TRIGGER update_maj_totall1 
AFTER UPDATE ON lignedecommande
FOR EACH ROW
BEGIN
    DECLARE id_c INT;
    DECLARE tot DOUBLE;
    SET id_c = old.id_commande; -- nous captons le numéro de commande concerné
    SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
    UPDATE commande SET total=tot-(tot*remise/100) WHERE id=id_c; 

END|
DELIMITER ;
