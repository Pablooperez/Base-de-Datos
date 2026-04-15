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

/* EJERCICIOS CURSORES ÚNICOS: ACTUALIZAR LOS PRECIOS DE TODOS LOS PRODUCTOS */

drop procedure if exists dbsupermercado.cActualizarPrecios;
delimiter ;
create procedure dbsupermercado.cActualizarPrecios(in _v int, in _p int, out _e int )
begin
    case
        when (_v <=0 and _p <=0) or (_v >0 and _p >0) then set _e =- 1;
        when (_v=0 or _p>0) then set _e = 0;
    else
        begin
            declare v_fin boolean default false;
            declare _codigo int;
            declare _precio float;
            declare _precioVenta float;
            declare _iva int;
            declare puntero cursor for select tblproductos.codigo, tblproductos.precio, tblproductos.iva from dbsupermercado.tblproductos;
            declare continue handler for not found set v_fin = true;
            set _e = 0;
            open puntero;
            ciclo: loop
                set _precioVenta = 0;
                fetch puntero into _codigo, _precio, _iva;
                if  v_fin then
                    leave ciclo;
                end if;
                case
                    when _v > 0 and _v <= _precio then set _precioVenta = _precio + _v;
                    when _v < 0 and _precio - (_v *-1) > _precio then set _precioVenta = _precio - _v;
                    when _p > 0 and _p <= 100 then set _precioVenta = _precio + (_precio * _p/100);
                    when _p < 0 and _p <= 100 then set _precioVenta = _precio - (_precio * _p/100);
                end case;
                if  _precioVenta > 0 then
                    if  _iva>0 then
                        set _precioVenta = _precioVenta + (_precioVenta * _iva/100);
                    end if;
                    update tblproductos
                    set tblproductos.precio_oferta = 0, tblproductos.precio_venta = _precioVenta
                    where tblproductos.codigo=_codigo;
                    set _e = _e + 1;
                end if;
            end loop ciclo;
            close puntero;
        end;
    end case;
end;
delimiter ;

call dbSupermercado.cActualizarPrecios(20, 0 , @e);
select @e;





/* EJERCICIOS CURSORES ÚNICOS: ACTUALIZAR LOS PRECIOS DE TODOS LOS PRODUCTOS EN PORCENTAJE */

drop procedure if exists dbsupermercado.cAumentarPrecioPorcentaje;
delimiter $$
create procedure dbsupermercado.cAumentarPrecioPorcentaje(in v_aumento float)
begin
    declare v_fin boolean default false;
    declare v_precioventa  float;
    declare v_codigobarra int;
    declare cur_aumentarPrecio cursor for
    select tblproductos.precio_venta, tblproductos.codigobarra
    from dbsupermercado.tblproductos;
    declare continue handler for not found set v_fin = true;
    open cur_aumentarPrecio;
    aumentarPrecio: LOOP
        fetch cur_aumentarPrecio into v_precioventa, v_codigobarra;
        if v_fin then
            leave aumentarPrecio;
        end if ;
        update dbsupermercado.tblproductos set precio_venta = precio_venta*(1+(v_aumento/100))
        where dbsupermercado.tblproductos.codigobarra=v_codigobarra;

    end loop ;
end ;

call dbSupermercado.cAumentarPrecioPorcentaje(10);

/* CALCULAR LAS GANANCIAS POR CADA TIPO DE IVA */

