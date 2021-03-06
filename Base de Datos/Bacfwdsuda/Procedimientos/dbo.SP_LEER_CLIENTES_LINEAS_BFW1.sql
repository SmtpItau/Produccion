USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES_LINEAS_BFW1]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES_LINEAS_BFW1]
   (   @iRutCliente   NUMERIC(10)   = 0   
   ,   @iCodCliente   INTEGER       = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_LINEAS_BFW_CLI
   (   Rut           NUMERIC(10)
   ,   Codigo        INTEGER
   ,   Nombre        VARCHAR(70)
   ,   Puntero       INTEGER Identity(1,1)
   )

--select 'debug' 
   INSERT INTO #TMP_LINEAS_BFW_CLI 
   SELECT DISTINCT
          'Rut'          = cacodigo
   ,      'Codigo'       = cacodcli
   ,      'Nombre'       = substring( clnombre, 1, 70 )
   FROM   MFCA           with (nolock)
          INNER JOIN BacParamSuda..CLIENTE ON clrut = cacodigo and clcodigo = cacodcli
   WHERE (cacodigo       = @iRutCliente
   AND    cacodcli       = @iCodCliente
       OR @iRutCliente   = 0 
      AND @iCodCliente   = 0)
   AND    cltipcli      <> 6 

   UNION 

   SELECT DISTINCT
          'Rut'          = cacodigo
   ,      'Codigo'       = cacodcli
   ,      'Nombre'       = substring( clnombre, 1 ,70 )
   FROM   MFCA           with (nolock)
          INNER JOIN BacParamSuda..CLIENTE ON clrut = cacodigo and clcodigo = cacodcli
   WHERE (cacodigo       = @iRutCliente)
      OR (@iRutCliente   = 0)
   AND    cltipcli       = 6 

   IF @iRutCliente = 0 
   BEGIN

      UPDATE BacLineas..LINEA_SISTEMA 
      SET    TotalOcupado    = 0
      ,	     TotalExceso     = 0
      ,	     TotalDisponible = TotalAsignado
      WHERE  id_sistema      = 'BFW'

      UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO
      SET    TotalOcupado    = 0
      ,	     TotalExceso     = 0
      ,	     TotalDisponible = TotalAsignado
      WHERE  id_sistema      = 'BFW'

   END ELSE
   BEGIN

      INSERT INTO #TMP_LINEAS_BFW_CLI
      SELECT RutPadre     = clrut_padre
      ,      CodPadre     = clcodigo_padre
      ,      NomPadre     = substring( clnombre, 1, 70 )
      FROM   BacLineas..CLIENTE_RELACIONADO   with (nolock)
             INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = clrut_padre and clcodigo = clcodigo_padre
      WHERE  clrut_hijo    = @iRutCliente
      AND    clcodigo_hijo = @iCodCliente

      IF @@ROWCOUNT > 0
      BEGIN
         DECLARE @iRutPadre   NUMERIC(9)
         DECLARE @iCodPadre   INTEGER
         SELECT  @iRutPadre   = Rut
              ,  @iCodPadre   = Codigo
         FROM    #TMP_LINEAS_BFW_CLI
         WHERE   Puntero      = 1

         INSERT INTO #TMP_LINEAS_BFW_CLI
         SELECT RutPadre       = clrut_hijo
         ,      CodPadre       = clcodigo_hijo
         ,      NomPadre       = substring( clnombre, 1, 70 )
         FROM   BacLineas..CLIENTE_RELACIONADO   with (nolock)
                INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = clrut_hijo and clcodigo = clcodigo_hijo
         WHERE  clrut_padre    = @iRutPadre
         AND    clcodigo_padre = @iCodPadre
      END

      UPDATE BacLineas..LINEA_SISTEMA 
      SET    TotalOcupado    = 0
      ,	     TotalExceso     = 0
      ,	     TotalDisponible = TotalAsignado
      FROM   #TMP_LINEAS_BFW_CLI
      WHERE  Rut_Cliente     = #TMP_LINEAS_BFW_CLI.Rut
      AND    Codigo_Cliente  = #TMP_LINEAS_BFW_CLI.Codigo
      AND    id_sistema      = 'BFW'

      UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO
      SET    TotalOcupado    = 0
      ,	     TotalExceso     = 0
      ,	     TotalDisponible = TotalAsignado
      FROM   #TMP_LINEAS_BFW_CLI
      WHERE  Rut_Cliente     = #TMP_LINEAS_BFW_CLI.Rut
      AND    Codigo_Cliente  = #TMP_LINEAS_BFW_CLI.Codigo
      AND    id_sistema      = 'BFW'
   END

   SELECT 'EXECUTE SP_NUEVO_RECALCULO_LINEAS' ,"'BFW',", Rut, codigo FROM #TMP_LINEAS_BFW_CLI where nombre like '%bnp%' ORDER BY Puntero

END


GO
