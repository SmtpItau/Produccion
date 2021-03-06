USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_RUT_CORRESPONSAL]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_RUT_CORRESPONSAL](@Rut_Cliente     NUMERIC(9,0),   
    @Codigo_Cliente     numeric   (  9)
          )
AS
BEGIN
set nocount on
   SELECT       Rut_Cliente ,
         Codigo_Cliente ,
                Codigo_Moneda ,
  Codigo_Nemo ,
  Nombre_Corresponsal,
         Cuenta_Corresponsal   ,
  Codigo_SWIFT 
   
          FROM  cliente_corresponsal     WHERE Rut_Cliente= @Rut_Cliente
                         and  Codigo_Cliente = @Codigo_Cliente
SET NOCOUNT OFF
END 

GO
