USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDO_CUENTAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SALDO_CUENTAS]( @parametro  FLOAT )
AS
BEGIN
SET NOCOUNT ON
      SELECT 'Cuenta'         = a.CUENTA         ,             
             'NombreCuenta'   = c.descripcion    ,
             'SaldoBanco'     = a.SALDO_BANCO * ( CASE WHEN LEFT( a.CUENTA , 1 ) = '1' OR  LEFT( a.CUENTA , 1 ) = '2' THEN 1 ELSE -1 END ) ,     
             'SaldoBac'       = a.SALDO_BAC   * ( CASE WHEN LEFT( a.CUENTA , 1 ) = '1' OR  LEFT( a.CUENTA , 1 ) = '2' THEN 1 ELSE -1 END ) ,     
             'Moneda'         = a.MONEDA         ,
             'Imprime'        = a.IMPRIME        ,
             'TipoBrecha'     = a.TIPO_BRECHA    ,
             'Nombre_Cliente' = b.ACNOMPROP      ,
             'Fechadatos'     = b.acfecante  , 
             'FechaProceso'   = b.acfecproc  , 
      'nombre_entidad' = b.acnomprop,
             'Diferencia'     = a.SALDO_BANCO - a.SALDO_BAC ,
             'Hora'           = CONVERT( CHAR(10),getdate(), 108 )       
      INTO #TEMPO   
      FROM SALDO_CUENTAS a      ,
           MFAC  b              ,
           view_plan_de_cuenta c
      WHERE IMPRIME = 1 and
            a.cuenta = c.cuenta
 UPDATE #TEMPO SET Diferencia  = SaldoBanco - SaldoBac
      IF EXISTS( SELECT * FROM #TEMPO ) 
  BEGIN
        IF @PARAMETRO = 1 
           SELECT * FROM #TEMPO ORDER BY CUENTA
        IF @PARAMETRO = 2
           SELECT * FROM #TEMPO ORDER BY MONEDA
        IF @PARAMETRO = 3 
           SELECT * FROM #TEMPO ORDER BY TIPOBRECHA      
  END
      ELSE
  BEGIN
        SELECT 'Cuenta'         = '',             
               'NombreCuenta'   = '',
               'SaldoBanco'     = 0,     
               'SaldoBac'       = 0,
               'Moneda'         = 0,
               'Imprime'        = 0,
               'TipoBrecha'     = ''    ,
               'Nombre_Cliente' = b.ACNOMPROP      ,
               'Fechadatos'     = b.acfecante  , 
               'FechaProceso'   = b.acfecproc  ,  
        'nombre_entidad' = b.acnomprop,
               'Diferencia'     = 0,
               'Hora'           = CONVERT( CHAR(10),GETDATE(), 108 )       
       FROM    mfac  b
  END
           
        
SET NOCOUNT OFF    
END

GO
