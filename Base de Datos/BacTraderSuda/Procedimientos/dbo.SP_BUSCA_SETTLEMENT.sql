USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_SETTLEMENT]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_SETTLEMENT]( @rut          numeric(10) , 
                                 @codigo       numeric(5)  )
as
begin
select plazo_ini,
       plazo_fin,
       monto_asignado
  from MD_SETTLEMENT
 where rut         = @rut
   and codigo      = @codigo
end   /* fin procedimiento */

GO
