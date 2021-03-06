USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DATOS_OPERACION_CALCE_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_TRAE_DATOS_OPERACION_CALCE_SPOT]
(
	@tipoOperacion  char(1),
	@Moneda 	char(3)  = '',
	@Valuta		char(8)  = '',
	@Estado		smallint = Null
)
AS
BEGIN

	select 
		MONUMOPE,
		MOTIPOPE,
		MONOMCLI,
		MOCODMON, 
		MOMONMO,
		'MOMONPE' = (MOPRETRA * MOMONMO),
		MOENTRE,
		fp.glosa,
		MOVALUTA1,
		MORECIB,
		fp2.glosa,
		MOVALUTA2,
		'TCierre' = MOTICAM,
		'TCCosto' = MOTCTRA,
		'ASIGNADA'=CASE WHEN MONUMFUT != 0 THEN '*' ELSE '' END
        from baccamsuda..memo 
		left join BacParamSuda..FORMA_DE_PAGO FP  ON fp.codigo = MOENTRE
		left join BacParamSuda..FORMA_DE_PAGO FP2 ON fp2.codigo = MORECIB
       where motipmer  = 'CCBB' 
		 and moterm    = 'CORREDORA'
		 and morutcli  != 96665450 and morutcli  != 97023000
         and MOESTATUS =  ''     -- ingresadas y aprobadas
		 and (MOTIPOPE  = @tipoOperacion or @tipoOperacion = 'A')
         and MOFECH = ( select ACFECPRO from MEAC )
		 and fp.codigo     = MOENTRE
		 and fp2.codigo    = MORECIB
		 and ( ( @Moneda = 'USD' and MOVALUTA1 = @Valuta) or ( @Moneda = 'CLP' and MOVALUTA2 = @valuta) or @Moneda = '')
		 and ( @Estado is Null  or ( @Estado = 0 and MONUMFUT = @Estado) or (@Estado = 1 and MONUMFUT > 0) )

END



GO
