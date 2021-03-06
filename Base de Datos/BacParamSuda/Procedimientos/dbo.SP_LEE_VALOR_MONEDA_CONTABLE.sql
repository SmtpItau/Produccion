USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_VALOR_MONEDA_CONTABLE] 
                             ( @NCODMON NUMERIC(03,00),
                               @DFECHA  DATETIME   )
AS
BEGIN
 DECLARE @NVALMON NUMERIC(19,04)
SET NOCOUNT ON
 IF @NCODMON = 999				/* 999 = CLP */
            SELECT @NVALMON = 1
   ELSE    
          SELECT  @NVALMON= Tipo_Cambio
  FROM 
	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
  WHERE 
   Codigo_Moneda=@NCODMON 
  AND  Fecha=@DFECHA
 IF @NVALMON IS NULL  SELECT @NVALMON= 0
 SELECT @NVALMON
SET NOCOUNT OFF
END

GO
