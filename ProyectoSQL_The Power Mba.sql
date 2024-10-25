--. 2.Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
-- No se entiende el título y se muestran todos los títulos ordenados por rating

SELECT
    title AS Nombre_Película ,
    release_year AS Año_Publicacion
FROM
    film AS f
ORDER BY
    rating ASC ;

--3.Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT
    actor_id AS Identificador,
    first_name AS Nombre,
    last_name AS Apellido
FROM
    actor a
WHERE
    actor_id BETWEEN 30 AND 40

--4.Obtén las películas cuyo idioma coincide con el idioma original

SELECT
    DISTINCT original_language_id
    --Se busca que id diferentes de original_language_id hay y son todos null
FROM
    film f

SELECT
    DISTINCT NAME,
    language_id
    --Se busca que tipos de idioma hay y se ordena por id de forma ascendente
FROM
    "language" l
ORDER BY
    language_id ASC

SELECT
    *
FROM
    film f
LIMIT 10
-- se hace una revisión de los valores de todas las columnas de la tabla para identificar un registro del idioma original pero el único es la columna de original LANGUAGE id y está en NULL

--5. Ordena las películas por duración de forma ascendente

SELECT
    title AS Pelicula,
    length AS Duracion
FROM
    film f
ORDER BY
    Duracion ASC


--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT
    actor_id AS Identificador,
    first_name AS Nombre ,
    last_name AS Apellido
    --uso de ILIKE para que NO distinga entre mayusculas y minúsculas
FROM
    actor a
WHERE
    last_name ILIKE 'Allen'

/*7.Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.*/

SELECT
    C."name" AS Categoria ,
    COUNT(FC.film_id) AS Numero_Peliculas
    --Se utiliza una tabla intermedia film category para contar los id de peliculas que pertenecen a cada categoría
FROM
    category c
LEFT JOIN film_category fc 
    ON
    C.category_id = FC.category_id
GROUP BY
    c."name"
ORDER BY
    COUNT(FC.film_id) DESC
 
/*8Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.*/

SELECT
    *
FROM
    film f
LIMIT 10
--se detecta que el valor PG-13 pertenece al campo rating; la duración parece estra en minutos

SELECT title 
FROM film f 
WHERE
    rating = 'PG-13'
OR 
    length > 180

/*9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/
    
SELECT
    variance(replacement_cost) Variablididad_Coste_Reemplazo
FROM
    film f

/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD */

SELECT
    MAX(length) Mayor_Duracion,
    MIN(length) Menor_Duracion
FROM
    film f

/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/ 

SELECT
    amount
FROM
    payment
ORDER BY
    payment_date DESC
LIMIT 1 OFFSET 2
/* 12.Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.*/

SELECT
    DISTINCT rating
    --Busco los valores distintos de rating para copiar el valor exacto de los valores a filtrar
FROM
    film f


SELECT title 
FROM film f 
WHERE
    rating <> 'NC-17' 
AND 
    rating <>  'G'
    
/* 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.*/
    
 SELECT
    rating AS Clasificacion ,
    AVG(length) AS Promedio_Duracion
FROM
    film f
GROUP BY
    rating
ORDER BY
    avg(length) DESC

/* 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos. */
    
SELECT
    title AS Nombre_Pelicula,
    length AS Duracion
FROM
    film f
WHERE
    length > 180

/* 15.¿Cuánto dinero ha generado en total la empresa?*/

SELECT
    SUM(amount)
FROM
    payment p

/*16. Muestra los 10 clientes con mayor valor de id.*/

SELECT
    customer_id
FROM
    customer c
ORDER BY
    customer_id DESC
LIMIT 10


/*17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’*/

SELECT
    a.first_name AS Nombre,
    a.last_name AS Apellido,
    F.title AS Nombre_Pelicula
FROM
    film f
LEFT JOIN (
film_actor fa
LEFT JOIN actor a
ON
    fa.actor_id = a.actor_id)
ON
    f.film_id = fa.film_id
WHERE
    f.title ILIKE 'Egg Igby'

/*18. Selecciona todos los nombres de las películas únicos.*/

SELECT DISTINCT title 
FROM film f 

/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.*/


SELECT
    f.title,
    c.name
FROM
    film f
LEFT JOIN (film_category fc
LEFT JOIN category c 
ON
    fc.category_id = c.category_id)
ON
    f.film_id = fc.film_id
WHERE
    c.name = 'Comedy'
 


