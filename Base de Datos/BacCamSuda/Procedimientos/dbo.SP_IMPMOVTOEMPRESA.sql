USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPMOVTOEMPRESA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPMOVTOEMPRESA]
                  (
                  @Entidad  NUMERIC (10),
                  @TipOpe   CHAR(1)     , -- = ''
                  @OPERADOR CHAR(30)    ,
                  @DESDE    CHAR(10)    ,
                  @HASTA    CHAR(10)    
                  )
AS BEGIN
SET NOCOUNT ON
DECLARE @CONSULT     VARCHAR(255)
DECLARE @xNomprop    CHAR(50)
DECLARE @xRutprop    NUMERIC(09)
DECLARE @xDigprop    CHAR(01)
DECLARE @acfecproc   CHAR(10),
        @acfecprox   CHAR(10),
        @uf_hoy      FLOAT,
        @uf_man      FLOAT,
        @ivp_hoy     FLOAT,
        @ivp_man     FLOAT,
        @do_hoy      FLOAT,
        @do_man      FLOAT,
        @da_hoy      FLOAT,
        @da_man      FLOAT,
        @acnomprop   CHAR(40),
        @rut_empresa CHAR(12),
        @hora        CHAR(8),
        @ENTREGAMOS  CHAR(40),
        @RECIBIMOS   CHAR(40),
        @oma         CHAR(3),
        @FecDesde    DATETIME,
        @FecHasta    DATETIME

   SELECT @xNomprop = acnombre,
          @xRutprop = acrut,
          @xDigprop = acdv
   FROM meac

   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
           @oma         OUTPUT

   SELECT @FecDesde = CONVERT(DATETIME, @DESDE)
   SELECT @FecHasta = CONVERT(DATETIME, @HASTA)

   SELECT  @CONSULT = 'SELECT * FROM #temp1 ORDER BY TipoOpera,NombreCliente,NoOpera'
--   SELECT  @CONSULT = 'SELECT * FROM #temp1 ORDER BY TipoOpera'
   SELECT 'CodigoEmisor'  = 0,
          'DigChkEmisor'  = SPACE(1),
          'NombreEmisor'  = SPACE(40),
          'NombreCliente' = a.clnombre,
          'Tacfecpro'     = mofech,
          'NoOpera'       = monumope,
          'TipoOpera'     = motipope,
          'MonedaOpera'   = mocodmon,
          'MontoOpera'    = momonmo,
          'PariCie'       = moparme ,
          'PariCos'       = mopartr,
          'MontoUSD'      = moussme,
          'Hoyfecha'      = CONVERT(CHAR(10),mofech,103),
          'Hora'          = mohora,
          'TipoCamCie'    = moticam,
          'TipoCamCos'    = motctra,
          'MontoCLP'      = momonpe,
          'OmaBCCH'       = mocodoma,
          'Usuario'       = mooper,
          'MontoCierre'   = ROUND(moussme*motctra,4),
          'RutEmisor'     = 0,
          'DESDE'         = CONVERT(CHAR(10),@FecDesde,103),
          'HASTA'         = CONVERT(CHAR(10),@FecHasta,103),
          'ENTREGAMOS'    = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE ),
          'RECIBIMOS'     = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
          'rcnombre'      = c.rcnombre,
          'acfecproc'     = @acfecproc,
          'acfecprox'     = @acfecprox,
          'uf_hoy'        = @uf_hoy,
          'uf_man'        = @uf_man,
          'ivp_hoy'       = @ivp_hoy,
          'ivp_man'       = @ivp_man,
          'do_hoy'        = @do_hoy,
          'do_man'        = @do_man,
          'da_hoy'        = @da_hoy,
          'da_man'        = @da_man,
          'pmnomprop'     = @acnomprop,
          'rut_empresa'   = @rut_empresa,
          'fecha_SERV'    = CONVERT( CHAR(10) , GETDATE(), 103),
		  'RazonSocial'   = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
   INTO #temp1
   FROM  memo                            ,
         BacParamSuda..cliente       AS a,
         BacTraderSuda..view_entidad AS c
   WHERE morutcli  =  a.clrut       AND
         mocodcli  =  a.clcodigo    AND
         motipmer  =  'EMPR'        AND
        (@Entidad  =  0             OR
         @Entidad  =  moentidad)    AND
        (moestatus =  ' '           OR
         moestatus =  'M')          AND
         mofech    >= @FecDesde     AND
         mofech    <= @FecHasta
--   ORDER BY motipope
   UNION        
   SELECT 'CodigoEmisor'  = 0,
          'DigChkEmisor'  = SPACE(1),
          'NombreEmisor'  = SPACE(40),
          'NombreCliente' = a.clnombre,
          'Tacfecpro'     = mofech,
          'NoOpera'       = monumope,
          'TipoOpera'     = motipope,
          'MonedaOpera'   = mocodmon,
          'MontoOpera'    = momonmo,
          'PariCie'       = moparme ,
          'PariCos'       = mopartr,
          'MontoUSD'      = moussme,
          'Hoyfecha'      = CONVERT(CHAR(10),mofech,103),
          'Hora'          = mohora,
          'TipoCamCie'    = moticam,
          'TipoCamCos'    = motctra,
          'MontoCLP'      = momonpe,
          'OmaBCCH'       = mocodoma,
          'Usuario'       = mooper,
          'MontoCierre'   = ROUND(moussme*motctra,4),
          'RutEmisor'     = 0,
          'DESDE'         = CONVERT(CHAR(10),@FecDesde,103),
          'HASTA'         = CONVERT(CHAR(10),@FecHasta,103),
          'ENTREGAMOS'    = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE ),
          'RECIBIMOS'     = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
          'rcnombre'      = c.rcnombre,
          'acfecproc'     = @acfecproc,
          'acfecprox'     = @acfecprox,
          'uf_hoy'        = @uf_hoy,
          'uf_man'        = @uf_man,
          'ivp_hoy'       = @ivp_hoy,
          'ivp_man'       = @ivp_man,
          'do_hoy'        = @do_hoy,
          'do_man'        = @do_man,
          'da_hoy'        = @da_hoy,
          'da_man'        = @da_man,
          'pmnomprop'     = @acnomprop,
          'rut_empresa'   = @rut_empresa,
          'fecha_SERV'    = CONVERT( CHAR(10) , GETDATE(), 103),
		  'RazonSocial'   = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)  
   FROM  memoh                            ,
         BacParamSuda..cliente       AS a,
         BacTraderSuda..view_entidad AS c
   WHERE morutcli  =  a.clrut       AND
         mocodcli  =  a.clcodigo    AND
         motipmer  =  'EMPR'        AND
        (@Entidad  =  0             OR
         @Entidad  =  moentidad)    AND
        (moestatus =  ' '           OR
         moestatus =  'M')          AND
         mofech    >= @FecDesde     AND
         mofech    <= @FecHasta
   ORDER BY motipope



   UPDATE #temp1
   SET RutEmisor    = @xrutprop ,
       CodigoEmisor = accodigo  ,
       DigChkEmisor = @xdigprop ,
       NombreEmisor = @xnomprop
   FROM meac, view_cliente
   WHERE acrut = clrut

   EXECUTE (@CONSULT)
SET NOCOUNT OFF
END


GO
