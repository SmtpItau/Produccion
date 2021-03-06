USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SUBPROD_RISTRA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_SUBPROD_RISTRA] 
                                            @icodigo_producto    CHAR(05)
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


    DECLARE  @nRegistro           NUMERIC(5)
          ,  @cRistra             VARCHAR(255)
          ,  @nNumero_Condicion   NUMERIC(5)
          ,  @nNumero             NUMERIC(5)


    CREATE TABLE #TMP_RISTRA
               ( nNumero_Condicion   NUMERIC(5)
               , cRistra             VARCHAR(255)
               )

    SELECT   a.codigo_producto
        ,    a.numero_condicion
        ,    a.codigo_campo
        ,    a.orden_campo
        ,    a.valor_campo
        ,    a.codigo_utilizacion
        ,    b.nombre_campo
        ,    'Ristra'             = SPACE(255)
        ,    'nRegistro'          = IDENTITY(INT)
        INTO #TMP
        FROM CONDICION_SUBPRODUCTO       a
           , RELACION_CAMPO_SUBPRODUCTO  b
        WHERE codigo_producto = @icodigo_producto
          AND a.codigo_campo  = b.codigo_campo
           ORDER BY numero_condicion, orden_campo


    SELECT @nRegistro         = 1
         , @cRistra           = ''
         , @nNumero_Condicion = (SELECT MIN(numero_condicion) 
                                   FROM #TMP )
      

    WHILE @nRegistro <= ( SELECT COUNT(1) FROM #TMP )
    BEGIN


       SELECT @nNumero    = numero_condicion
         FROM #TMP
        WHERE nRegistro  = @nRegistro

          IF @nNumero_Condicion <> @nNumero BEGIN
           

             SELECT @cRistra = SUBSTRING( @cRistra , 3 , LEN(@cRistra ) )

             UPDATE #TMP SET Ristra    = @cRistra
              WHERE numero_condicion   = @nNumero_Condicion

             SELECT @nNumero_Condicion = @nNumero
                  , @cRistra           = ''


          END

       SELECT @cRistra    = LTRIM(RTRIM(@cRistra)) + ' + ' + LTRIM(RTRIM(nombre_campo))
         FROM #TMP
        WHERE nRegistro  = @nRegistro


       SELECT @nregistro = @nregistro + 1

    END


    SELECT @cRistra = LTRIM(RTRIM(SUBSTRING( @cRistra , 3 , LEN(@cRistra ) )))

    UPDATE #TMP SET Ristra = @cRistra
     WHERE Numero_Condicion  = @nNumero_Condicion 

    SELECT * 
      FROM #TMP

    SET NOCOUNT OFF

END
GO
