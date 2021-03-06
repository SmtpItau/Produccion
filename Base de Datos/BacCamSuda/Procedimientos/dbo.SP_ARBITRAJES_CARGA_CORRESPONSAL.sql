USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBITRAJES_CARGA_CORRESPONSAL]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ARBITRAJES_CARGA_CORRESPONSAL]
                                                ( @rut       NUMERIC(9) 
                                                 ,@COD_MONEDA NUMERIC(5)
                                                 )
AS
BEGIN
 SELECT 
     codigo_cliente
  ,codigo_moneda
  ,codigo_pais
  ,codigo_plaza
  ,cod_corresponsal
  ,nombre
  ,cuenta_corriente
  ,banco_central
  ,fecha_vencimiento
                ,codigo_corres
 FROM VIEW_CORRESPONSAL
 WHERE rut_cliente   = @rut AND 
              codigo_moneda = @COD_MONEDA 
END

GO
