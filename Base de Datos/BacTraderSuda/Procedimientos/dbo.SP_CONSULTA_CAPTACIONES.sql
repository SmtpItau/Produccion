USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CAPTACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSULTA_CAPTACIONES](@fecha_proceso datetime)
as
begin
 set nocount on
   select numero_operacion  ,
          'cliente'=clnombre  ,
          fecha_operacion   ,
          tasa     ,
          moneda           ,
          fecha_vencimiento   ,
          'entidad' = rcnombre
          from GEN_CAPTACION,VIEW_CLIENTE,VIEW_ENTIDAD where fecha_vencimiento > @fecha_proceso and
                                             rut_cliente       = clrut          and
                                             entidad           = rccodcar       order by numero_operacion
          
          
 
end


GO
