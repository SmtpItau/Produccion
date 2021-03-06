USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_REFRESCA_DATA_DCV]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_REFRESCA_DATA_DCV]
   (   @Fecha     DATETIME         --> Fecha 
   ,   @Filtro1   VARCHAR(5)  = '' --> Tipo Operacion
   ,   @Filtro2   CHAR(1)     = '' --> Estado
   ,   @BacUser   VARCHAR(15) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   /*
   DELETE dbo.OP_ENVIADAS_DCV
   WHERE  fecha   = @Fecha
   AND    estado  = 'P'
   AND    Marcado = 'N'
   */

   INSERT INTO OP_ENVIADAS_DCV
   SELECT 'Marca'       = 'N'
   ,      'Usuario'     = ''
   ,      'numope'      = M.monumoper
   ,      'monumdocu'   = M.monumdocu
   ,      'correla'     = M.mocorrela
   ,      'serie'       = M.moinstser
   ,      'moneda'      = CASE WHEN M.momonemi = 999 THEN 60
                               WHEN M.momonemi = 998 THEN 61
                               WHEN M.momonemi = 994 THEN 64
                               WHEN M.momonemi = 997 THEN 65
                          END
   ,      'nominal'     = M.monominal
   ,      'tir'         = M.motir
   ,      'pvpar'       = M.movpar
   ,      'vpressen'    = M.movpresen
   ,      'dcv'         = M.moclave_dcv
   ,      'madurez'     = C.Condicion
   ,      'motipoper'   = M.motipoper
   ,      'fpago'       = CASE WHEN M.moforpagi = 5    THEN 'D'
                               WHEN M.moforpagi = 125  THEN 'D'
                               WHEN M.moforpagi = 125  THEN 'R'
                               ELSE                         'R'
                          END
   ,      'Movimiento'  = CASE WHEN M.motipoper = 'VP' THEN 'CA'
                               WHEN M.motipoper = 'CP' THEN 'CO'
                          END
   ,      'fecha'       = M.mofecpro
   ,      'estado'      = D.Estado
   ,      'NumInterfaz' = 0
   ,      'RutCliente'  = M.morutcli
   ,      'CodCliente'  = M.mocodcli
   ,      'UsuarioEnv'  = ''
   FROM   BacTraderSuda..MDMO         M 
          LEFT JOIN ESTADOS_DCV       D ON D.Estado    = 'P'
          LEFT JOIN CONDICION_MADUREZ C ON C.Condicion = 'C'
          LEFT JOIN OP_ENVIADAS_DCV   E ON E.numope    = M.monumoper AND E.monumdocu = M.monumdocu AND E.correla = M.mocorrela
   WHERE  M.modcv         = 'D'
   AND    E.numope        IS NULL
   AND    M.motipoper     IN('CP','VP')
   AND    M.mostatreg     IN('')


   IF @Filtro2 = 'M'
   BEGIN
      SELECT @Filtro2 = 'S'

      SELECT /*01*/ LTRIM(RTRIM(O.estado)) + ' - ' + E.Descripcion
      ,      /*02*/ O.monumdocu
      ,      /*03*/ O.correla
      ,      /*04*/ O.serie
      ,      /*05*/ O.moneda
      ,      /*06*/ O.nominal
      ,      /*07*/ O.tir
      ,      /*08*/ O.pvpar
      ,      /*09*/ O.vpressen
      ,      /*10*/ O.dcv
      ,      /*11*/ LTRIM(RTRIM(O.madurez)) + ' - ' + C.Descripcion
      ,      /*12*/ CASE WHEN Marcado = 'S' THEN 'True' ELSE 'False' END
      ,      /*13*/ O.Usuario
      ,      /*14*/ O.RutCliente
      ,      /*15*/ O.CodCliente
      ,      /*16*/ L.clnombre
      ,      /*17*/ O.UsuarioEnv
      FROM   OP_ENVIADAS_DCV                 O
             LEFT JOIN ESTADOS_DCV           E ON O.estado  = E.estado
             LEFT JOIN CONDICION_MADUREZ     C ON O.madurez = C.Condicion
             LEFT JOIN BacParamSuda..CLIENTE L ON L.clrut   = O.RutCliente and L.clcodigo = O.CodCliente
      WHERE (O.fecha     = @Fecha)
      AND   (O.motipoper = @Filtro1 OR @Filtro1  = '')
      AND   (O.Marcado   = @Filtro2 OR @Filtro2  = '')
   END ELSE
   BEGIN
      SELECT /*01*/ LTRIM(RTRIM(O.estado)) + ' - ' + E.Descripcion
      ,      /*02*/ O.monumdocu
      ,      /*03*/ O.correla
      ,      /*04*/ O.serie
      ,      /*05*/ O.moneda
      ,      /*06*/ O.nominal
      ,      /*07*/ O.tir
      ,      /*08*/ O.pvpar
      ,      /*09*/ O.vpressen
      ,      /*10*/ O.dcv
      ,      /*11*/ LTRIM(RTRIM(O.madurez)) + ' - ' + C.Descripcion
      ,      /*12*/ CASE WHEN Marcado = 'S' THEN 'True' ELSE 'False' END
      ,      /*13*/ O.Usuario
      ,      /*14*/ O.RutCliente
      ,      /*15*/ O.CodCliente
      ,      /*16*/ L.clnombre
      ,      /*17*/ O.UsuarioEnv
      FROM   OP_ENVIADAS_DCV                 O
             LEFT JOIN ESTADOS_DCV           E ON O.estado  = E.estado
             LEFT JOIN CONDICION_MADUREZ     C ON O.madurez = C.Condicion
             LEFT JOIN BacParamSuda..CLIENTE L ON L.clrut   = O.RutCliente and L.clcodigo = O.CodCliente
      WHERE (O.fecha     = @Fecha)
      AND   (O.motipoper = @Filtro1 OR @Filtro1  = '')
      AND   (O.estado    = @Filtro2 OR @Filtro2  = '')
   END
END



GO
