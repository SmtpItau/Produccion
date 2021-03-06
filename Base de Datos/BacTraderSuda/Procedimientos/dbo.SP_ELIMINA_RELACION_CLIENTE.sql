USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_RELACION_CLIENTE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_RELACION_CLIENTE]  
                                              (@rut1      numeric(10),
                                 @codigo1   numeric( 3),
                                 @rut2      numeric(10),
            @codigo2   numeric( 3) )
as
begin
      set nocount on
       delete  
         from VIEW_CLIENTE_RELACIONADO
         where @rut1 = clrut_padre and
               @codigo1 = clcodigo_padre  and 
               @rut2 = clrut_hijo  and 
               @codigo2 = clcodigo_hijo
set nocount off
select 'OK'
end
--

GO
