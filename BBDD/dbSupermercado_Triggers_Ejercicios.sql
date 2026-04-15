DROP TABLE IF EXISTS dbsupermercado.tbl_auditoria_precios;
CREATE TABLE dbsupermercado.tbl_auditoria_precios
(
    id_auditoria    INT AUTO_INCREMENT PRIMARY KEY,
    idcodigo        INT                 NOT NULL,
    precio_anterior DECIMAL(10, 2)      NOT NULL,
    precio_nuevo    DECIMAL(10, 2)      NOT NULL,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario         VARCHAR(50),
    FOREIGN KEY     (idcodigo) REFERENCES dbsupermercado.tblproductos (codigobarra)
);

-- EJERCICIO FACIL 1: Registro de auditoria para cambios de precios
-- ENUNCIADO: Crear un trigger que registre en una tabla de auditoria cada vez que se modifique
-- el precio de un producto. La tabla debe guardar: código del producto, precio antiguo,
-- precio nuevo, fecha de modificación y usuario que realizó el cambio.

-- Solución:
drop trigger if exists dbsupermercado.trAuditoria_precios;
delimiter $$
CREATE TRIGGER dbsupermercado.trAuditoria_precios
    AFTER
    UPDATE
    ON tblproductos
    FOR EACH ROW
    BEGIN
        declare v_idcodigo int;
        declare v_precio_anterior float;
        declare v_precio_nuevo float;
        set v_idcodigo=OLD.codigo;
        set v_precio_nuevo=NEW.precio;
        set v_precio_anterior=old.precio;

        if  old.precio != NEW.precio then
            insert into  tbl_auditoria_precios (idcodigo, precio_anterior, precio_nuevo, usuario)
            values (v_idcodigo, v_precio_anterior, v_precio_nuevo, current_user);
        end if;
    end $$
    delimiter ;

 -- Prueba del trigger
select * from tbl_auditoria_precios;

update tblproductos
set precio = 20
where codigo in (100001, 100002);

select * from tbl_auditoria_precios;



