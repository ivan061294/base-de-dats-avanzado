use neptuno
create procedure usp_pedidos
@idempleado int,
@monto decimal output
as 
begin
declare
@cantidad int
select @cantidad= count(*)from Pedidos where IdEmpleado=@idempleado
select @monto=sum(a.PrecioUnidad*a.Cantidad-a.Descuento) from detalles as a inner join pedidos as b on (b.IdPedido=a.IdPedido)where b.IdEmpleado=@idempleado
end
go
--llamar
declare @m decimal
exec usp_pedidos 1,@m output
print str(@m)
go
--5. crear un procedimiento que devuelva en numero de productos 
-- de una determinada categoria
create procedure productos_x_categoria
@idcategoria int,
@cantidad int output
as
begin
select @cantidad= count(*) from productos where IdCategoría=@idcategoria
end
go
declare @cant int
exec productos_x_categoria 1,@cant output
print str(@cant)
--6.cree un procedimiento que muestre el total de pedidos por cliente,para un año determinadao
--(utilice parametros de salida)
select * from Clientes
select * from pedidos as p inner join Clientes as b on b.IdCliente=p.IdCliente where year(p.FechaPedido)=1997
alter procedure total_pedidos
@cliente nvarchar(8),
@año int,
@total int output
as
begin
select @total=count(*) from pedidos where IdCliente=@cliente and year(FechaPedido)=@año 
end
go
declare @tot int
exec total_pedidos'ROMEY',1996,@tot output
print str(@tot)
select * from Pedidos
alter function prueba()
returns int
as 
begin
declare @monto int

select @monto= avg(Cargo)from Pedidos
return @monto
end
go
print prueba()

--1. crear una funcion que devuelva la maxima cantidad de productos pedidos
create function dbo.max_cantidad()
returns int
as
begin
declare @maxi int
select @maxi= max(cantidad) from detalles
return @maxi
end
go
print dbo.max_cantidad()
select * from Empleados
select max(stock) as 'stock_max',dbo.max_cantidad() as 'cant_max' from productos
--2.defina una funcion donde ingrese el idempleado y retorne la cantidad de pedido registrado
create function dbo_cant_pedidos(@id int)
returns int
as
begin
declare @cant int
select @cant=count(*)from pedidos where IdEmpleado=@id
return @cant
end
go
select dbo.dbo_cant_pedidos(1)
print 'la cantidad de pedidos de este empleado es:     '+str(dbo.dbo_cant_pedidos(1))
select IdEmpleado,Apellidos,Nombre,dbo.dbo_cant_pedidos(IdEmpleado)as 'cantidad de pedido de empleado' from Empleados
--3. crear una funcion que devuelva la cantidad de productos por categoria
create function dbo.cant_productos(@id_categoria int)
returns int
as
begin
declare @cant int
select @cant= count(*)from Productos where IdCategoría=@id_categoria
return @cant
end
go
select dbo.cant_productos(5)
print'la cantidad de productos de esta categoria es:     '+str( dbo.cant_productos(5))
--4. crear una funcion que retorne una tabla
--defina una funcion que liste todos los clientes
create function dbo.listadoclientes()
returns table
as
 return (select IdCliente as 'cucho gil',NombreCompañía as 'juan gil' from Clientes)
go
select*from dbo.listadoclientes()