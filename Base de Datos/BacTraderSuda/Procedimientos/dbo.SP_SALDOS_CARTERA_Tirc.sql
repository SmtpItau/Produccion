USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_CARTERA_Tirc]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_SALDOS_CARTERA_Tirc]
AS
BEGIN
SET NOCOUNT ON
	DECLARE @MinRec INT,
		@MaxRec INT,
		@nCtaAux CHAR(8),
		@cCuenta CHAR(8)

	SELECT A.CUENTA,
	       'CUENTASUP' = Max(A.CUENTASUP),
	       B.DESCRIPCION,
               A.UMMONTO,
	       'mnnemo'=(CASE WHEN A.UMMONTO in(994,995) THEN 'US.X' ELSE mnnemo END),
	       'SALDO'=CONVERT(NUMERIC(19,3),SUM(A.SALDO))

	INTO #Tmp
	FROM   SALDOS_CARTERA          A
	LEFT JOIN  
	       VIEW_PLAN_DE_CUENTA     B ON a.CUENTA = b.cuenta 
	     INNER JOIN  VIEW_MONEDA c ON c.mncodmon = a.UMMONTO
	       , MDAC
	GROUP BY A.cuenta,A.ummonto,B.DESCRIPCION,mnnemo
        order by a.cuenta


	select CUENTA,
	       'CUENTASUP' = Space(10),
	       'DESCRIPCION' = min(DESCRIPCION),
               'UMMONTO' = Min(UMMONTO),
	       Mnnemo,
	       'SALDO'= ROUND(Sum(SALDO),2),
	       'fecha' = convert(char(10),min(acfecproc),103),
	       'hora'  = convert(char(8),getdate(),108),
               'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --Min(acnomprop),
               'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,min(acrutprop)),1),1,10),',','.')+ '-'+min(acdigprop),
	       Flag   = IDENTITY(INT)
	Into #Tmp2
	from #TMP , mdac
        group by cuenta,mnnemo
	Order by cuenta,mnnemo


	/* Este Ciclo es para actualizar la cuenta super solo en el primer registro del grupo por codigo de cuenta */
	SELECT @MinRec = Min(Flag) From #Tmp2
	SELECT @MaxRec = Max(Flag) From #Tmp2
	SELECT @nCtaAux = ''
	WHILE @MinRec <= @MaxRec
	BEGIN
		SELECT @cCuenta = '*'
		Select @cCuenta = CUENTA FROM #Tmp2 Where Flag = @MinRec

		IF @cCuenta = '*' BREAK

		iF @cCuenta <> @nCtaAux Begin
		   SET ROWCOUNT 1

   		   UPDATE #Tmp2
		   SET CUENTASUP = Isnull(Cuenta_Supoer,' ')
   		   FROM  view_tabla_glcode
		   WHERE Cuenta_Glcode = @cCuenta and Flag = @MinRec

		   SET ROWCOUNT 0

		   SELECT @nCtaAux = @cCuenta
		End
		SELECT @MinRec = @MinRec + 1
	END


	DECLARE @COUNT INT
    SET @COUNT = (SELECT COUNT(*) FROM #TMP2)


  IF @COUNT <> 0
  BEGIN



	select CUENTA,
	       CUENTASUP,
	       DESCRIPCION,
               UMMONTO,
	       Mnnemo,
	       SALDO,
	       fecha,
	       hora,
               NomProp,
               RutProp
	from #TMP2

  END

  ELSE

  BEGIN

	select CUENTA = '',
	       CUENTASUP = '',
	       DESCRIPCION = '',
               UMMONTO = '',
	       Mnnemo = '',
	       SALDO = '',
	       fecha = '',
	       hora = '',
               NomProp = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --Min(acnomprop),
               RutProp = ''

  END
   
SET NOCOUNT off      
END
-- Base de Datos --

GO
