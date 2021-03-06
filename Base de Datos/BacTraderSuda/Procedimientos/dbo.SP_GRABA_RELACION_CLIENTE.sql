USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_RELACION_CLIENTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_RELACION_CLIENTE](  @rut1      numeric(10),
                               @codigo1   numeric( 3),
                               @rut2      numeric(10),
          @codigo2   numeric( 3),
          @porc      float      )
as
begin
      set nocount on
    if exists(select * from VIEW_CLIENTE_RELACIONADO where @rut1 = clrut_padre and @codigo1 = clcodigo_padre  and @rut2 = clrut_hijo  and @codigo2 = clcodigo_hijo) begin  
       update VIEW_CLIENTE_RELACIONADO set clrut_padre    = @rut1    ,
                         clcodigo_padre = @codigo1 ,
           clrut_hijo     = @rut2    ,
              clcodigo_hijo  = @codigo2 ,
                  clporcentaje   = @porc
       where @rut1 = clrut_padre and @codigo1 = clcodigo_padre  and @rut2 = clrut_hijo  and @codigo2 = clcodigo_hijo
    end else begin
       insert into VIEW_CLIENTE_RELACIONADO(clrut_padre    ,
                          clcodigo_padre ,
            clrut_hijo     ,
               clcodigo_hijo  ,
                   clporcentaje   
                             ) 
                        values ( @rut1    ,
                          @codigo1 ,
            @rut2    ,
               @codigo2 ,
                   @porc
   )
    end
    set nocount off
    SELECT 'OK'
    return
end

GO
