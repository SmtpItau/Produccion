USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PFE_CCE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_PFE_CCE]( @rut          numeric(10) , 
                              @codigo       numeric(5)  ,
                              @tipo_limite  char(1)     )
as
begin
select plazo_ini,
       plazo_fin,
       monto_asignado
  from MD_PFE_CCE
 where rut         = @rut
   and codigo      = @codigo
   and tipo_limite = @tipo_limite
end   /* fin procedimiento */


GO
