USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_Buscar1]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TasamConvencional_Buscar1    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[Sp_TasamConvencional_Buscar1] (@cod_pro    char(5),
            @cod_mon   numeric(05),
                   @dias_desde numeric(05))  
AS
BEGIN SET NOCOUNT ON
 SELECT codigo_producto, codigo_moneda, diasdesde           
 FROM TASAS_MAXIMAS_CONVENCIONAL
 WHERE codigo_producto = @cod_pro and codigo_moneda = @cod_mon and diasdesde = @dias_desde
 IF @@ERROR <> 0 
    BEGIN
     SELECT "ERROR"
 END ELSE
    BEGIN
    SELECT "YA EXISTE"
 END
 SET NOCOUNT OFF
END 






GO
