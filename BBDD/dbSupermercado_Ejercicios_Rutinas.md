# Ejercicios de Base de Datos - Supermercado

Este documento contiene todos los enunciados de ejercicios basados en las rutinas SQL de la base de datos del supermercado.

## Funciones de Búsqueda

### 1:
**Enunciado:** Crea una función que busque un producto por su código de barra y devuelva su ID. Si no existe, debe retornar 0.

---
https://mail.ovh.net/roundcube/?_task=mail&_mbox=INBOX#
### 2:
**Enunciado:** Desarrolla una función que busque una localidad por su nombre y devuelva su ID (código postal). La búsqueda debe ser insensible a mayúsculas/minúsculas y espacios.

---

### 3:
**Enunciado:** Implementa una función que busque una tienda por el ID de localidad y devuelva el ID de la tienda.

---

### 4:
**Enunciado:** Crea una función que busque un proveedor por su CIF y devuelva su ID.

---

### 5:
**Enunciado:** Desarrolla una función que busque una categoría por su nombre y devuelva su ID.

---

### 6:
**Enunciado:** Implementa una función que busque una marca por su nombre y devuelva su ID.

---

### 7:
**Enunciado:** Crea una función que busque un tipo de venta por su nombre y devuelva su ID.

---

### 8:
**Enunciado:** Desarrolla una función que busque una medida por su nombre y devuelva su ID.

---

### 9:
**Enunciado:** Implementa una función que busque una oferta por su nombre y devuelva su ID.

---

### 10:
**Enunciado:** Crea una función que busque si una oferta está asignada a una categoría específica. Utiliza un parámetro compuesto con separador '|'.

---

### 11:
**Enunciado:** Desarrolla una función polimórfica que pueda buscar diferentes tipos de elementos según un parámetro numérico.

**Tipos de búsqueda:**
- 1: producto (código)
- 2: tienda (código localidad)
- 3: proveedor (CIF)
- 4: categoría (nombre)
- 5: marca (nombre)
- 6: tipo venta (nombre)
- 7: medida (nombre)
- 8: oferta (nombre)
- 9: oferta y categoría (formato "oferta|categoría")
- 10: localidad (nombre)

---

## Procedimientos Almacenados

### 12:
**Enunciado:** Crea un procedimiento que muestre todos los productos registrados en la base de datos.

**Resultado:** Lista completa de productos

---

### 13:
**Enunciado:** Desarrolla un procedimiento que muestre los detalles de un producto específico por su código de barra.

**Resultado:** Detalles completos del producto

---

### 14:
**Enunciado:** Implementa un procedimiento que cuente el total de productos registrados y devuelva el resultado.

**Resultado:** Número total de productos en el inventario

---

### 15:
**Enunciado:** Crea un procedimiento que liste todos los productos de una categoría específica.

**Resultado:** Lista de productos de la categoría especificada

---

### 16:
**Enunciado:** Desarrolla un procedimiento que genere un informe estadístico del inventario incluyendo cantidad, precios mínimos/máximos y valor total.

**Resultado:** Estadísticas completas del inventario

---

### 17:
**Enunciado:** Implementa un procedimiento que cree una nueva categoría si no existe y devuelva su ID.

**Resultado:** ID de la nueva categoría o 0 si ya existía

---

### 18:
**Enunciado:** Crea un procedimiento que cree una nueva marca si no existe y devuelva su ID.

**Resultado:** ID de la nueva marca o 0 si ya existía

---

### 19:
**Enunciado:** Desarrolla un procedimiento que cree una nueva oferta sin categoría asignada y devuelva su ID.

**Resultado:** ID de la nueva oferta o 0 si ya existía

---

### 20:
**Enunciado:** Implementa un procedimiento que cree una nueva oferta asociada a una categoría específica y devuelva su ID.

**Resultado:** ID de la nueva oferta o 0 si ya existía

---

### 21:
**Enunciado:** Crea un procedimiento que cree una nueva tienda con horario estándar (09:00-21:00, Lun-Sab) y devuelva su ID.

**Resultado:** ID de la nueva tienda o 0 si ya existía

---

### 22:
**Enunciado:** Desarrolla un procedimiento completo para registrar un nuevo producto con todas sus características y validaciones.

**Validaciones:**
- El proveedor debe existir
- El producto no debe existir previamente
- Todas las referencias (medida, categoría, marca, tipo venta, tienda) deben ser válidas

**Resultado:** Código de barra del producto y mensaje de estado

---

### 23:
**Enunciado:** Crea una función que verifique si una oferta específica está asignada a una tienda determinada.

---

### 24:
**Enunciado:** Implementa un procedimiento que asigne una oferta a una tienda con fechas de validez.

**Validaciones:**
- La tienda debe existir
- La oferta no debe estar ya asignada a esa tienda

**Resultado:** Mensaje indicando el estado de la operación

---

### 25:
**Enunciado:** Desarrolla un procedimiento para dar de alta una nueva oferta con su valor y tipo de descuento.

**Validaciones:**
- La oferta no debe existir para esa categoría
- La categoría debe existir
- El tipo de descuento debe ser válido

**Resultado:** Código de la oferta y mensaje de estado

---

## Adicionales de Procedimientos

### 26:
**Enunciado:** Crea un procedimiento que calcule el valor total del inventario basado en el precio de venta de todos los productos.

**Resultado:** Valor total del inventario (redondeado a 2 decimales)

---

### 27:
**Enunciado:** Implementa un procedimiento que cree una nueva unidad de medida si no existe y devuelva su ID.

**Resultado:** ID de la nueva medida o 0 si ya existía

---

## Notas Importantes

1. **Validaciones:** Todos los procedimientos deben incluir validaciones adecuadas para evitar duplicados y asegurar la integridad de datos.

2. **Manejo de Errores:** Implementar manejo de errores con mensajes descriptivos para el usuario.

3. **Formato de Fechas:** Las fechas deben manejarse en formato DDMMYYYY para consistencia.

4. **Búsquedas Insensibles:** Todas las búsquedas de texto deben ser insensibles a mayúsculas/minúsculas y espacios.

5. **Valores por Defecto:** Utilizar valores por defecto apropiados cuando sea necesario (ej: horario de tiendas).

6. **Transacciones:** Considerar el uso de transacciones para operaciones complejas que modifiquen múltiples tablas.

---

## Sugerencias de Práctica

1. **Pruebas Unitarias:** Crear casos de prueba para cada función y procedimiento.

2. **Optimización:** Analizar y optimizar las consultas para mejor rendimiento.

3. **Documentación:** Mantener documentación actualizada de parámetros y valores de retorno.

4. **Seguridad:** Implementar permisos adecuados para ejecución de rutinas.

5. **Logging:** Considerar agregar logging para auditoría de operaciones críticas.
