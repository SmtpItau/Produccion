USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_MEDIOS_PAGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SADP_LEER_MEDIOS_PAGO]
	(	
		@nMoneda	INT		= 0		
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @nMoneda > 0
		SELECT mdp.glosa, mdp.codigo
		  FROM BacParamSuda.dbo.MONEDA_FORMA_DE_PAGO	 mfp
		 	   INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO mdp ON mdp.codigo   = mfp.mfcodfor
		 	   INNER JOIN BacParamSuda.dbo.MONEDA		 mna ON mna.mncodmon = mfp.mfcodmon
		 WHERE mfcodmon = @nMoneda
      ORDER BY mdp.glosa

	ELSE
		SELECT mdp.glosa, mdp.codigo
		  FROM BacParamSuda.dbo.FORMA_DE_PAGO mdp
	  ORDER BY mdp.glosa


END
GO
