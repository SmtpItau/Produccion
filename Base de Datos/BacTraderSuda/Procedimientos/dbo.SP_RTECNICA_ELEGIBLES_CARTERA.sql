USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_ELEGIBLES_CARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RTECNICA_ELEGIBLES_CARTERA]
AS
BEGIN
 SET NOCOUNT ON
 
 --declaracion de variables locales 
 DECLARE @uf  FLOAT,
  @fecproc  DATETIME,
  @oficina  CHAR(50),
  @n_oficina NUMERIC,
  @codigo_fec NUMERIC,
  @institucion CHAR(100)
 
 SELECT  @oficina    = 'GCIA.REC.FINANCIEROS',
  @n_oficina  = 964,
  @codigo_fec = 26301
 --recupero el valor de la uf
 SELECT  @uf = isnull(VMVALOR,0)
 FROM  view_valor_moneda , mdac
 WHERE  vmcodigo = 998 AND vmfecha = acfecproc
 
 --recupero la fecha de proceso
 SELECT  @fecproc  = acfecproc,
  @institucion  = acnomprop
 FROM  mdac

 set @institucion = (select RazonSocial from bacparamsuda.dbo.Contratos_ParametrosGenerales)
 
 SELECT  'codigo' = codigo,
  'glosa'  = glosa,
  'mayor'  = mayor,
  'hasta90' = CONVERT( NUMERIC( 19 ), 0 ),
  'mas90'  = CONVERT( NUMERIC( 19 ), 0 )
 INTO #temporal
 FROM tbtr_cod_elg
 
 --montos para la cuenta 193
 UPDATE  #temporal
 SET hasta90 = isnull(( SELECT SUM( ROUND(cpvalvenc / 1000 ,0)) FROM MDCP WHERE cpcodigo = 6 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
  mas90   = isnull(( SELECT SUM( ROUND(cpvalvenc / 1000 ,0)) FROM MDCP WHERE cpcodigo = 6 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
 WHERE  codigo = 1
 --montos para la cuenta '195E'
 UPDATE  #temporal
 SET hasta90 = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 7 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
  mas90   = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 7 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
 WHERE  codigo = 2
 --montos para la cuenta '1.926'
 UPDATE  #temporal
 SET hasta90 = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 4 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
  mas90   = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 4 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
 WHERE  codigo = 17
 --montos para la cuenta '1.926'
 UPDATE  #temporal
 SET hasta90 = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 300 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
  mas90   = isnull(( SELECT SUM( ROUND(cpvalvenc*@UF/1000,0)) FROM MDCP WHERE cpcodigo = 300 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
 WHERE  codigo = 18
 SELECT  *,
  @oficina  AS oficina,
  @n_oficina AS n_oficina,
  @codigo_fec AS codigo_fec,
  @fecproc AS fecha,
  @institucion AS institucion
 FROM  #temporal 
 ORDER BY codigo
 
 SET NOCOUNT OFF
END

GO