drop procedure if exists dbsupermercado.cGananciasIva;
delimiter $$
create procedure dbsupermercado.cGananciasIva(out v_totaliva0 float, out v_totaliva4 float, out v_totaliva10 float, out v_totaliva21 float)
begin
    declare v_fin boolean default false;
    declare v_codigobarra int;
    declare v_precio float;
    declare v_precioVenta float;
    declare v_iva tinyint;
    declare v_beneficios float;
    declare v_cant int;
    declare cur_Ganancias cursor for
    select tblproductos.codigobarra ,tblproductos.precio, tblproductos.precio_venta, tblproductos.iva, tblproductos.cantidad
    from dbsupermercado.tblproductos;
    declare continue handler for not found set v_fin = true;
    set v_totaliva0=0, v_totaliva4=0, v_totaliva10=0, v_totaliva21=0;
    open cur_Ganancias;
    ganancias: LOOP
        fetch cur_Ganancias into v_codigobarra, v_precio, v_precioVenta, v_iva;
        if v_fin then
            leave ganancias;
        end if;
        case
            when v_iva=0 then set v_totaliva0=v_totaliva0+((v_precioVenta-v_precio)*v_cant);
            when v_iva=4 then set v_totaliva4=v_totaliva4+((v_precioVenta-v_precio)*v_cant);
            when v_iva=10 then set v_totaliva10=v_totaliva10+((v_precioVenta-v_precio)*v_cant);
        else
            set v_totaliva21=v_totaliva21+((v_precioVenta-v_precio)*v_cant);
        end case;
    end loop ;
end ;
select @v_totaliva0 as totalBeneficioIVA0, @v_totaliva4 as totalBeneficiosIVA4, @v_totaliva10 as totalBeneficioIVA10, @v_totaliva21 as totalBeneficiosIVA21;
call dbSupermercado.cGananciasIva(@v_totaliva0, @v_totaliva4, @v_totaliva10, @v_totaliva21);

/* GANANCIAS POR TIENDA */

/* EJERCICIOS PRACTICAR: Nivel 1: El "Hola Mundo" de los Cursores
Objetivo: Aprender a declarar, abrir, recorrer y cerrar un cursor sin lógica compleja.
Reto: Crea un procedimiento llamado ListarNombresProductos. Solo quiero que el cursor recorra la tabla tblproductos y guarde en una variable el nombre del último producto procesado.
Pista: Solo necesitas una variable v_nombre y un FETCH simple.
 */

drop procedure if exists dbsupermercado.pListarNombreProductos;
delimiter $$
create procedure dbsupermercado.pListarNombreProductos()
begin
    declare v_fin boolean default false;
    declare v_nombre varchar(100);
    declare puntero cursor for select tblProductos.producto from dbsupermercado.tblProductos;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_nombre;
        if  v_fin then leave bucle;
        end if;
    end loop;
    close puntero;

    select v_nombre as ElUltimoNombreLeido;
end $$
delimiter $$

call dbSupermercado.pListarNombreProductos();

/* Nivel 2: El Contador de Productos "Caros"
Tu misión:
Crea un procedimiento llamado ContarProductosCaros. Queremos que el cursor recorra la tabla y,
   cada vez que encuentre un producto cuyo precio de venta sea mayor a 50€, lo cuente.
   Al final, el procedimiento nos dirá cuántos productos cumplen esa condición. */

drop procedure if exists dbsupermercado.pContadorProductosCaros;
delimiter $$
create procedure dbsupermercado.pContadorProductosCaros()
begin
    declare v_fin boolean default false;
    declare v_contador int default 0;
    declare v_precio float;
    declare puntero cursor for select tblProductos.precio_venta from dbsupermercado.tblProductos;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_precio;
        if v_fin then leave bucle;
        end if;
        if  v_precio > 5 then
            set v_contador = v_contador + 1;
        end if ;
    end loop;
    close puntero;
    select v_contador as Cantidad;
end $$
delimiter ;

call dbSupermercado.pContadorProductosCaros();

/* Crea un procedimiento almacenado llamado pContarStockBajo. El objetivo es que el cursor recorra
   la tabla tblproductos y cuente cuántos productos tienen una cantidad (stock) inferior a 10 unidades.
   Al finalizar el recorrido, el procedimiento debe mostrar el total de productos encontrados que cumplen esa condición. */

