USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA] ( @fecha_operacion datetime  ,
     @moneda          char (8)  )
as
begin
declare @fechacal datetime
declare @fechamax datetime
select @fechamax = max(fecha_vencimiento) from GEN_OPERACIONES where moneda = @moneda and
             fecha_vencimiento >= @fecha_operacion
--while 
--begin
--end
end   /* fin procedimiento */


GO