/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/

SELECT
    c."name" AS "Nombre_categoría",
    avg(f.length) AS "Promoedio_de_duración"
FROM 
    category c
LEFT JOIN (
        film_category fc
LEFT JOIN film f
        ON
    fc.film_id = f.film_id)
    ON
    c.category_id = fc.category_id
GROUP BY
    c."name"
HAVING
    avg(f.length) > 110
ORDER BY
    avg(f.length) DESC

/*21. ¿Cuál es la media de duración del alquiler de las películas?*/
SELECT
    avg(rental_duration) AS "Media_duración_alquiler"
FROM
    film f

/*22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.*/

SELECT
    concat(first_name,
    last_name) AS "Nombre_Apellido"
FROM
    ACTOR

/*23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.*/

SELECT
    rental_date::DATE AS "Día",
    sum(rental_id) AS "Numero de alquiler"
FROM
    rental r
GROUP BY
    rental_date::DATE
ORDER BY
    sum(rental_id)
DESC

/*24. Encuentra las películas con una duración superior al promedio.*/

SELECT
    f.title AS "Nombre_Película" ,
    f.length,
    (
    SELECT
        AVG(fi.length)
    FROM
        film fi)AS "Media"
FROM
    film f
WHERE
    (
    SELECT
        AVG(fi.length)
    FROM
        film fi) < f.length
ORDER BY
    f.length 
ASC

/*25. Averigua el número de alquileres registrados por mes.*/
SELECT
    COUNT(rental_id) AS "Número alquileres",
    to_char(rental_date,
    'YYYY/MM') AS "Mes"
FROM
    rental r
GROUP BY
    "Mes"
ORDER BY
    count(rental_id) DESC

/*26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.
*/


SELECT
    AVG(amount) AS "Promedio",
    stddev(amount) AS "Varianza",
    variance(amount) AS "Varianza"
FROM
    payment p 

/*27. ¿Qué películas se alquilan por encima del precio medio?
*/
SELECT
    title AS "Nombre_Película"
FROM
    film f
WHERE
    EXISTS (
    SELECT
        1
    FROM
        payment p
    WHERE
        p.amount >(
        SELECT
            AVG(amount)
            FROM PAYMENT))
GROUP BY
    "Nombre_Película"

/*28. Muestra el id de los actores que hayan participado en más de 40
películas.*/

SELECT
    a.actor_id AS "IDACTOR"
FROM
    ACTOR a
LEFT JOIN film_actor fa
ON
    a.actor_id = fa.actor_id
GROUP BY
    a.actor_id
HAVING
    count(fa.film_id) > 40


/*29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.*/

SELECT
    f.TITLE AS "Nombre_Película",
    count(i.inventory_id) AS "Cantidad de inventario"
FROM
    film f
JOIN inventory i
ON
    f.film_id = i.film_id
GROUP BY
    f.title

/*30. Obtener los actores y el número de películas en las que ha actuado.*/
    
SELECT
    CONCAT(first_name,
    ' ',
    last_name) AS "NOMBRE_ACTOR",
    count(fa.film_id) AS "PELICULAS_ACTOR"
FROM
    ACTOR a
JOIN
film_actor fa ON
    a.actor_id = fa.actor_id
GROUP BY
    "NOMBRE_ACTOR"

/*31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados*/

SELECT
    f.title AS "Nombre_Pelicula",
    count(fa.actor_id) AS "Número_Actores"
FROM
    film f
LEFT JOIN 
film_actor fa ON
    f.film_id = fa.film_id
GROUP BY
    "Nombre_Pelicula"
/*32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.
*/

SELECT
    CONCAT(first_name,
    ' ',
    last_name) AS "NOMBRE_ACTOR",
    count(fa.film_id) AS "PELICULAS_ACTOR"
FROM
    ACTOR a
LEFT JOIN
film_actor fa ON
    a.actor_id = fa.actor_id
GROUP BY
    "NOMBRE_ACTOR"
ORDER BY "PELICULAS_ACTOR" ASC

/*33. Obtener todas las películas que tenemos y todos los registros de
alquiler.
*/

SELECT
    count(film_id) AS "Total_Peliculas",
    (
    SELECT
        COUNT(RENTAL_ID)
    FROM
        rental r) AS "Total_Alquileres"
FROM
    film f

/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/

SELECT
    concat(c.first_name,
    ' ',
    c.last_name) AS "Nombre_Cliente",
    sum(p.amount) AS "Dinero_gastado"