drop procedure if exists dbsupermercado.pContarStockBajo;
delimiter $$
create procedure dbsupermercado.pContarStockBajo()
begin
    declare v_fin boolean default false;
    declare v_cantidad int;
    declare v_contador int default 0;
    declare puntero cursor for select tblProductos.cantidad from dbsupermercado.tblProductos;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_cantidad;
        if  v_fin then
            leave bucle;
        end if ;
        if v_cantidad < 10 then
            set v_contador = v_contador + 1;
        end if ;
    end loop ;
    close puntero;
    select v_contador as Cantidad;

end $$
delimiter ;

call dbSupermercado.pContarStockBajo();

/* Crea un procedimiento llamado pStockPorCategoria.
Debe recibir un parámetro de entrada: IN p_id_categoria INT.
El cursor debe seleccionar la cantidad de la tabla tblproductos,
pero filtrando por esa categoría (es decir: WHERE idcategoria = p_id_categoria).
El procedimiento debe sumar todas las cantidades de esa categoría y mostrar el total al final. */

drop procedure if exists dbsupermercado.pStockPorCategoria;
delimiter $$
create procedure dbsupermercado.pStockPorCategoria(in v_categoria tinyint)
begin
    declare v_fin boolean default false;
    declare v_cantidad int;
    declare v_cantidad_total int default 0;
    declare puntero cursor for select tblProductos.cantidad
        from dbsupermercado.tblProductos
            where idcategoría = v_categoria;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_cantidad;
        if v_fin then
            leave bucle;
        end if ;
        set v_cantidad_total=v_cantidad_total+v_cantidad;
    end loop ;
    close puntero;
    select v_cantidad_total as CantidadTotal;
end $$
delimiter ;

call dbSupermercado.pStockPorCategoria(3);

/* Crea un procedimiento almacenado llamado pLiquidarStockAlto. El objetivo es que el cursor
   recorra la tabla tblproductos y, para cada producto que tenga una cantidad (stock) superior a 200 unidades,
   le aplique automáticamente un descuento del 15% en su precio_venta. */

drop procedure if exists dbsupermercado.pLiquidarStockAlto;
delimiter $$
create procedure dbSupermercado.pLiquidarStockAlto()
begin
    declare v_fin boolean default false;
    declare v_cantidad int;
    declare v_codigo int;
    declare puntero cursor for select tblProductos.cantidad, tblProductos.codigobarra
        from dbsupermercado.tblProductos
            where cantidad > 20;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_cantidad, v_codigo;
        if v_fin then
            leave bucle;
        end if ;
        update tblProductos
        set precio_venta = tblProductos.precio_venta * 0.85
        where codigobarra = v_codigo;
    end loop ;
    close puntero;
end $$
delimiter ;

call dbSupermercado.pLiquidarStockAlto();

/* Crea un procedimiento almacenado llamado pCorregirPreciosMinimos.
   El objetivo es que el cursor recorra todos los productos y, si encuentra alguno cuyo precio_venta sea inferior a 0.50€,
   lo actualice automáticamente a ese valor (0.50€). */

drop procedure if exists dbsupermercado.pCorregirPreciosMinimos;
delimiter $$
create procedure dbSupermercado.pCorregirPreciosMinimos()
begin
    declare v_fin boolean default false;
    declare v_precioventa float;
    declare v_codigo int;
    declare puntero cursor for select tblProductos.precio_venta, tblProductos.codigobarra
        from dbsupermercado.tblProductos
            where precio_venta < 0.50;
    declare continue handler for not found set v_fin = true;
    open puntero;
    bucle: loop
        fetch puntero into v_precioventa, v_codigo;
        if v_fin then
            leave bucle;
        end if ;
        update tblProductos
        set precio_venta = 0.50
        where codigobarra = v_codigo;
    end loop ;
    close puntero;
end $$
delimiter ;

call dbSupermercado.pCorregirPreciosMinimos();







