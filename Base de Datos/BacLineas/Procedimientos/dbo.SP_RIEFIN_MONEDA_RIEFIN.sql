USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_MONEDA_RIEFIN]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_MONEDA_RIEFIN]
( @Codigo numeric(5)
 ) 
As 
Begin 
-- SP_RIEFIN_MONEDA_RIEFIN 528
-- SP_RIEFIN_MONEDA_RIEFIN 999
-- SP_RIEFIN_MONEDA_RIEFIN 998
    SET NOCOUNT ON    
    declare @Hay numeric(1)
    set @Hay = 0
    select @Hay = 1  from ParametrosDboParametrizacion_Monedas where Codigo_BAC = @Codigo
    if @@ROWCOUNT = 0 
    begin
		select Codigo = -10        
        INSERT DEBUG_VALORES 
         Select  'Referencia Moneda que no está en ParametrosDboParametrizacion_Monedas'
               , @Codigo
               , '' , 0
    end
    else
        select Codigo  from ParametrosDboParametrizacion_Monedas where Codigo_BAC = @Codigo
End

SET ANSI_NULLS ON
GO
