START TRANSACTION;
DELETE FROM pedidos
WHERE id = 2;
DELETE FROM pedidos
WHERE id = 7;
DELETE FROM pedidos
WHERE id = 3;

-- ROLLBACK;
-- COMMIT;

-- Sentencia para re-insertar los registros

/* INSERT INTO clientes VALUES
(2, 5, 3, 5, 100725, '2022-01-25', 10),
(3, 5, 3, 5, 214200, '2022-01-25', 10),
(7, 4, 9, 10, 136000, '2022-02-17', 7);
*/

START TRANSACTION;
INSERT INTO clientes VALUES
(NULL, 'Jose', 'Ceballos', 'Lima 332 CABA', '45523322', 'joseceballos@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Juan', 'Cardozo', 'Bartolome Mitre 3323 CABA', '47881122', 'juancardo@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Celina', 'Gomez', 'Caracas 1222 CABA', '47817744', 'gomezcel@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Paula', 'Pisano', 'Trinidad 585 Lanús GBA', '46992255', 'paulapisano@mail.com');
SAVEPOINT lote_cl_1_4;
INSERT INTO clientes VALUES
(NULL, 'Carlos', 'Ramirez', 'Carlos Casares 2231 Merlo GBA', '41225585', 'ramirezc@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Milena', 'Diaz', 'Av Nazca 201', '45884455', 'milenadiaz22@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Carolina', 'Miranda', 'Av Mitre 3322 Avellaneda GBA', '48552288', 'mirandacarolina@mail.com');
INSERT INTO clientes VALUES
(NULL, 'Carla', 'Fernandez', 'Salvador 4744 CABA', '46771155', 'fernandezc22@mail.com');
SAVEPOINT lote_cl_5_8;

-- RELEASE SAVEPOINT lote_cl_1_4;
