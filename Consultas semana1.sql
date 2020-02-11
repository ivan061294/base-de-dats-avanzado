use Neptuno
go

--1.Variables en T-SQL(L.P. + SQL)
--Creanmos variable
declare @nombre varchar(20)
--Asignamos valor a la variable 
set @nombre = 'hola mundo'
--Mostrar la variable
print @nombre

--Obtener los productor cuyo P.U. sea mayor al 
--Precio Promedio (Neptuno->Productos)
--Declaramos variable
Declare @promedio decimal
--Asignamos valor 
select @promedio=avg(Precio) from Productos
--Mostrar variable 
print @promedio
--Mostrarmos lo que nos piden
select * from Productos where Precio>@promedio
--1b. Mostramos variables globales 
print 'version: ' + @@version
print 'idioma: ' + @@language
print 'nombre del server ' + @@servername
select * from Categorías
insert into Categorías (NombreCategoría,Descripción) values ('toc','toc')
print 'IDENTITY: ' + STR(@@identity)
--Ejemplo con @@ERROR
--Select * from clientes Where idCliente= 'ALFKI'
--Select * from pedidos Where idCliente= 'ALFKI'
delete from Clientes where IdCliente= 'ALFKI'
print 'ERROR: ' + str(@@ERROR)
delete from Clientes where IdCliente= 'AAAAA'
print 'ERROR: ' + str(@@ERROR)
--2. control de flujos
--2.1 else
--Mostrar si un cliente a hecho un pedido o no,
--debe ingresar el codigo del cliente
declare @codCliente char(5)
declare @cantidad int
set @codCliente = 'ALFKI'--asignamos un valor al codigo
--Optenemos la cantidad de pedidos para un cliente
select @cantidad=count (*) from Pedidos
where IdCliente= @codCliente
IF @cantidad=0
	print 'No hay pedidos para el cliente'
else 
	print 'El cliente tiene pedidos ' + str(@cantidad)

go
--Evaluar la existencia de un registro, si existe mostramos 
-- un mensaje, si no existe, lo insertamos, trabajar en la tabla
--categoria 
--select * from Categorías
--insert into Categorías(NombreCategoría) values ('cereales')
--Declaramos la variable nombre 
declare @nombre varchar(50)
--Asignamos un valor a la variable nombre 
set @nombre = 'cereales2'
--verifica la existencia de la categoria de lo contrario lo inserta
IF exists(select * from Categorías where NombreCategoría = @nombre)
	begin
		print 'Esta categoria ya existe...!'
	end
else 
	begin
		insert into Categorías(NombreCategoría) values (@nombre)
		print 'se agrego la categoria'
		select * from Categorías
	end
go
--2.2 case 
--declarar una variable donde se ingrese el numero de mes y 
--devuelva el mes en letras
--declarar variable mes y nombre
declare @mes int 
declare @nombre varchar(50)
--Asignamos valor a la variable @mes
set @mes = 0
set @nombre = (
	case @mes 
		when 0 then 'ENERO'
		when 1 then 'FEBRERO'
		when 2 then 'MARZO'
		when 3 then 'ABRIL'
		when 4 then 'MAYO'
		when 5 then 'JUNIO'
		when 6 then 'JULIO'
		when 7 then 'AGOSTO'
		when 8 then 'SETIEMBRE'
		when 9 then 'OCTUBRE'
		when 10 then 'NOBIEMBRE'
		when 11 then 'DICIEMBRE'
		else 'No es un mes valido'
	END)
print 'Nombre del mes: ' + @nombre

--declarar variable dia y nombre
declare @dia int 
declare @mensaje varchar (30)
declare @nombreD varchar(50)
set @dia = 2
set @mensaje = 'hoy tenemos clases de base de datos'
set @nombreD = (
	case @dia
		when 1 then 'LUNES ' +@mensaje 
		when 2 then 'MARTES ' +@mensaje
		when 3 then 'MIERCOLES '
		when 4 then 'JUEVES '
		when 5 then 'VIERNES '
		when 6 then 'SAVADO '
		when 7 then 'DOMINGO '
		else 'No es un dia valido '
	END)
print 'Nombre del dia: ' +@nombreD

--Mostramos el nombre de una categoria, al momento de ejecutar una consulta
select IdProducto, NombreProducto,
IdCategoría, (
	case IdCategoría
		when 1 then 'Frutas'
		when 2 then 'verduras'
		when 3 then 'celulares'
		when 4 then 'menestras'
		when 5 then 'leguminosas'
		when 6 then 'vitaminas'
		else 'otros'
	end
)as categoria from Productos

--tarea 
--crea una veriable stock minimo(@stokcminimo) y asignale un valor. luego.
--liste todos los productos y muestre en una columna adicional su estado,
--si el stock es ingual al minimo mostrar 'al limite', si es menor
-- mostrar 'haga un pedido', y si es mayor 'stockeado'
 