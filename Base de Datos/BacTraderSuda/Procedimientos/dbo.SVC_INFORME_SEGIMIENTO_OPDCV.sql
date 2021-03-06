USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INFORME_SEGIMIENTO_OPDCV]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_INFORME_SEGIMIENTO_OPDCV]
   (   @Usuario        VARCHAR(15) = 'ADMINISTRA'
   ,   @FechaEvto1     DATETIME    = ''
   ,   @FechaEvto2     DATETIME    = ''
   ,   @NumDocu        NUMERIC(9)  = 0
   ,   @Correla        NUMERIC(9)  = 0
   ,   @SegUser        VARCHAR(15) = ''
   ,   @Instrumento    VARCHAR(20) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FecProc    CHAR(10)
   ,       @FecEmi     CHAR(10)
   ,       @HorEmi     CHAR(10)

   SELECT  @FecProc    = CONVERT(CHAR(10),acfecproc,103)
   ,       @FecEmi     = CONVERT(CHAR(10),Getdate(),103)
   ,       @HorEmi     = CONVERT(CHAR(10),Getdate(),108)
   FROM    BacTraderSuda..MDAC

   SELECT 'Marcado'     = Marcado
   ,      'Usuario'     = Usuario
   ,      'numope'      = numope
   ,      'monumdocu'   = monumdocu
   ,      'correla'     = correla
   ,      'serie'       = serie
   ,      'moneda'      = moneda
   ,      'nominal'     = nominal
   ,      'tir'         = tir
   ,      'vpressen'    = vpressen
   ,      'dcv'         = dcv
   ,      'madurez'     = madurez
   ,      'formapago'   = formapago
   ,      'movimiento'  = movimiento
   ,      'fecha'       = fecha
   ,      'Estado'      = Estado
   ,      'NumInterfaz' = NumInterfaz
   ,      'Rutcliente'  = Rutcliente
   ,      'CodCliente'  = CodCliente
   ,      'UsuarioEnv'  = UsuarioEnv
   ,      'FechaEnv'    = CONVERT(DATETIME,GETDATE(),112)
   ,      'HoraEnv'     = CONVERT(CHAR(10),GETDATE(),108)
   ,      'FechaProc'   = @FecProc
   ,      'FechaEmi'    = @FecEmi
   ,      'HorEmi'      = @HorEmi
   ,      'User'        = @Usuario
   ,      'Dia'         = 1
   INTO   #LOG_OPERATIVO
   FROM   OP_ENVIADAS_DCV 
   WHERE  Fecha      BETWEEN @FechaEvto1 AND @FechaEvto2
   AND   (monumdocu  = @NumDocu   OR @NumDocu   = 0)
   AND   (correla    = @Correla   OR @Correla   = 0)
   AND   (UsuarioEnv = @SegUser   OR @SegUser   = '')

   UNION

   SELECT 'Marcado'     = Marcado
   ,      'Usuario'     = Usuario
   ,      'numope'      = numope
   ,      'monumdocu'   = monumdocu
   ,      'correla'     = correla
   ,      'serie'       = serie
   ,      'moneda'      = moneda
   ,      'nominal'     = nominal
   ,      'tir'         = tir
   ,      'vpressen'    = vpressen
   ,      'dcv'         = dcv
   ,      'madurez'     = madurez
   ,      'formapago'   = formapago
   ,      'movimiento'  = movimiento
   ,      'fecha'       = fecha
   ,      'Estado'      = Estado
   ,      'NumInterfaz' = NumInterfaz
   ,      'Rutcliente'  = Rutcliente
   ,      'CodCliente'  = CodCliente
   ,      'UsuarioEnv'  = UsuarioEnv
   ,      'FechaEnv'    = FechaEnv
   ,      'HoraEnv'     = HoraEnv
   ,      'FechaProc'   = @FecProc
   ,      'FechaEmi'    = @FecEmi
   ,      'HorEmi'      = @HorEmi
   ,      'User'        = @Usuario
   ,      'Dia'         = 2
   FROM   OP_ENVIADAS_DCV_HISTORICO
   WHERE  FechaEnv   BETWEEN @FechaEvto1 AND @FechaEvto2
   AND   (monumdocu  = @NumDocu   OR @NumDocu   = 0)
   AND   (correla    = @Correla   OR @Correla   = 0)
   AND   (UsuarioEnv = @SegUser   OR @SegUser   = '')


   IF @Instrumento <> ''
   BEGIN
      SELECT * 
      INTO   #TEMPO
      FROM   #LOG_OPERATIVO
      WHERE  serie LIKE @Instrumento + '%'
      ORDER BY FechaEnv , HoraEnv

      DELETE #LOG_OPERATIVO
      INSERT INTO #LOG_OPERATIVO SELECT * FROM #TEMPO
   END 

   IF NOT EXISTS( SELECT 1 FROM #LOG_OPERATIVO )
   BEGIN

      INSERT INTO #LOG_OPERATIVO
      SELECT 'Marcado'     = ''
      ,      'Usuario'     = ''
      ,      'numope'      = 0
      ,      'monumdocu'   = 0
      ,      'correla'     = 0
      ,      'serie'       = ''
      ,      'moneda'      = 0
      ,      'nominal'     = 0.0
      ,      'tir'         = 0.0
      ,      'vpressen'    = 0
      ,      'dcv'         = ''
      ,      'madurez'     = ''
      ,      'formapago'   = ''
      ,      'movimiento'  = ''
      ,      'fecha'       = ''
      ,      'Estado'      = ''
      ,      'NumInterfaz' = 0
      ,      'Rutcliente'  = 0
      ,      'CodCliente'  = 0
      ,      'UsuarioEnv'  = ''
      ,      'FechaEnv'    = ''
      ,      'HoraEnv'     = ''
      ,      'FechaProc'   = @FecProc
      ,      'FechaEmi'    = @FecEmi
      ,      'HorEmi'      = @HorEmi
      ,      'User'        = @Usuario
      ,      'Dia'         = 0
   END

   SELECT * 
    FROM #LOG_OPERATIVO
   ORDER BY FechaEnv , HoraEnv , monumdocu , correla

END 



GO
