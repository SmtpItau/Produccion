USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_VCTOS_INTERBANCARIOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_REPORTES_VCTOS_INTERBANCARIOS] 
       (
        @cFecha      CHAR(08)
       )
AS
BEGIN
   SET NOCOUNT ON
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM MDAC                
   DECLARE @dFecha      DATETIME
   SELECT @dFecha = @cFecha

   SELECT       'Numero_Documento'       = cinumdocu,
                'Numero_Operacion'       = cinumdocu,
                'Interbancario'          = ciinstser,
                'Fecha_Inicio'           = CONVERT( CHAR(10), cifecinip, 103 ) ,
                'C_Moneda_Pacto'         = cimonpact,
                'Moneda_Pacto'           = mnnemo,
                'Valor_Inicial_UM'       = case when cimonpact=994 or cimonpact=998 then round(civalinip/isnull((select vmvalor from view_valor_moneda where vmcodigo=cimonpact and vmfecha=cifecinip),1),mndecimal)
                                           else round(civalinip,mndecimal) end,
                'Tasa_Pacto'             = citaspact,
                'Fecha_Vencimiento'      = CONVERT( CHAR(10), cifecvenp, 103 ),
                'Valor_Vencimiento_UM'   = round(civalvenp,mndecimal),
                'Diferencia'             = case when cimonpact=994 or cimonpact = 998  then round(civalvenp - (civalinip/isnull((select vmvalor from view_valor_moneda where vmcodigo=cimonpact and vmfecha=cifecinip),1)),mndecimal)
                                           else round(civalvenp - civalinip,mndecimal)  end, 
                'Nombre_del_Cliente'     = clnombre,
                'Forma_Pago_Vencimiento' = glosa,
                'Fecha_Hasta'            = CONVERT( CHAR(10), @dFecha, 103 ),
                'Hora'                   = CONVERT( CHAR(10), GETDATE(), 108 ),
  'BANCO'    = @ACNOMPROP,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          INTO  #temp1
          FROM  mdci, VIEW_MONEDA, VIEW_CLIENTE, VIEW_FORMA_DE_PAGO
          WHERE (ciinstser  = 'ICAP'      OR
                 ciinstser  = 'ICOL')    AND
                cimonpact   = mncodmon   AND
                cirutcli    = clrut      AND
                cicodcli    = clcodigo   AND
                ciforpagv   = codigo     AND
                cifecvenp  <= @cFecha
   IF (SELECT COUNT(*) FROM #temp1 WHERE Interbancario = 'ICAP') = 0
   BEGIN
      Insert INTO #Temp1
      SELECT    0,
                0,
                'ICAP',
                '',
                0,
                '',
                0,
                0,
                '',
                0,
                0,
                '',
                '',
                CONVERT( CHAR(10), @dFecha, 103 ),
                CONVERT( CHAR(10), GETDATE(), 108 ),
  @ACNOMPROP,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   END
   IF (SELECT COUNT(*) FROM #temp1 WHERE Interbancario = 'ICOL') = 0
   BEGIN
      Insert INTO #Temp1
      SELECT    0,
                0,
                'ICOL',
                '',
                0,
                '',
                0,
                0,
                '',
                0,
                0,
                '',
                '',
                CONVERT( CHAR(10), @dFecha, 103 ),
                CONVERT( CHAR(10), GETDATE(), 108 ),
  @ACNOMPROP,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   END
   SELECT * FROM #Temp1
   SET NOCOUNT OFF
END

GO
