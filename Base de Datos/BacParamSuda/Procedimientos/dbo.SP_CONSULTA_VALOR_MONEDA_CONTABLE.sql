USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONSULTA_VALOR_MONEDA_CONTABLE] 
                             ( @NCODMON NUMERIC(03,00),
                               @DFECHA  DATETIME   )
AS
BEGIN
	DECLARE @NVALMON NUMERIC(19,04)
	SET NOCOUNT ON
	 IF @NCODMON = 999				/* 999 = CLP */
				SET @NVALMON = 1
	   ELSE    
				SELECT  @NVALMON= Tipo_Cambio
				FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
				WHERE Codigo_Moneda=@NCODMON AND  Fecha=@DFECHA
	 IF @NVALMON IS NULL  SET @NVALMON= 0
	 
	 
	 SELECT 'Tipo_Cambio' =@NVALMON
	 
	SET NOCOUNT OFF
END

GO
