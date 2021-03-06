USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS_SISTEMA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PARAMETROS_SISTEMA]
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @nvaluf             NUMERIC(19,4)
    DECLARE @nvaldol            NUMERIC(19,4)
    DECLARE @diaspacto          INTEGER

    SET @nvaluf  = 0
    SET @nvaldol = 0
  
    SELECT @nvaluf  = vmvalor
    FROM dbo.VIEW_VALOR_MONEDA, dbo.MDAC
     WHERE vmfecha  = acfecproc
       AND vmcodigo = 998

    SELECT @nvaldol = vmvalor
    FROM dbo.VIEW_VALOR_MONEDA, dbo.MDAC
     WHERE vmfecha  = acfecproc
       AND vmcodigo = 994

    declare @CodigoFPagBCCH   numeric(5) 
    declare @RutBCCH          numeric(13)
    declare @NombreFormaPagoBCCH varchar(30) 
    declare @NombreBCCH       varchar(100)

    select  @CodigoFPagBCCH = 125
    select  @CodigoFPagBCCH      = acFPagoBCCH ,
            @RutBCCH             = acRutBCCH  from dbo.MDAC

    select  @NombreBCCH          = 'BANCO CENTRAL DE CHILE'
    select  @NombreBCCH          = ClNombre from BacParamSuda..Cliente 
        where clrut = @RutBCCH and clCodigo = 1

    select  @NombreFormaPagoBCCH = 'CUENTA CORRIENTE BCCH'
    select  @NombreFormaPagoBCCH = Glosa from BacParamSuda..Forma_de_pago 
        where Codigo = @CodigoFPagBCCH 
  
    SET ROWCOUNT 1
    SELECT 'fecproc'      = CONVERT(CHAR(10),acfecproc,103),
           'acnomprop'    = acnomprop,
           'fecprox'      = CONVERT(CHAR(10),acfecprox,103),
           'acrutprop'    = acrutprop,
           'acdigprop'    = acdigprop,
           'acrutcomi'    = acrutcomi,
           'accomision'   = accomision,
           'aciva'        = aciva,
           'rcrut'        = rcrut,
           'rcdv'         = rcdv,
           'rcnombre'     = rcnombre,
           'valuf'        = @nvaluf,
           'valdol'       = @nvaldol,
           'diasnobcch'   = 7,                                --> 30
           'acpatrimonio' = acpatrimonio,
           'fecante'      = CONVERT(CHAR(10),acfecante,103),
           'acsw_cm'      = acsw_cm,
	   'acRutBCCH'	  = acRutBCCH,
	   'acFPagoBCCH'  = acFPagoBCCH, 
           'acNombreBCCH' = @NombreBCCH,
           'acNombreFPagoBCCH' = @NombreFormaPagoBCCH
            
      FROM dbo.MDAC,
           dbo.VIEW_ENTIDAD
    SET ROWCOUNT 0

    SET NOCOUNT OFF

END

GO
