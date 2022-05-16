USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTA_CORRESPONSALES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTA_CORRESPONSALES]
As
Begin
SET NOCOUNT ON
Declare @Rut_Bco Numeric(10)

 SELECT  @Rut_Bco = acrutprop  
 FROM view_mdac

 SELECT CODIGO_CONTABLE,NOMBRE
 FROM  CORRESPONSAL
 WHERE CODIGO_CONTABLE > 0
 And rut_cliente    = @Rut_Bco
 And codigo_cliente = 1

SET NOCOUNT OFF
End

GO
