USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_CARGA_CORRESPONSAL]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_TRANSFERENCIA_CARGA_CORRESPONSAL] 
  ( @rutcli  numeric(9) )
as
begin
 set nocount on
   select 
            rut_cliente
            ,codigo_cliente
            ,codigo_moneda
            ,codigo_pais
            ,codigo_plaza
            ,codigo_swift
            ,nombre
            ,cuenta_corriente
            ,swift_santiago
            ,banco_central
            ,fecha_vencimiento
 from VIEW_CORRESPONSAL
 where @rutcli = rut_cliente
 
 set nocount off
end



GO
