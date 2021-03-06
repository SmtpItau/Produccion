USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DATOS_OPERACION_CALCE_VALUTAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_TRAE_DATOS_OPERACION_CALCE_VALUTAS]
(
	@moneda CHAR(2)
)
AS
BEGIN

	select CASE WHEN @moneda = 'MX' THEN MOVALUTA1 
		    WHEN @moneda = 'PE' THEN MOVALUTA2
		END
	  from baccamsuda..memo
       where motipmer  = 'CCBB' 
	 and moterm    = 'CORREDORA'
         and MOESTATUS = ''     -- ingresadas y aprobadas
         and MOFECH    = ( select ACFECPRO from MEAC )
	group by CASE WHEN @moneda = 'MX' THEN MOVALUTA1 
		    WHEN @moneda = 'PE' THEN MOVALUTA2
		END
		
END



GO