FROM
    customer c
LEFT JOIN payment p ON
    c.customer_id = p.customer_id
GROUP BY "Nombre_Cliente"
ORDER BY "Dinero_gastado" DESC

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'*/

SELECT
    concat(first_name,
    ' ',
    last_name) AS "Nombre_Actor"
FROM
    actor a
WHERE
    first_name ILIKE 'jOHNNY'
    
/*36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.*/
    
ALTER TABLE customer 
RENAME COLUMN first_name TO Nombre

ALTER TABLE customer 
RENAME COLUMN last_name TO Apellido

/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
*/

SELECT
    actor_id
    --EL MÁS ALTO
FROM
    actor a
ORDER BY
    actor_id DESC
LIMIT 1


SELECT
    actor_id
    --EL MÁS BAJO
FROM
    actor a
ORDER BY
    actor_id ASC
LIMIT 1

/*38. Cuenta cuántos actores hay en la tabla “actor”.
*/

SELECT
    count(actor_id)
FROM
    actor a
    
/*39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.*/

    SELECT
    first_name,
    last_name
FROM
    actor a
ORDER BY
    last_name DESC
    
 /*40. Selecciona las primeras 5 películas de la tabla “film”.*/   
    
SELECT
    title
FROM
    film f
ORDER BY
    film_id ASC
LIMIT 5

/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?*/

SELECT first_name AS "Nombre actor" , COUNT(actor_id) AS "Nº_Repeticiones"
FROM actor a 
GROUP BY first_name 
ORDER BY COUNT(actor_id) DESC

/*42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
*/
SELECT
    concat(c.nombre,
    ' ',
    c.apellido) AS "Nombre_cliente",
    count(rental_id) AS "Número_Alquileres"
FROM
    RENTAL r
JOIN customer c ON
    r.customer_id = c.customer_id
GROUP BY
    "Nombre_cliente"
ORDER BY
    "Número_Alquileres" DESC
    
/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
*/
    
   SELECT
    concat(c.nombre,
    ' ',
    c.apellido) AS "Nombre_cliente",
    count(r.rental_id) AS "Número_Alquileres"
FROM
    customer c
LEFT JOIN rental r ON
    c.customer_id = r.customer_id
GROUP BY
    "Nombre_cliente"
ORDER BY
    "Número_Alquileres" ASC
    
/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
    
SELECT
    *
FROM
    film f
CROSS JOIN category c ON
    f.film_id = fc.film_id
/*El resultado sería útil solo si se necesitase estudiar todas las 
 * combinaciones posibles, al ser categorías las combinaciones entre 
 * category.name y film.title no tienen un gran sentido ya que una película 
 * no puede tener tantas categorías como posibilidades haya. La categoría 
 * de las películas se basa en características propias como 
 * el guión, la trama o la interpretación de los actores por lo que, por ejemplo, 
 * aunque podamos generar la posibilidad de que através de la base de datos
 *  una película de terror generalmente no puede ser una película también de comedia
 * ..a no ser que hablemos de Scary Movie
 * 
 * En conclusión para cruzar estas tablas haría un inner join ya que no
 * podemos relacionar directamente las categorías con las películas y generaríamos
 * datos sin sentido*/

    /*45. Encuentra los actores que han participado en películas de la categoría
'Action'.
*/
    
SELECT
   CONCAT(first_name,
    ' ',
    last_name) AS "Nombre_Actor"
FROM
    actor a
WHERE
    EXISTS (
    SELECT
        1
    FROM
        category c
    WHERE
        name ILIKE 'Action' )
GROUP BY "Nombre_Actor"

   /*/46. Encuentra todos los actores que no han participado en películas.*/

SELECT
    CONCAT(a.first_name,
    ' ',
    a.last_name) AS "Nombre_Actor",
    count(fa.film_id)
FROM
    ACTOR a
LEFT JOIN film_actor fa ON
    a.actor_id = fa.actor_id
GROUP BY
   "Nombre_Actor"
    HAVING 
    count(fa.film_id)= 0

/*47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.
*/
    
SELECT
    CONCAT(a.first_name,
    ' ',
    a.last_name) AS "Nombre_Actor",
    count(fa.film_id) AS "Cantidad_Películas"
FROM
    ACTOR a
LEFT JOIN film_actor fa ON
    a.actor_id = fa.actor_id
GROUP BY
    "Nombre_Actor"
