USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_BLOQUEO_FLI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEE_BLOQUEO_FLI]
   (   @Evento       INTEGER
   ,   @xSerie       VARCHAR(20)
   ,   @gsBac_User   VARCHAR(15)
   ,   @hWnd         NUMERIC(9)
   ,   @nNominal     FLOAT      = 0
   ,   @CarteraNormativa Varchar(10) = ' '
   ,   @RutEmisor    numeric(13) = 0 -- PROD 6006
   ,   @NroCompra    numeric(13) = 0
   ,   @Correlativo  numeric(10) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound   INTEGER
       SET @iFound   = 0

   IF @Evento = 1 -- Bloqueo
   BEGIN

      IF EXISTS( SELECT 1 FROM dbo.DETALLE_FLI
                               INNER JOIN dbo.MDBL ON Documento = blnumdocu AND Correlativo = blcorrela
                         WHERE Serie = @xSerie AND ventana = @hWnd 
                           AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' )
                           AND ( rut_emisor = @RutEmisor  or @RutEmisor = 0 ) 
                           AND ( Documento  = @NroCompra   or @NroCompra = 0 )
                           AND ( Correlativo = @Correlativo or @Correlativo = 0 )
                )
      BEGIN

         DELETE dbo.MDBL
           FROM dbo.DETALLE_FLI
          WHERE Documento = blnumdocu AND Correlativo = blcorrela
            AND Serie     = @xSerie   AND ventana     = @hWnd
            AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' )
            AND ( rut_emisor = @RutEmisor  or @RutEmisor = 0 )
            AND ( Documento  = @NroCompra   or @NroCompra = 0 )
            AND ( Correlativo = @Correlativo or @Correlativo = 0 )
      END
      -->    Verifica si esta marcado en tabla Detalle Fli 
      SELECT @iFound   = 1
         SET @iFound   = ISNULL( (SELECT DISTINCT 1 FROM dbo.DETALLE_FLI 
                        WHERE Serie = @xSerie 
                          AND ventana <> @hWnd 
                          and usuario <> @gsBac_User 
                          AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' )
                          and ( Rut_Emisor = @RutEmisor or @RutEmisor = 0 )     -- PROD 6006 
                          and ( Documento  = @NroCompra   or @NroCompra = 0 )
                          and ( Correlativo = @Correlativo or @Correlativo = 0 )
                          and Marca = 'S'), 0)

      IF @iFound = 1
      BEGIN
         SELECT -1 , 'Serie se encuentra Bloqueada por otro usuario.'
         RETURN
      END

      IF @iFound = 0
      BEGIN
         -->    Verifica si esta marcado en tabla de Bloqueo
         SET @iFound   = ISNULL( (SELECT DISTINCT 1 FROM dbo.MDBL INNER JOIN dbo.DETALLE_FLI 
                                                                        ON Documento = blnumdocu 
                                                                        AND Correlativo = blcorrela
                                                                        AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' )
                                                                        AND ( rut_emisor = @RutEmisor  or @RutEmisor = 0 )
                                                                        AND ( Documento  = @NroCompra   or @NroCompra = 0 )
                                                                        AND ( Correlativo = @Correlativo or @Correlativo = 0 )
                                                   WHERE Serie    = @xSerie
                                                     AND Ventana <> @hWnd
                                                     AND usuario <> @gsBac_User), 0)
         IF @iFound = 1
         BEGIN
            SELECT -1 , 'Serie se encuentra Bloqueada por otro usuario. MDBL '
            RETURN
         END
      END

       /*
      IF @nNominal <> (SELECT SUM( cpnominal ) FROM MDCP INNER JOIN MDDI ON CPNUMDOCU = DINUMDOCU AND CPCORRELA = DICORRELA
                                              WHERE cpinstser = @xSerie and cpnominal > 0 and cpnominal > 0 and cpdcv = 'D')
      BEGIN
         SELECT -1, 'Nominal disponible es menor al registrado. Favor Filtrar Nuevamente.'
         RETURN
      END
      */

      INSERT INTO dbo.MDBL
      SELECT blrutcart    = 97023000
         ,   blnumdocu    = Documento
         ,   blcorrela    = Correlativo
         ,   blhwnd       = @hWnd
         ,   blusuario    = @gsBac_User
      FROM   DETALLE_FLI 
      WHERE  Serie        = @xSerie
         AND Ventana      = @hWnd
         AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' ) -- PROD 6006
         and ( Rut_Emisor   = @RutEmisor or @RutEmisor = 0 )       
         AND ( Documento    = @NroCompra   or @NroCompra = 0 )
         AND ( Correlativo  = @Correlativo or @Correlativo = 0 )
      SELECT 0 , 'Se ha completado el Bloquedo de los Documentos.'
   END

   IF @Evento = 2 -- Desbloqueo
   BEGIN
      DELETE MDBL
      FROM   MDBL
             INNER JOIN DETALLE_FLI ON Documento = blnumdocu AND blcorrela = Correlativo
      WHERE  blhwnd    = @hWnd
        AND  blusuario = @gsBac_User
        AND  Serie     = @xSerie
        AND  Ventana   = @hWnd
        AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' ) -- PROD 6006
        and ( Rut_Emisor = @RutEmisor or @RutEmisor = 0 )      
        AND ( Documento  = @NroCompra   or @NroCompra = 0 )
        AND ( Correlativo = @Correlativo or @Correlativo = 0 )

      SELECT Serie    = Serie
      ,      Moneda   = Moneda
      ,      Nominal  = SUM( Nominal_Compra )
      ,      Tir      = AVG( Tasa_Compra )
      ,      vPar     = AVG( Valor_Par )
      ,      vPresent = SUM( Valor_Presente )
      ,      Plazo    = Plazo
      ,      Margen   = AVG( Margen )
      ,      vinicial = SUM( Valor_Inicial )
      FROM   dbo.DETALLE_FLI
      WHERE  Serie    = @xSerie
      AND    Ventana  = @hWnd
      AND    Usuario  = @gsbac_user
      AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' ) -- PROD 6006
      and  (  Rut_Emisor = @RutEmisor  or @RutEmisor = 0 )     -- PROD 6006 
      AND ( Documento  = @NroCompra   or @NroCompra = 0 )
      AND ( Correlativo = @Correlativo or @Correlativo = 0 )
      GROUP BY Serie, Moneda, Plazo

      UPDATE DETALLE_FLI   
         SET Marca     = 'N'
       WHERE Serie     = @xSerie
        AND  Ventana   = @hWnd
        AND  Usuario   = @gsbac_user
        AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' ) -- PROD 6006
        and ( Rut_Emisor = @RutEmisor or @RutEmisor = 0 )                  
        AND ( Documento  = @NroCompra   or @NroCompra = 0 )
        AND ( Correlativo = @Correlativo or @Correlativo = 0 )
      SELECT 0 , 'Se ha completado el Desbloquedo de los Documentos.'
   END

   IF @Evento = 3  -- Cierre de Pantalla se debloquean todos
   BEGIN
      DELETE MDBL 
        FROM DETALLE_FLI 
       WHERE Documento = blnumdocu AND Correlativo = blcorrela AND Ventana = blhwnd
       AND   blhwnd    = @hWnd
       AND ( CarteraSuper = @CarteraNormativa or @CarteraNormativa = ' ' ) -- PROD 6006
       and ( Rut_Emisor = @RutEmisor or @RutEmisor = 0 )       
       AND ( Documento  = @NroCompra   or @NroCompra = 0 )
       AND ( Correlativo = @Correlativo or @Correlativo = 0 )
      DELETE FROM DETALLE_FLI
            WHERE ventana   = @hWnd
   END

END


GO
