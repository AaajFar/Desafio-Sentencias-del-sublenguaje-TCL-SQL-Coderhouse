-- Creacion de Schema

DROP SCHEMA IF EXISTS fabrica_guitarras;

CREATE SCHEMA IF NOT EXISTS fabrica_guitarras;

USE fabrica_guitarras;

-- Creacion de tablas

CREATE TABLE IF NOT EXISTS proveedores
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS materiales
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('clavijas', 'microfonos', 'maderas', 'cuerdas') NOT NULL,
marca VARCHAR(60) DEFAULT NULL,
modelo VARCHAR(60) NOT NULL,
descripcion VARCHAR(100),
stock INT NOT NULL,
costo FLOAT NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS proveedores_materiales
(
mat_id INT NOT NULL,
prov_id INT NOT NULL,
PRIMARY KEY(mat_id, prov_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (prov_id) REFERENCES fabrica_guitarras.proveedores(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS guitarras
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('electrica', 'clasica', 'electroacustica', 'clasica nino', 'clasica concierto') NOT NULL,
modelo VARCHAR(60) NOT NULL,
ano YEAR NOT NULL,
stock INT NOT NULL,
precio FLOAT
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS materiales_guitarras
(
mat_id INT NOT NULL,
guit_id INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (mat_id, guit_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (guit_id) REFERENCES fabrica_guitarras.guitarras(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS clientes
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
direccion VARCHAR(200) DEFAULT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS direcciones_envio
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
localidad VARCHAR(60) NOT NULL,
provincia VARCHAR(30) NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS fabrica_guitarras.pedidos
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
guit INT NOT NULL,
cantidad INT NOT NULL,
precio FLOAT,
fecha DATE NOT NULL,
dir_envio INT NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id) ON UPDATE CASCADE,
FOREIGN KEY (guit) REFERENCES fabrica_guitarras.guitarras(id) ON UPDATE CASCADE,
FOREIGN KEY (dir_envio) REFERENCES fabrica_guitarras.direcciones_envio(id) ON UPDATE CASCADE
) ENGINE=INNODB;


-- Creacion de tablas de movimientos, logs, bitacoras.

CREATE TABLE IF NOT EXISTS movimientos_pedidos
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_ped INT NOT NULL,
cliente_precio VARCHAR(350) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS movimientos_materiales
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_mat INT NOT NULL,
tipo_mat ENUM('maderas', 'microfonos', 'clavijas', 'cuerdas') NOT NULL,
costo_mat INT NOT NULL,
costo_viejo INT,
costo_dif VARCHAR(10),
detalle VARCHAR(30)
);



-- Insercion de datos

USE fabrica_guitarras;

INSERT INTO proveedores VALUES
(NULL, 'Music Shop', 'Guatemala 2044, CABA', '48722685', 'musicshop@gmail.com'),
(NULL, 'Fender Accesorios', 'Solis 3052, CABA', '49552828', 'fenderacc@gmail.com'),
(NULL, 'Gibson Music', 'Av Nazca 3155, CABA', '45883371', 'gibsonint@gmail.com'),
(NULL, 'Yamaha Accesorios', 'Callao 1233, CABA', '46418892', 'yamahaarg@gmail.com'),
(NULL, 'Gotoh International', 'Lavalle 4882, CABA', '49123355', 'gotohinternacional@gmail.com'),
(NULL, 'Maderas del sur', 'Hipolito Irigoyen 2255, Lanus GBA', '47229822', 'maderasdelsur@info.com.ar'),
(NULL, 'Gutierrez Maderas', 'Av J B Alberdi 5244, CABA', '43228789', DEFAULT),
(NULL, 'Maderera Tres Hermanos', 'Av Alvarez Jonte 2573, CABA', '45838877', 'treshermanosmaderera@hotmail.com'),
(NULL, 'Maderera El Carpintero', 'Av San Martin 2188, CABA', '49928633', DEFAULT),
(NULL, 'Devoto Maderas', 'Av Francisco Beiro 4122, CABA', '46228899', 'devotomaderas@gmail.com');

INSERT INTO materiales VALUES
(NULL, 'clavijas', 'MXP', 'MX218 A', 'Set x6 para clasica', '300', '1000'),
(NULL, 'clavijas', 'Shimura', '214n', 'Set x6 para clasica', '200','1200'),
(NULL, 'clavijas', 'Shimura', '218A', 'Set x6 para clasica', '170','1300'),
(NULL, 'clavijas', 'Fender', '099-0818-000', 'Set x6 para electrica', '300','2000'),
(NULL, 'clavijas', 'Fender', '0990820100', 'Set x6 para electrica', '285','2500'),
(NULL, 'clavijas', 'Gibson', 'PMMH-025 GOLD', 'Set x6 para electrica', '120','2000'),
(NULL, 'clavijas', 'Gibson', 'PMMH-030 BLACK', 'Set x6 para electrica', '150','2500'),
(NULL, 'clavijas', 'Yamaha', 'TM 30', 'Set x6 para electrica o acustica', '400','1500'),
(NULL, 'clavijas', 'Gotoh', '1503b-z', 'Set x6 para electrica', '235','2000'),
(NULL, 'clavijas', 'Gotoh', '1502c', 'Set x6 para electrica', '345','2500'),
(NULL, 'clavijas', 'Gotoh', '1513c', 'Set x6 para electrica', '120','3000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '200','4000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '145','4500'),
(NULL, 'microfonos', 'Fender', 'Tex Mex', 'Set x3 para electrica', '280','5000'),
(NULL, 'microfonos', 'Fender', 'Vintage Noiseless', 'Set x3 para electrica', '150','6000'),
(NULL, 'microfonos', 'Dimarzio', 'Rainmaker Dreamcatcher', 'Set x2 para electrica', '320','5500'),
(NULL, 'microfonos', 'Dimarzio', 'DP227 DP228', 'Set x2 para electrica', '252','5500'),
(NULL, 'microfonos', 'Fishman', 'Blend 301', 'Para guitarra acustica', '520','2000'),
(NULL, 'microfonos', 'Cherub', 'GS3', 'Para guitarra acustica', '100','2500'),
(NULL, 'microfonos', 'Dimarzio', 'Dp136', 'Para guitarra acustica', '80','3500'),
(NULL, 'cuerdas', 'D addario', 'ez900', 'Set x6 para acustica .010', '200','1000'),
(NULL, 'cuerdas', 'Ernie Ball', 'Super Slinky', 'Set x6 para electrica .009', '155','1200'),
(NULL, 'cuerdas', 'Fender', '150R', 'Set x6 para electrica .010', '322','1100'),
(NULL, 'cuerdas', 'Fender', '150L', 'Set x6 para electrica .009', '255','1200'),
(NULL, 'cuerdas', 'Gibson', 'sag-mb11', 'Set x6 para acustica .011', '120','1250'),
(NULL, 'cuerdas', 'Gibson', 'seg-700l', 'Set x6 para electrica .010', '522','1350'),
(NULL, 'cuerdas', 'D addario', 'EJ-30', 'Set x6 para clasica', '800','1000'),
(NULL, 'cuerdas', 'Cantata', '630', 'Set x6 para clasica', '677','800'),
(NULL, 'maderas', NULL, 'Alamo', 'Para guitarra electrica', '200','2000'),
(NULL, 'maderas', NULL, 'Ebano', 'Para guitarra electrica', '150','3000'),
(NULL, 'maderas', NULL, 'Pino Abeto', 'Para guitarra clasica', '100','1500'),
(NULL, 'maderas', NULL, 'Cedro Español', 'Para guitarra clasica', '250','4000'),
(NULL, 'maderas', NULL, 'Caoba', 'Para guitarra clasica', '92','5000'),
(NULL, 'maderas', NULL, 'Palorosa', 'Para guitarra electrica', '177','5000'),
(NULL, 'maderas', NULL, 'Arce', 'Para guitarra clasica', '389','4500'),
(NULL, 'maderas', NULL, 'Fresno', 'Para guitarra acustica', '155','3500'),
(NULL, 'maderas', NULL, 'Wengue', 'Para guitarra acustica', '255','5000');

INSERT INTO proveedores_materiales VALUES
('1','1'),
('2','1'),
('3','1'),
('4','2'),
('5','2'),
('6','3'),
('7','3'),
('8','4'),
('9','5'),
('10','5'),
('11','5'),
('12','1'),
('13','1'),
('14','2'),
('15','2'),
('16','1'),
('17','1'),
('18','3'),
('19','2'),
('20','1'),
('21','1'),
('22','1'),
('23','2'),
('24','2'),
('25','3'),
('26','3'),
('27','1'),
('28','5'),
('29','6'),
('30','8'),
('31','7'),
('32','10'),
('33','8'),
('34','9'),
('35','7'),
('36','8'),
('37','10');

INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Electrica','Stratocaster','2020','120'),
(NULL,'Electrica','Stratocaster','2021','300'),
(NULL,'Electrica','Les Paul','2019','155'),
(NULL,'Electrica','335','2020','250'),
(NULL,'Electrica','Stratocaster','2018','88'),
(NULL,'Electrica','Stratocaster','2019','120'),
(NULL,'Electroacustica','345','2020','300'),
(NULL,'Electroacustica','CD80','2019','192'),
(NULL,'Electroacustica','CE400','2021','400'),
(NULL,'Electroacustica','CD90','2021','250'),
(NULL,'Clasica','C40','2020','250'),
(NULL,'Clasica','C50','2020','208'),
(NULL,'Clasica','C60','2021','365'),
(NULL,'Clasica','M5','2020','112'),
(NULL,'Clasica','M6','2019','55'),
(NULL,'Clasica','C60LR','2022','488'),
(NULL,'Clasica Nino','C40M','2020','452'),
(NULL,'Clasica Nino','C50M','2020','266'),
(NULL,'Clasica Concierto','C100','2016','40'),
(NULL,'Clasica Concierto','C102','2018','62');

INSERT INTO materiales_guitarras VALUES
('4','1','1'),
('12','1','1'),
('24','1','1'),
('29','1','1'),
('5','2','1'),
('13','2','1'),
('23','2','1'),
('29','2','1'),
('6','3','1'),
('17','3','1'),
('26','3','1'),
('30','3','1'),
('7','4','1'),
('16','4','1'),
('26','4','1'),
('30','4','1'),
('9','5','1'),
('14','5','1'),
('22','5','1'),
('34','5','1'),
('11','6','1'),
('15','6','1'),
('22','6','1'),
('34','6','1'),
('8','7','1'),
('18','7','1'),
('21','7','1'),
('36','7','1'),
('8','8','1'),
('19','8','1'),
('25','8','1'),
('36','8','1'),
('8','9','1'),
('18','9','1'),
('21','9','1'),
('36','9','1'),
('8','10','1'),
('20','10','1'),
('25','10','1'),
('37','10','1'),
('1','11','1'),
('28','11','1'),
('31','11','1'),
('1','12','1'),
('28','12','1'),
('31','12','1'),
('1','13','1'),
('28','13','1'),
('35','13','1'),
('2','14','1'),
('27','14','1'),
('32','14','1'),
('3','15','1'),
('27','15','1'),
('33','15','1'),
('3','16','1'),
('28','16','1'),
('35','16','1'),
('1','17','1'),
('28','17','1'),
('31','17','1'),
('2','18','1'),
('28','18','1'),
('31','18','1'),
('3','19','1'),
('21','19','1'),
('35','19','1'),
('3','20','1'),
('21','20','1'),
('33','20','1');

/* Funcion Extra #1: Sirve para calcular el precio de venta de una guitarra mediante el id de la misma, suma todos 
los costos de los materiales y lo multiplica por 1,7 dando el precio final para la venta,
la utilizo para popular los datos por primera vez e ingresar todos los precios de las guitarras juntos.*/

DELIMITER $$
CREATE FUNCTION `fx_calc_prvt_guit`(id INT) 
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE resultado FLOAT;
    SET resultado = (SELECT SUM(mat.costo)
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id) * 1.7;
RETURN resultado;
END
$$
DELIMITER ;

-- Insercion de precios de venta de guitarras con la Funcion Extra #1 creada

DELIMITER //
UPDATE guitarras
SET precio = fx_calc_prvt_guit(id);
//
DELIMITER ; 

INSERT INTO clientes VALUES
(NULL,'Juan','Perez','Boyaca 555, CABA','1152889655','juanperez@gmail.com'),
(NULL,'Jose','Ceballos','Caracas 2155, CABA','1187923355','joseceballos@mail.com'),
(NULL,'Carla','Farias','Av Segurola 2322 1°B, CABA','1155224855','carlafarias@gmail.com'),
(NULL,'Carolina','Gomez','Av Hipolito Yirigoyen 522, Lanus, GBA','1166128799','gomezcarolina33@gmail.com'),
(NULL,'Norberto','Carrizo','Av Mitre 2251 5°A, Avellaneda, GBA','1165442525','carrizonorberto@mail.com'),
(NULL,'Paula','Carrasco','Av Nazca 859, CABA','1144558484','carrascop@gmail.com'),
(NULL,'Jorge','Gonzalez','Serrano 755, CABA','1154883255', DEFAULT),
(NULL,'Jonathan','Garcia','Av Libertador 5233 11°C, CABA','1154552300','garciajonathan11@gmail.com'),
(NULL,'Cinthia','Morales','Av Callao 202, CABA','1189655145', DEFAULT),
(NULL,'Debora','Caruso','Carlos Calvo 3255 4°A, CABA','1144887784','deboracar@gmail.com');

INSERT INTO direcciones_envio VALUES
(NULL,'1','Av Eva Peron 2155','CABA','Buenos Aires'),
(NULL,'1','Av 25 de Mayo 522','San Rafael','Mendoza'),
(NULL,'2','Av Jujuy 5221','Resistencia','Chaco'),
(NULL,'2','Av 9 de Julio 521','Rosario','Santa Fe'),
(NULL,'2','Carlos Casares 422','Villa Maria','Cordoba'),
(NULL,'3','Gral Cesar Diaz 5524','CABA','Buenos Aires'),
(NULL,'4','Ceballos 252','Lujan','Buenos Aires'),
(NULL,'4','Quitana 5050','Moreno','Buenos Aires'),
(NULL,'5','Bufano 722','CABA','Buenos Aires'),
(NULL,'5','Peru 2666','Salta','Salta'),
(NULL,'5','Av del Campo 526','Rosario','Santa Fe'),
(NULL,'6','Lima 888','CABA','Buenos Aires');

INSERT INTO pedidos (id, cliente, guit, cantidad, fecha, dir_envio) VALUES
(NULL,'1','2','10','2022/01/22','2'),
(NULL,'5','3','5','2022/01/25','10'),
(NULL,'5','13','20','2022/01/25','10'),
(NULL,'4','5','40','2022/01/30','8'),
(NULL,'1','17','7','2022/02/05','2'),
(NULL,'3','19','2', '2022/02/15','6'),
(NULL,'4','9','10','2022/02/17','7'),
(NULL,'4','14','5', '2022/02/17','7'),
(NULL,'1','1','8','2022/02/25','1'),
(NULL,'5','4','10','2022/02/26','11'),
(NULL,'5','6','8','2022/02/26','11'),
(NULL,'6','1','20', '2022/03/02','12'),
(NULL,'2','7','15','2022/03/10','4');

/* Funcion Extra #2: Sirve para calcular el precio total de un pedido mediante el id del mismo, selecciona 
el precio de la guitarra y la cantidad que se pidio y lo multiplica devolviendo el resultado. Esta funcion
solamente la utilizo para popular datos por primera vez ya que no sirve para ingresar un nuevo pedido, para eso
cree otra funcion mas adelante pero que calcula el precio total del pedido en base al id de la guitarra y la cantidad*/

DELIMITER $$
CREATE FUNCTION `fx_calc_prt_pedido` (id INT)
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE resultado FLOAT;
    SET resultado = (SELECT guit.precio * ped.cantidad 
					 FROM pedidos ped
                     INNER JOIN guitarras guit ON guit.id = ped.guit
                     WHERE ped.id = id);													
RETURN resultado;
END
$$
DELIMITER ; 

-- Insercion de precios totales de pedidos con la Funcion Extra #2 creada

DELIMITER //
UPDATE pedidos
SET precio = fx_calc_prt_pedido(id);
//
DELIMITER ;


-- Creacion de vistas

DELIMITER //
USE fabrica_guitarras;
//
DELIMITER ;

/* Vista #1: Sirve para saber el costo de fabricación de todas las guitarras. El resultado que arroja es la sumatoria
de los costos de los materiales y el id de cada una de las guitarras gracias al filtro GROUP BY que hace que se 
agrupen por id. Interactua con las tablas materiales, materiales_guitarras y guitarras y es de gran utilidad 
ya que haciendo filtros podríamos obtener el costo de una sola guitarra o determinadas guitarras que querramos saber.*/

DELIMITER //

CREATE OR REPLACE VIEW costo_guitarras
AS SELECT SUM(mat.costo) costo, guit.id id_guitarra
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id
GROUP BY guit.id;

// DELIMITER ;

/* Vista #2: Sirve para saber el valor total de mis ventas, en que cantidad de pedidos y
que cantidad de guitarras. Interactua solamente con la tabla pedidos haciendo la sumatoria de todas las cantidades
de guitarras (cantidad de guitarras vendidos), el conteo de id de pedidos (cantidad de pedidos en que se vendio) y
la sumatoria de los precios (total vendido).*/

DELIMITER //

CREATE OR REPLACE VIEW total_ventas
AS SELECT SUM(cantidad) cantidad_guitarras, COUNT(id) cantidad_pedidos, SUM(precio) total
FROM pedidos;

// DELIMITER;

/* Vista #3: Sirve para obtener los datos importantes de los proveedores del tipo de material "maderas". Interactua
con las tablas proveedores, proveedores_materiales y materiales, de gran utilidad para obtener una vista rapida
de mis proveedores para materiales que son de los mas utilizados en la fabrica. */

DELIMITER //

CREATE OR REPLACE VIEW proveedores_maderas
AS SELECT prov.nombre, prov.telefono, prov.mail
FROM proveedores prov
INNER JOIN proveedores_materiales pm ON pm.prov_id = prov.id
INNER JOIN materiales mat ON mat.id = pm.mat_id
WHERE mat.tipo = "maderas"
GROUP BY prov.nombre;

// DELIMITER;

/* Vista #4: Sirve para ver todos los pedidos junto a su valor y direccion de envio. Interactua con las tablas pedidos,
clientes y direcciones_envio, dando un vistazo rapido al pedido, su valor y su direccion de envio. De gran utilidad
para poder identificar a donde hay que enviar cada pedido, tambien se puede utilizar el filtro WHERE para filtrar
por el id_pedido y obtener esta misma de informacion de uno o mas pedidos determinados. */

DELIMITER //

CREATE OR REPLACE VIEW pedidos_clientes
AS SELECT ped.id id_pedido, ped.precio valor, CONCAT (cl.nombre, ' ', cl.apellido) nombre_apellido, 
dir.direccion direccion_envio, dir.localidad, dir.provincia
FROM pedidos ped
INNER JOIN clientes cl ON ped.cliente = cl.id
INNER JOIN direcciones_envio dir ON ped.dir_envio = dir.id
ORDER BY ped.fecha;

// DELIMITER ;

/* Vista #5: Sirve para saber que materiales necesito para fabricar cada guitarra. Interactua con las tablas materiales,
materiales_guitarras y guitarras obteniendo el id de la guitarra, el tipo, y los materiales que la componen con sus
respectivos tipos. Es de gran utilidad ya que si necesito saber que materiales necesito para fabricar una determinada
guitarra puedo utilizar el filtro WHERE con la vista pasandole el id_guitarra para que solo me devuelva esos datos. */

DELIMITER //

CREATE OR REPLACE VIEW material_p_guitarra
AS SELECT guit.id id_guitarra, guit.tipo tipo_guitarra, guit.modelo modelo_guitarra, 
mat.tipo tipo_material, mat.marca marca_material, mat.modelo modelo_material
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id;

// DELIMITER;

/* Vista #6: para saber de que materiales tengo stock bajo junto con los datos del proveedor que lo vende. Interactua
con las tablas materiales, proveedores_materiales y proveedores. Es de gran utilidad para hacer reposicion de materiales
ya que podemos saber de forma rapida cual es el stock bajo y quien es el que lo provee de estos materiales. */

DELIMITER //

CREATE OR REPLACE VIEW stock_bajo_materiales
AS SELECT mat.id id_material, mat.tipo, mat.modelo, mat.stock, prov.nombre nombre_proveedor, 
prov.telefono, prov.mail
FROM materiales mat
INNER JOIN proveedores_materiales pm ON mat.id = pm.mat_id
INNER JOIN proveedores prov ON prov.id = pm.prov_id
WHERE mat.stock <= 100;

// DELIMITER;

/* Vista #7: Sirve para saber de que guitarras tengo stock bajo para fabricar mas. Interactua solamente con la tabla
guitarras, dando un vistazo rapido de las guitarras que tienen menos de 100 unidades de stock con su id, tipo y modelo */

DELIMITER //

CREATE OR REPLACE VIEW stock_bajo_guitarras
AS SELECT id, tipo, modelo, stock
FROM guitarras
WHERE stock <= 100;

// DELIMITER;

/* Vista #8: Sirve para saber cual es el promedio de ventas y en que cantidad de pedidos. Interactua solamente
con la tabla pedidos. */

DELIMITER //

CREATE OR REPLACE VIEW promedio_ventas
AS SELECT ROUND(AVG(precio), 2) promedio_venta, COUNT(id) total_pedidos
FROM pedidos;

// DELIMITER;




-- Creacion de funciones

USE fabrica_guitarras;

/* Funcion #1: Sirve para calcular el costo de un pedido mediante el id del mismo, hace la sumatoria de los costos de los
materiales segun el id de pedido que se ingrese multiplicandolo por la cantidad del pedido, dando como resultado el 
costo total para ese pedido. Interactua con las tablas materiales, materiales_guitarras, guitarras y pedidos. Es de
gran utilidad a la hora de ingresar un pedido nuevo para saber cual va a ser el costo de fabricacion del mismo.*/

DELIMITER $$
CREATE FUNCTION `fx_calc_cst_ped` (id INT)
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE resultado FLOAT;
    SET resultado = (SELECT SUM(mat.costo) * ped.cantidad
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	INNER JOIN pedidos ped ON ped.guit = guit.id
	WHERE ped.id = id);
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion #2: Sirve para calcular el costo de fabricacion de una guitarra mediante el id de la misma, hace la sumatoria
de los costos de materiales segun el id de guitarra que se haya ingresado y devuelve el total. Interactua con las tablas
materiales, materiales_guitarras y guitarras, de gran utilidad para saber el costo de una guitarra de forma rapida*/

DELIMITER $$
CREATE FUNCTION `fx_calc_cst_guit`(id INT) 
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE resultado FLOAT;
    SET resultado = (SELECT SUM(mat.costo)
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id);
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion #3: Sirve para calcular cuantos pedidos realizo un cliente mediante el id del mismo, hace un conteo de id
interactuando con la tabla pedidos y devuelve el total de ese pedido. Puede ser util para sacar estadisticas
de quienes son los clientes que mas compras realizan y en base a eso definir de que forma pueden pagar o si tienen
algun tipo de descuento.*/

DELIMITER $$
CREATE FUNCTION `fx_calc_ctped_cl`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE cliente = id);
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion #4: Sirve para calcular cuantos dias pasaron desde el ultimo pedido que hizo un cliente mediante su id,
con la variable fecha 1 guarda la ultima fecha en la realizo un pedido segun el id que se ingrese, con la variable
fecha 2 guarda la fecha actual, luego en la variable resultado sacamos la diferencia entre estas dos para obtener
el total de dias. Interactua solamente con la tabla pedidos y es de gran utilidad para saber si por ejemplo paso
mucho tiempo desde que un cliente no realiza un pedido. */

DELIMITER $$
CREATE FUNCTION `fx_calc_ctdi_ultped`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE fecha1 DATE;
    DECLARE fecha2 DATE;
    DECLARE resultado INT;
	SET fecha1 = (SELECT ped.fecha
	FROM pedidos ped
	WHERE cliente = id
	ORDER BY fecha DESC
	LIMIT 1);
    SET fecha2 = (SELECT CURDATE() FROM DUAL);
    SET resultado = (DATEDIFF(fecha2,fecha1));
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion #5: Sirve para calcular cantidad de pedidos entre 2 fechas que ingrese el usuario, la funcion hace un conteo
del campo id en la tabla pedidos segun los parametros que se ingresan en la funcion y devuelve el total. Es de gran
utilidad para saber cuantos pedidos se tuvo en un determinado periodo de forma rapida. */

DELIMITER $$
CREATE FUNCTION `fx_calc_ctped_xfech`(fecha1 DATE, fecha2 DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2);
RETURN resultado;
END
$$
DELIMITER ;

/* Funcion #6: Sirve para calcular el precio total de un pedido ingresando los parametros de 
guitarra y cantidad. Facilita a la hora de hacer ingresos de nuevos pedidos ya que calcula
e ingresa el precio total del pedido en el momento. Interactua con la tabla guitarras unicamente. */

DELIMITER $$
CREATE FUNCTION `fx_calc_prt_pedins`(guitarra INT, cantidad INT) 
RETURNS FLOAT
READS SQL DATA
BEGIN
DECLARE v_precio FLOAT;
DECLARE v_resultado FLOAT;
SELECT precio
INTO v_precio FROM guitarras WHERE id = guitarra;
			  
SELECT v_precio * cantidad INTO v_resultado;
RETURN v_resultado;
END
$$
DELIMITER ;



-- Creacion de Stored Procedure

/* Store Procedure #1: Sirve para ordenar la tabla de guitarras según los parametros que ingresa
el usuario. En total recibe 2 parametros, el primero corresponde a sobre que campo se va a hacer
el orden, el segundo corresponde a la forma en que se va a hacer ese orden (ASC, DESC).
Para poder realizarlo utilicé el condicional CASE para cada caso, de tal forma que cuando se llama
al SP los parametros que espera son de tipo INT, siendo que en el caso del campo son valores
del 1 al 6 y son en el mismo orden que esta la tabla, y en el caso del orden son valores 1 para
ASC y 2 para DESC. Por ejemplo si hicieramos un CALL con parametros 3 y 2 lo ordenaría por 
modelo de forma descendente. Interactúa con la tabla guitarras, es beneficiosa para poder hacer
consultas rapidas en una tabla que va a ser muy utilizada.*/

DELIMITER //
CREATE PROCEDURE sp_orden_guitarras (IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM guitarras 
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN modelo END,
	CASE WHEN campo = 3 AND orden = 2 THEN modelo END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN ano END,
	CASE WHEN campo = 4 AND orden = 2 THEN ano END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN stock END,
	CASE WHEN campo = 5 AND orden = 2 THEN stock END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN precio END,
	CASE WHEN campo = 6 AND orden = 2 THEN precio END DESC;
END
//
DELIMITER ;

-- PRUEBA PARA STORE PROCEDURE #1

/*
CALL sp_orden_guitarras(6,2);
*/

/* Stored Procedure #2: Sirve para eliminar registros en la tabla pedidos, su funcionamiento
es muy simple, al llamar al stored procedure se ingresa el id del pedido que se desea eliminar
y este es comparado con el id de la tabla pedidos, busca el igual y lo elimina. Interactua con
la tabla pedidos, es una forma rapida y facil de eliminar registros en una tabla con mucha
interaccion, es normal que algun pedido pueda ser cancelado o se quiera eliminar un pedido
viejo.*/

DELIMITER //
CREATE PROCEDURE sp_eliminar_pedido (IN id INT)
BEGIN
	DELETE FROM pedidos ped
    WHERE ped.id = id;
END					
//
DELIMITER ; 

-- PRUEBA PARA STORED PROCEDURE #2

/*
CALL sp_eliminar_pedido(5);
*/


/* Store Procedure #3: Sirve para ingresar nuevos clientes, cuando se lo llama
se ingresan los parametros de nombre, apellido, direccion, telefono y mail y crea un nuevo
registro en la tabla de clientes con el proximo id. Una forma rapida y simple de 
ingresar un nuevo cliente.*/

DELIMITER //
CREATE PROCEDURE sp_ingresar_clientes (nombre VARCHAR(45),
                                      apellido VARCHAR(45),
                                      direccion VARCHAR(200),
                                      telefono INT,
                                      mail VARCHAR(60))
BEGIN
	INSERT INTO clientes VALUES
    (NULL, nombre, apellido, direccion, telefono, mail);
END					
//
DELIMITER ;

-- PRUEBA PARA STORED PROCEDURE #3

/*
CALL sp_ingresar_clientes('Josefina', 'Vera', 'Peru 233, CABA', 1154332244, 'josevera@gmail.com');
*/



-- Creacion de Triggers

/* Trigger #1: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un INSERT en la tabla pedidos. Es muy util a futuro ya que podemos
tener registros de quien fue el que ingreso un pedido en el caso de que se haya ingresado
mal algun dato.*/

DELIMITER //
CREATE TRIGGER `ingreso_nuevo_pedido`
AFTER INSERT ON `pedidos`
FOR EACH ROW
BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = NEW.cliente ;
SET @dat = CONCAT(@nom, ' ', @ape);
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, 
		CONCAT('Se ingreso un nuevo pedido del cliente ', @dat, 
        ' con el precio de ', NEW.precio));
END
//
DELIMITER ;

-- PRUEBA PARA TRIGGER #1

/*
INSERT INTO pedidos VALUES
(NULL,'4','8','5', (SELECT fx_calc_prt_pedins(8,5)) , CURDATE(),'5');
*/


/* Trigger #2: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un DELETE en la tabla pedidos. Es muy util a futuro ya que podemos
tener registros de quien fue el que elimino un pedido si se elimino mal. */

DELIMITER //
CREATE TRIGGER `borrar_pedido`
BEFORE DELETE ON `pedidos`
FOR EACH ROW
BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = OLD.cliente ;
SET @dat = CONCAT(@ape, ' ', @nom);

INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, CONCAT('Se elimino un pedido del cliente ', @dat, 
        ' con el precio de ', OLD.precio));
END
//
DELIMITER ;


-- PRUEBA PARA TRIGGER #2

/*
DELETE FROM pedidos WHERE id = 10;
*/

/* Trigger #3: Guarda información de fecha y usuario que realizo el movimiento 
y el id, tipo, costo viejo, costo nuevo y diferencia de costo en % 
del material sobre el cual se realizo cuando hacemos un UPDATE en la tabla materiales.
Tiene 2 utilidades, la primera es poder saber quien realizo el movimiento en el caso
de que haya habido algun error a la hora de modificar un precio, la segunda es 
poder saber en que porcentaje aumento o disminuyo el costo del material*/

DELIMITER //
CREATE TRIGGER `actualizar_costo_material`
BEFORE UPDATE ON `materiales`
FOR EACH ROW
BEGIN
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, OLD.tipo, NEW.costo, OLD.costo, 
		CONCAT(ROUND((((NEW.costo - OLD.costo) * 100) / OLD.costo),2), ' %'), 
        'Actualizacion de precio');