ORDER BY
    "Cantidad_Películas" DESC
    
/*48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.
*/
    
CREATE VIEW “actor_num_peliculas” AS 
SELECT
    a.first_name,
    a.last_name,
    sum(fa.film_id) AS "Número_Películas"
FROM
    ACTOR a
LEFT JOIN film_actor fa ON
    a.actor_id = fa.actor_id
GROUP BY
    a.first_name,
    a.last_name

/*49. Calcula el número total de alquileres realizados por cada cliente.
*/

SELECT
    count(r.rental_id) AS "AlquileresRealizados"
FROM
    customer c
LEFT JOIN rental r ON
    c.customer_id = r.customer_id

/*50. Calcula la duración total de las películas en la categoría 'Action'.
*/

SELECT
    SUM(length)
FROM
    film f
JOIN (film_category fc
JOIN category c ON
    fc.category_id = c.category_id)
    ON
    f.film_id = fc.film_id
WHERE
    c.name ILIKE 'Action'



/*51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.
*/

    CREATE TEMPORARY TABLE cliente_rentas_temporal AS
    SELECT
    c.nombre ,
    c.apellido ,
    count(r.rental_id)AS "RecuentoAlquileres"
FROM
    customer c
LEFT JOIN rental r ON
    c.customer_id = r.rental_id
GROUP BY
    c.nombre ,
    c.apellido

    /*52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces*/
    
CREATE TEMPORARY TABLE “peliculas_alquiladas” AS 
SELECT
    f.title AS "NombrePelícula" ,
    count(r.rental_id) AS "NúmeroAlquileres"
FROM
    film f
JOIN (inventory i
JOIN rental r ON
    i.inventory_id = r.inventory_id)
ON
    f.film_id = i.film_id
GROUP BY
    f.title
HAVING
    count(rental_id) >= 10  

--COMPROBACIÓN
SELECT
    COUNT("NombrePelícula")
FROM
    (
    SELECT
        f.title AS "NombrePelícula" ,
        count(r.rental_id) AS "NúmeroAlquileres"
    FROM
        film f
    JOIN (inventory i
    JOIN rental r ON
        i.inventory_id = r.inventory_id)
ON
        f.film_id = i.film_id
    GROUP BY
        f.title
    HAVING
        count(rental_id) >= 10 )
        
/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.
*/
        

SELECT
    f.title AS "TítuloPelículas",
    concat(c.nombre,
        ' ',
        c.apellido) AS "NombreCliente"
FROM
    film f
JOIN(inventory i
JOIN (rental r
JOIN customer c ON
    r.customer_id = c.customer_id) ON
    i.inventory_id = r.inventory_id) ON
    f.film_id = i.film_id
WHERE 
    concat(c.nombre,
        ' ',
        c.apellido)
     ILIKE 'Tammy Sanders'
AND r.return_date IS null

        
/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/

SELECT
    concat(a.first_name,
    ' ',
    a.last_name)
FROM
    actor a
JOIN (film_actor fa
JOIN( film f
JOIN(film_category fc
JOIN category c ON
    fc.category_id = c.category_id) ON
    f.film_id = fc.film_id) ON
    f.film_id = fa.film_id) ON
    fa.actor_id = a.actor_id
WHERE
    c.name ILIKE 'Sci-Fi'
    
/*55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.
*/
SELECT
    first_name AS "Nombre",
    last_name AS "Apellido"
FROM
    rental r
LEFT JOIN inventory i ON
    r.inventory_id = i.inventory_id
LEFT JOIN film f ON
    f.film_id = i.film_id
LEFT JOIN film_actor fa ON
    fa.film_id = f.film_id
LEFT JOIN actor a ON
    a.actor_id = fa.actor_id
WHERE
    r.rental_date > (
    SELECT
        min(r1.rental_date)
    FROM
        rental r1
    LEFT JOIN inventory i1 ON
        r1.inventory_id = i1.inventory_id
    LEFT JOIN film f1 ON
        f1.film_id = i1.film_id
    LEFT JOIN film_actor fa1 ON
        fa1.film_id = f1.film_id
    LEFT JOIN actor a1 ON
        a1.actor_id = fa1.actor_id
    WHERE
        f1.title ILIKE 'Spartacus Cheaper' )

/*56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.
*/
       
    
SELECT
        a1.first_name AS "Nombre",
        a1.last_name AS "Apellido"
