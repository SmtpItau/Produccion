USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_OPERACIONES_PUENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_OPERACIONES_PUENTE]
   (   @FechaDesde      DATETIME
   ,   @FechaHasta      DATETIME
   ,   @Usuario         VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON
   
   SELECT FechaProceso = convert(char(10),acfecpro ,103)
   ,      FechaEmision = convert(char(10),Getdate(),103)
   ,      HoraEmision  = convert(char(10),Getdate(),108)
   ,      Usuario      = upper(@Usuario)
   INTO   #Parametros
   FROM   MEAC

   SELECT morutcli
   ,      mocodcli
   ,      clnombre
   ,      motipmer
   ,      motipope
   ,      monumope
   ,      mocodmon
   ,      mocodcnv
   ,      momonmo
   ,      moussme
   ,      mouss30
   ,      moticam
   ,      moparme
   ,      motctra
   ,      mopartr
   ,      momonpe
   ,      mocostofo
   ,      moprecio
   ,      mopretra
   INTO   #Operaciones
   FROM   MEMO_PUENTE
          LEFT JOIN BacParamSuda..CLIENTE ON clrut = morutcli AND clcodigo = mocodcli
   WHERE  mofech     BETWEEN @FechaDesde AND @FechaHasta
   AND    moestatus  NOT IN('R','P','A')
   AND    motipmer       IN('EMPR')
   ORDER BY motipope , monumope

   IF EXISTS(SELECT 1 FROM #Operaciones)
   BEGIN
      SELECT * 
      ,      #Parametros.FechaProceso
      ,      #Parametros.FechaEmision
      ,      #Parametros.HoraEmision
      ,      #Parametros.Usuario
      FROM   #Operaciones
      ,      #Parametros

   END ELSE
   BEGIN
   
      SELECT 'morutcli'   = ' '
      ,      'mocodcli'   = ' '   
      ,      'clnombre'   = ' '
      ,      'motipmer'   = ' '
      ,      'motipope'   = ' '
      ,      'monumope'   = ' '
      ,      'mocodmon'   = ' '
      ,      'mocodcnv'   = ' '
      ,      'momonmo'    = ' '
      ,      'moussme'    = ' '
      ,      'mouss30'    = ' '
      ,      'moticam'    = ' '
      ,      'moparme'    = ' '
      ,      'motctra'    = ' '
      ,      'mopartr'    = ' '
      ,      'momonpe'    = ' '
      ,      'mocostofo'  = ' '
      ,      'moprecio'   = ' '
      ,      'mopretra'   = ' '
      ,      #Parametros.FechaProceso
      ,      #Parametros.FechaEmision
      ,      #Parametros.HoraEmision
      ,      #Parametros.Usuario
      FROM   #Parametros

   END

END

GO
