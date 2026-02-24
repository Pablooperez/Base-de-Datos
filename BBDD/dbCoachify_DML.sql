use dbCoachify;
/*DOCUMENTO*/
insert into tblTipoDocumento (documento)
values (upper('DNI')),
       (upper('Pasaporte')),
       (upper('Permiso de Residencia'));

set @idTipoDocumento = (select idtipodoc
                        from tblTipoDocumento
                        where documento like 'DNI');

select @idTipoDocumento;
/*SEXO*/
insert into tblSexos (sexo)
values (upper('Masculino')),
       (upper('Femenino'));

set @idsexo = (select idsexo
               from tblSexos
               where sexo like 'Masculino');
select @idsexo;
/*VIA*/
insert into tblVias (via)
values (upper('calle')),
       (upper('avenida')),
       (upper('rotonda')),
       (upper('gran via'));
set @idvia = (select idvia
              from tblVias
              where via like 'calle');
select @idvia;
/*PROVINCIA*/
insert into tblProvincias (idprovincia,provincia)
values (46, upper('valencia'));
set @idprovincia = (select idprovincia
                    from tblProvincias
                    where provincia like 'Valencia');
select @idprovincia;
/*LOCALIDAD*/
insert into tblLocalidades (idlocalidad,localidad,idprovincia)
values (460,upper('Valencia'),@idprovincia);

set @idlocalidad = (select idlocalidad
                    from tblLocalidades
                    where localidad like 'valencia');
select @idlocalidad;
/*TIPOEMPLEADO*/
insert into tblTiposEmpleados (tipo)
values (upper('entrenador')),
        (upper('psicologo'));
set @idtipoempleado = (select idtipo
                       from tblTiposEmpleados
                       where tipo like 'entrenador');
select @idtipoempleado;

insert into tbltitulostipo (idtitulo, titulo, descripcion)
values  (1,'Ingeniería','Ingeniería Informática');
set @idtitulo = (select idtitulo
                 from tbltitulostipo
                 where titulo like 'Ingeniería');
select @idtitulo;

insert into tblidiomastipo (ididioma, idioma)
values  (1,'Español');
set @ididioma = (select ididioma
                 from tblidiomastipo
                 where idioma like 'Español');
select @ididioma;

insert into tblespecializaciontipo (idespecializacion, especializacion,descripcion)
values  (1,'Fuerza','Especializado en entrenamientos de fuerza con ejercicio multiarticulares');
set @idespecializacion = (select idespecializacion
                 from tblespecializaciontipo
                 where especializacion like 'Fuerza');
select @idespecializacion;

/* INTRODUCIR EL EMPLEADO */

insert into tblEmpleados (idempleado, idtipodoc,numero ,nombre, apellido1, apellido2, edad, idsexo, telefono, email,
                          idvia, calle, cp, idlocalidad, idtipo, idtitulo, ididioma, idespecializacion)
values  (@idempleado,@idtipodocumento,'29221392F','Pablo','Pérez','Martínez',25,@idsexo,
         660653571,'pablo.perez.martinez99@gmail.com',@idvia,'masquefa',46020,@idlocalidad,@idtipoempleado,@idtitulo,@ididioma,@idespecializacion);


