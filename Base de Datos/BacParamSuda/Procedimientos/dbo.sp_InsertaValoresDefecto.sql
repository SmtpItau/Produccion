USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertaValoresDefecto]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_InsertaValoresDefecto]


@moneda as varchar(10),
@producto as varchar(10),
@compra_desde as varchar(10),
@compra_donde as varchar(10),
@venta_desde as varchar(10),
@venta_donde as varchar(10),
@venta_corresponsal as varchar(10),
@compra_corresponsal as varchar(10)

as

declare @existe int

set @existe = (select count(*) from valoresdefecto where moneda = @moneda and producto = @producto)


if @existe > 0 

	update valoresdefecto 
	set moneda		 = @moneda,
		producto	 = @producto,
		compra_desde = @compra_desde,
		compra_donde = @compra_donde,
		venta_desde  = @venta_desde,
		venta_donde  = @venta_donde,
		venta_corresponsal = @venta_corresponsal,
		compra_corresponsal = @compra_corresponsal
	where moneda = @moneda and producto = @producto

else 
	insert into valoresdefecto (moneda, producto, compra_desde, compra_donde, venta_desde,venta_donde, venta_corresponsal, compra_corresponsal)
				values  	  (@moneda, @producto, @compra_desde, @compra_donde, @venta_desde, @venta_donde, @venta_corresponsal,@compra_corresponsal)


GO
