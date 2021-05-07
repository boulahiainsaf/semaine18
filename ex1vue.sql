--Afficher la liste des hôtels avec leur station.

CREATE VIEW hotel_station
AS
SELECT hot_id,hot_nom,sta_nom FROM nom_table
JOIN station
ON hot_sta_id=sta_id;

--Afficher la liste des chambres et leur hôtel

CREATE VIEW chambre_hotel
AS
SELECT cha_numero,hot_nom FROM chambre
JOIN hotel
ON cha_hot_id = hot_id

--Afficher la liste des réservations avec le nom des clients
CREATE VIEW réservation_clients
AS
SELECT* FROM reservation
JOIN client
ON res_cli_id = cli_id

--Afficher la liste des chambres avec le nom de l'hôtel et le nom de la station


CREATE VIEW chambre_hotel_station
AS 
SELECT cha_numero,hot_nom,sta_nom FROM chambre
JOIN hotel
ON cha_hot_id = hot_id
JOIN station
ON hot_sta_id=sta_id;

--Afficher les réservations avec le nom du client et le nom de l'hôtel

CREATE VIEW v_reservation_client_hotel
AS
SELECT res_id,res_date,concat(cli_nom,' ',cli_prenom),hot_nom FROM reservation
JOIN client
ON res_cli_id = cli_id
JOIN chambre
ON res_cha_id=cha_id
JOIN hotel
ON cha_hot_id=hot_id