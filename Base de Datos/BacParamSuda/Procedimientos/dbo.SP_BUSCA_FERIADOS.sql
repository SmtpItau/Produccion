USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FERIADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_FERIADOS] (@CodPais INT)
AS
BEGIN
	SELECT t.FER_NEMO,
	       t.FER_DESCRIPCION,
	       t.FER_DIA_FERIADO,
	       t.FER_MES,
	       t.FER_COMPORTAMIENTO_ESPECIAL,
	       t.FER_ID,
	       m.REG_FER_DESC_CORTA,
	       t.FER_ESTADO,
	       t.FER_COD_REGLA_AJUSTE
	FROM   BacParamSuda.dbo.TBL_FestivosFijos t
	       INNER JOIN BacParamSuda.dbo.TBL_ReglasFestivos m	                                  
	ON  t.FER_COD_REGLA_AJUSTE = m.REG_FER_ID
	WHERE t.FER_ORIGEN_PAIS=@CodPais
END

GO
