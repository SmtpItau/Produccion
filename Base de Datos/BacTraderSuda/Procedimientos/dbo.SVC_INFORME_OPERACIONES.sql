USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INFORME_OPERACIONES]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SVC_INFORME_OPERACIONES]
   (   @FechaProceso   DATETIME   
   ,   @Usuario        VARCHAR(15) = 'ADMINISTRA'
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

   SELECT 'Documento'    = monumdocu
   ,      'Correlativo'  = correla
   ,      'Instrumenbto' = serie
   ,      'ValNominal'   = nominal
   ,      'Tasa'         = tir
   ,      'ValPresente'  = vpressen
   ,      'Clave'        = dcv
   ,      'Madurez'      = M.Descripcion
   ,      'Estado'       = CASE WHEN Estado = 'R' THEN 'Reenviada'
                                WHEN Estado = 'P' THEN 'Pendiente'
                                WHEN Estado = 'E' THEN 'Enviada'
                                ELSE                   'No Definido'
                           END
   ,      'Responsable'  = UsuarioEnv
   ,      'NumInterfaz'  = CONVERT(CHAR(8),'DCV' 
                         + REPLICATE('0' , 5 - LEN(LTRIM(RTRIM(NumInterfaz))))
                         + LTRIM(RTRIM(NumInterfaz)))
   ,      'Marcado'      = Marcado
   ,      'UsrMarca'     = Usuario
   ,      'Usuario'      = @Usuario
   ,      'FecProc'      = @FecProc
   ,      'FecEmi'       = @FecEmi
   ,      'HorEmi'       = @HorEmi
   INTO   #OPERACIONES
   FROM   OP_ENVIADAS_DCV
          LEFT JOIN CONDICION_MADUREZ M ON M.Condicion = madurez
   WHERE  Fecha          = @FechaProceso
   ORDER BY Estado , UsuarioEnv , monumdocu , correla

   IF NOT EXISTS(SELECT 1 FROM #OPERACIONES)
   BEGIN
      INSERT INTO #OPERACIONES
      SELECT 'Documento'    = 0
      ,      'Correlativo'  = 0
      ,      'Instrumenbto' = ''
      ,      'ValNominal'   = 0.0
      ,      'Tasa'         = 0.0
      ,      'ValPresente'  = 0
      ,      'Clave'        = ''
      ,      'Madurez'      = ''
      ,      'Estado'       = ''
      ,      'Responsable'  = ''
      ,      'NumInterfaz'  = 'DCV00000'
      ,      'Marcado'      = ''
      ,      'UsrMarca'     = ''
      ,      'Usuario'      = @Usuario
      ,      'FecProc'      = @FecProc
      ,      'FecEmi'       = @FecEmi
      ,      'HorEmi'       = @HorEmi

   END

   SELECT * FROM #OPERACIONES

END



GO