FROM
    actor a1
WHERE
    a1.first_name NOT IN (
    SELECT
        a.first_name AS "Nombre"
    FROM
        category c
    LEFT JOIN film_category fc ON
        C.category_id = FC.category_id
    LEFT JOIN film f ON
        fc.film_id = f.film_id
    LEFT JOIN film_actor fa ON
        f.film_id = fa.film_id
    LEFT JOIN actor a ON
        fa.actor_id = a.actor_id
    WHERE
        C."name" ILIKE 'Music'
    GROUP BY
        a.first_name ,
        a.last_name)
    AND A1.last_name NOT IN (
    SELECT
        a.last_name AS "Apellido"
    FROM
        category c
    LEFT JOIN film_category fc ON
        C.category_id = FC.category_id
    LEFT JOIN film f ON
        fc.film_id = f.film_id
    LEFT JOIN film_actor fa ON
        f.film_id = fa.film_id
    LEFT JOIN actor a ON
        fa.actor_id = a.actor_id
    WHERE
        C."name" ILIKE 'Music'
    GROUP BY
        a.first_name ,
        a.last_name)
        
/*57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.
*/
        
SELECT
    f.title
FROM
    film f
LEFT JOIN inventory i ON
    f.film_id = i.inventory_id
LEFT JOIN rental r ON
    i.inventory_id = r.inventory_id 
WHERE
(EXTRACT(EPOCH FROM (r.return_date - r.rental_date))/ 86400) > 8

/*58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.
*/

SELECT
    title
FROM
    film
WHERE
    title NOT IN 
(
    SELECT
        f.title
    FROM
        film f
    LEFT JOIN film_category fc ON
        f.film_id = fc.film_id
    LEFT JOIN category c ON
        fc.category_id = c.category_id
    WHERE
        c."name" ILIKE 'Animation')

/*59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.
*/
SELECT
    f.TITLE
FROM
    film f
WHERE
    F.length = (
    SELECT
        length
    FROM
        film f2
    WHERE
        f2.title ILIKE 'Dancing Fever')

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido*/
        
SELECT
        c.nombre AS "NOMBRE",
        c.apellido AS "APELLIDO",
    COUNT(DISTINCT(i.film_id)) AS "Recuento_id"
FROM
        customer c
LEFT JOIN rental r ON
        c.customer_id = r.customer_id
LEFT JOIN inventory i ON
        i.inventory_id = r.inventory_id
    GROUP BY c.nombre,c.apellido 
    HAVING COUNT(DISTINCT(i.film_id)) >= 7
    ORDER BY c.apellido asc
       

/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.
*/
SELECT
    c."name" AS "Categoría",
    count(DISTINCT (i.film_id)) AS "Recuento_Películas",
    count(DISTINCT(r.rental_id)) AS "Recuento_Alquileres"
FROM
    category c
LEFT JOIN film_category fc ON
    C.category_id = FC.category_id
LEFT JOIN film f ON
    fc.film_id = f.film_id
LEFT JOIN inventory i ON
    i.film_id = f.film_id
LEFT JOIN rental r ON
    r.inventory_id = i.inventory_id
GROUP BY
    "Categoría"

/*62. Encuentra el número de películas por categoría estrenadas en 2006.
*/

SELECT
    c."name" AS "Categoría",
    count(DISTINCT (i.film_id)) AS "Recuento_Películas"
FROM
    category c
LEFT JOIN film_category fc ON
    C.category_id = FC.category_id
LEFT JOIN film f ON
    fc.film_id = f.film_id
LEFT JOIN inventory i ON
    i.film_id = f.film_id
LEFT JOIN rental r ON
    r.inventory_id = i.inventory_id
WHERE f.release_year = 2006
GROUP BY
    "Categoría"

SELECT DISTINCT release_year FROM film f --validación

/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.
*/
SELECT
    sf.staff_id ,
    sf.first_name,
    sf.last_name,
    s.store_id,
    s.address_id
FROM
    store s
CROSS JOIN staff sf

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/

SELECT
    c.customer_id AS "Id_Cliente",
    c.nombre AS "Nombre",
    c.apellido AS "Apellido",
    count(DISTINCT (i.film_id))
FROM
    customer c
LEFT JOIN rental r ON
    c.customer_id = r.customer_id
LEFT JOIN inventory i ON r.inventory_id =i.inventory_id 
GROUP BY "Id_Cliente","Nombre","Apellido"
