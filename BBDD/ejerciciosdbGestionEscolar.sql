
/* Problema 1: Insertar un nuevo estudiante en la base de datos.

 Enunciado del Problema: "Se necesita agregar un nuevo estudiante a la base de datos con la siguiente información:

Nombre: Lucía
Apellido: Pérez
Fecha de nacimiento: 15 de octubre de 2001
Correo electrónico: lucia.perez@email.com
Estado: Activo
Fecha de ingreso: 1 de septiembre de 2023
Escribe la sentencia SQL necesaria para realizar esta inserción en la tabla 'estudiantes'."
*/

use dbgestionescolar;

insert into estudiantes (nombre, apellido, fecha_nacimiento, email,activo, fecha_ingreso) values
('Lucía','Pérez','2001-10-15','lucia.perez@gmail.com',TRUE ,'2023-09-01');

/* Problema 2: Insertar múltiples materias a la vez.
 Enunciado del Problema: "Se necesita agregar dos nuevas materias al plan de estudios con la siguiente información:

1. Primera materia:

Nombre: Inteligencia Artificial
Créditos: 6
Área de conocimiento: Informática
2. Segunda materia:

Nombre: Seguridad Informática
Créditos: 6
Área de conocimiento: Informática
Escribe una única sentencia SQL que inserte ambas materias en la tabla 'materias'."
*/

insert into materias (nombre_materia, creditos, area_conocimiento) VALUES
('Inteligencia Articial',6,'Informática'),
('Seguridad Informática',6,'Informática');


/*Problema 3: Actualizar el correo electrónico de un estudiante específico.
Enunciado del Problema: "Se necesita actualizar la dirección de correo electrónico de un estudiante específico en la base de datos. El estudiante a actualizar tiene el ID 3 y su nuevo correo electrónico debe ser 'nuevo.email@email.com'.
*/

update estudiantes
set email = 'nuevo.email@email.com'
where id_estudiante = 3;

/* Problema 4:
 Enunciado del Problema:
 "Se necesita incrementar en 0.5 puntos las calificaciones de todos los estudiantes en la materia de 'Matemáticas I',
 siempre y cuando su calificación actual sea menor o igual a 9.5. La actualización debe realizarse en una sola operación
 */

select id_materia
into @id_materia
from materias
where lower(trim(nombre_materia)) = lower('Matemáticas%I');

set @idmateria = (select id_materia
                  from materias
                  where nombre_materia like 'Matemáticas I');
select @idmateria;

update calificaciones
set  calificacion = calificacion+0.5
where calificacion <= 9.5 and id_materia=@idmateria;

/* Problema 5:
 Enunciado del Problema:
 Actualizar el estado de todos los estudiantes inactivos que ingresaron antes de 2021.*/

update estudiantes
set activo = true
where fecha_ingreso < '2021-01-01';

/* Problema 6:
 Enunciado del Problema:
 "Se requiere eliminar las calificaciones del alumno Elena Fernandez
 */
set @idestudiante = (select id_estudiante
                     from estudiantes
                     where nombre like 'Elena' and apellido like 'Fernández');
select @idestudiante;

delete from calificaciones
where id_estudiante = @idestudiante;

/* Problema 7:
 Enunciado del Problema:
 "Se requiere eliminar de la base de datos a todos los estudiantes que actualmente están marcados como inactivos
*/
delete from estudiantes
where activo = false;


/* Problema 8:
   Enunciado del Problema:
   Insertar un nuevo estudiante y asignarle tres calificaciones en una sola transacción.
-- Solución:
*/

