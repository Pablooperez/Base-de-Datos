/* CURSORES:

   Es una construccion que permite un recorrido fila tras fila por el resultado basado en un resultado
   que hacemos a traves de un select.

   -Características:
   --Solo lectura: Consultar.
   --No desplazable: No se puede desplazar, solo obtener flias en el orden determinado por el Select.
   --Iterativo: Secuencialmente.

   -Tipos:
   --Cursor sensible: Apunta a datos reales, más rápido pero menos seguro.
   --Curso Insensible: Usa copia temporal de datos, más seuro pero más lento.

   -Ubicación: Dentro de un procedimiento, función o triggers.

   -Cuatro etapas obligatorias:
   1. Declarar el curso: DECLARE nombre_cursor CURSOR FOR SELECT...
   2. Abrir el cursor: OPEN nombre_cursor.
   3. Leer filas: FETCH nombre_cursor INTO variables.
   4. Cerrar el cursor: CLOSE nombre_cursor.

   -Orden de declaración importante:
   1. Variables.
   2. Condiciones.
   3. Cursores.
   4. Manejadores.

   Ejemplo:

   DECLARE nombre_cursor CURSOR FOR SELECT instrucciones;
   OPEN nombre_cursor;
   FETCH nombre_cursor INTO variable[,..];
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_nombre = valor;
   CLOSE nombre_cursor;

 */

 DECLARE cur_ventas CURSOR FOR
    SELECT id, fecha, monto, cliente
    FROM ventas
    WHERE fecha >= CURDATE() - INTERVAL 30 DAY:
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
 OPEN cur_ventas;
 ventas_loop: LOOP
            FETCH cur_ventas INTO v_id_venta, v_venta, v_fecha, v_monto, v_cliente;
            IF v_fin THEN
                LEAVE ventas_loop;
            END IF;

            IF v_monto > 1000 THEN
               UPDATE clientes set categoria = 'PREMIUM'
               WHERE nombre = v_cliente;
            END IF;
        END LOOP ventas_loopM
        CLOSE cur_ventas;
 END //
 DELIMITER ;

/* EJEMPLO CURSOR. PARA QUE LOS ARTICULOS DE LA CATEGORÍA BEBÉ AUMENTE EL PRECIO EN 10%.
 */

drop procedure if exists dbsupermercado.cAumentarPrecioCate;
delimiter $$
create procedure dbsupermercado.cAumentarPrecioCate(in v_cat int)
begin
    declare v_fin  boolean default false;
    declare v_precioventa float;
    declare cur_catPrecio cursor for
    select tblproductos.precio_venta
    from dbsupermercado.tblproductos;
declare continue handler for not found set v_fin = true;
open cur_catPrecio;
    catPrecio: LOOP
        FETCH cur_catPrecio INTO v_precioventa;
        if v_fin then
            leave catPrecio;
        end if ;

        if v_precioventa > 20 then
            call dbSupermercado.pAumentarPrecioCategoria(v_cat,)
        end if $$
    end loop $$
end $$

/* PROCEDIMIENTO QUE LEA UNA CATEGORÍA Y AUMENTE SU VALOR */

drop procedure if exists dbsupermercado.pAumentarPrecioCategoria;
delimiter $$
create procedure dbsupermercado.pAumentarPrecioCategoria(in v_categoria int, in v_aumento float)
begin
    update dbsupermercado.tblproductos set precio_venta = precio_venta*(1+(v_aumento/100))
    where dbsupermercado.tblproductos.idcategoría = v_categoria;
end $$
delimiter ;

call dbSupermercado.pAumentarPrecioCategoria(10,10);