END
//
DELIMITER ;

-- PRUEBA PARA TRIGGER #3

/*
UPDATE materiales
SET costo = 2500
WHERE id = 4;
*/


/* Trigger #4: Guarda información de fecha y usuario que realizo el movimiento 
y el id, tipo y costo del material sobre el cual se realizo cuando hacemos 
un INSERT en la tabla materiales. Su beneficio es poder saber quien hizo el ingreso
de un nuevo material al sistema en el caso de que se haya ingresado algun dato mal. */

DELIMITER //
CREATE TRIGGER `ingresar_material`
AFTER INSERT ON `materiales`
FOR EACH ROW
BEGIN
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, NEW.tipo, NEW.costo, NULL, NULL, 
		'Ingreso nuevo material');
END
//
DELIMITER ;

-- PRUEBA PARA TRIGGER #4

/*
INSERT INTO materiales VALUES
(NULL, 'microfonos', 'Fender', 'Texas Special', 'Set x3 para electrica', '250', '8000');
*/


/* Trigger #5: Almacena en una variable la cantidad que se esta ingresando en un pedido
para luego hacer un UPDATE en la tabla guitarras y restar esa cantidad al stock de la guitarra que se
pidio. Es un trigger muy util para automatizacion de los datos. */


DELIMITER //
CREATE TRIGGER `actualizar_stock_guitarras`
AFTER INSERT ON `pedidos`
FOR EACH ROW
BEGIN
DECLARE v_cantped INT;
SELECT NEW.cantidad INTO v_cantped;
UPDATE `guitarras`
SET stock = stock - v_cantped WHERE id = NEW.guit;
END
//
DELIMITER ;

-- PRUEBA PARA TRIGGER #5

/*
INSERT INTO pedidos VALUES
(NULL,'3','11','37', (SELECT fx_calc_prt_pedins(11,37)) , CURDATE(),'8');
*/