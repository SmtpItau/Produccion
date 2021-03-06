USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGADATATEC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGADATATEC]
(
         @codigo_unico         CHAR(16)      ,
         @fecha                DATETIME      ,
         @hora                 CHAR   (06)   ,
         @clase_mensaje        NUMERIC(02)   ,    /*5-Transacción   50-Anulación*/
         @o_d                  CHAR   (01)   ,
         @institucion_postura  CHAR   (30)   ,
         @ciudad_postura       CHAR   (10)   ,
         @usuario_postura      CHAR   (30)   ,
         @institucion_aceptant CHAR   (30)   ,
         @ciudad_aceptante     CHAR   (10)   ,
         @usuario_aceptante    CHAR   (30)   ,
         @mercado              NUMERIC(02)   ,
         @moneda               CHAR   (01)   ,
         @precio               NUMERIC(08,04),
         @numero               NUMERIC(10)   ,
         @numero_transado      NUMERIC(10)   ,
         @dias                 NUMERIC(03)   
)
AS BEGIN 
   SET NOCOUNT ON
   
   DECLARE @rutcliente NUMERIC(9)
   DECLARE @codcliente NUMERIC(9)
   DECLARE @acnumoper NUMERIC(10)
   IF NOT EXISTS( SELECT 1 FROM VIEW_CLIENTE 
                  WHERE (CASE @o_d
                            WHEN 'D' THEN @institucion_postura
                            WHEN 'O' THEN @institucion_aceptant
                         END) = clnombre
            )
   BEGIN
      SELECT 'NO EXISTE CLIENTE'
      RETURN
   END
   SELECT @rutcliente = (
            SELECT clrut FROM VIEW_CLIENTE 
                  WHERE (CASE @o_d
                            WHEN 'D' THEN @institucion_postura
                            WHEN 'O' THEN @institucion_aceptant
                         END) = clnombre)
   SELECT @codcliente = (
            SELECT clcodigo FROM VIEW_CLIENTE 
                  WHERE (CASE @o_d
                            WHEN 'D' THEN @institucion_postura
                            WHEN 'O' THEN @institucion_aceptant
                         END) = clnombre)
   SELECT @fecha = DATEADD( HH, CONVERT( INT, SUBSTRING( @hora, 1, 2 ) ), @fecha)
   SELECT @fecha = DATEADD( MI, CONVERT( INT, SUBSTRING( @hora, 3, 2 ) ), @fecha)
   SELECT @fecha = DATEADD( SS, CONVERT( INT, SUBSTRING( @hora, 5, 2 ) ), @fecha)
   IF NOT EXISTS(SELECT 1 FROM MFCA WHERE numerointerfaz = @codigo_unico)
   BEGIN
      UPDATE MFAC SET acnumoper = acnumoper + 1
      SELECT @acnumoper = acnumoper FROM MFAC
      INSERT INTO MFCA ( 
                        canumoper                          , --01
                        cacodpos1                          , --02
                        cacodmon1                          , --03
                        cacodmon2                          , --04
                        cacodcart                          , --05
                        cacodigo                           , --06
                        catipoper                          , --07
                        catipmoda                          , --08
                        cafecha                            , --09
                        catipcam                           , --10
                        camdausd                           , --11
                        camtomon1                          , --12
                        caequusd1                          , --13
                        caequmon1                          , --14
                        camtomon2                          , --15
                        caequusd2                          , --16
                        caequmon2                          , --17
                        caparmon1                          , --18
                        capremon1                          , --19
                        caparmon2                          , --20
                        capremon2                          , --21
                        caestado                           , --22
                        caretiro                           , --23
   cacontraparte                      , --24
                        caobserv                           , --25
          caspread                           , --26
                        caprecal                           , --27
                        caplazo                            , --28
                        cafecvcto                          , --29
          caoperador                         , --30
                        catasausd                          , --31
                        catasacon                          , --32
                        cafpagomn                          , --33
   cafpagomx      , --34
   camtomon1ini        , --35
   camtomon1fin        , --36
   camtomon2ini        , --37
   camtomon2fin                       , --38
                        cacodsuc1                          , --39
                        cacodcli                           , --40
                        cadiferen                          , --41
                        cabroker      , --42
   camontopfe      , --43
   camontocce      , --44
   id_sistema              , --45
   Precio_Transferencia      , --46
   Tipo_Sintetico           , --47
   Precio_Spot      , --48
   Pais_Origen      , --49
   Moneda_Compensacion       , --50
   Riesgo_Sintetico      , --51
   Precio_Reversa_Sintetico           , --52
                        calzada                            , --53
                        numerointerfaz                       --54
                       )
                  VALUES
                      (
                        @acnumoper                         , --01
   1                                  , --02 @ncodpos1      
                        CASE @moneda                        
                           WHEN 'D' THEN 994
                        END                                , --03
                        CASE @mercado        
                           WHEN 34 THEN 999
                           WHEN 35 THEN 998
                        END                                , --04
                        1, --@ncodcart                          , --05
                        @rutcliente                        , --06
                        CASE @o_d             
                           WHEN 'D' THEN 'C'
                           WHEN 'O' THEN 'V'
                        END                                , --07
                        'C'                                , --08
                        @fecha                             , --09
                        @precio                            , --10
                        0                                  , --11
                        @precio * @numero                  , --12
                        0,-- @nequusd1                          , --13
                        0,-- @nequmol1                          , --14
                        0,-- @nmtomon2      , --15
                        0,-- @nequusd2                          , --16
                        0,-- @nequmol2                          , --17
                        0,-- @nparmon1                          , --18
                        0,-- @npremon1                          , --19
                 0,-- @nparmon2                          , --20
                        0,-- @npremon2                          , --21
                        CASE @clase_mensaje  
                           WHEN  5 THEN ' '
                           WHEN 50 THEN 'A'
                        END                                , --22
                        1,  -- @cretiro                           , --23
          0,  -- @ccontraparte                      , --24
                        '', --@cobserv                           , --25
                        0, -- @nspread                           , --26
                        0, -- @nprecal                           , --27
                        @dias                              , --28
                        '', --@cfecvcto                          , --29
                        CASE @o_d            
             WHEN 'D' THEN SUBSTRING(@usuario_postura,1,10)
                           WHEN 'O' THEN SUBSTRING(@usuario_aceptante,1,10)
                        END                                , --30
                        0,-- @ntasausd                          , --31
   0,-- @ntasacon                          , --32
                        2,-- @nfpagomn                          , --33
                        2,-- @nfpagomx      , --34
   0,-- @nMtoMon1ini           , --35
   0,-- @nMtoMon1fin           , --36
   0,-- @nMtoMon2ini           , --37
   0,-- @nMtoMon2fin                    , --38
                        1,-- @nentidad                          , --39
                        @codcliente                        , --40
                        0,-- @nmtodif                           , --41
   0,-- @nBroker                    , --42
   0,-- @nMontoPFE      , --43
   0,-- @nMontoCCE      , --44
   'BFW', -- @id_sistema              , --45
   0,-- @Precio_Transferencia      , --46
   '',-- @Tipo_Sintetico           , --47
   0 ,-- @Precio_Spot      , --48
   0 ,-- @Pais_Origen      , --49
   0 ,-- @Moneda_Compensacion       , --50
   '',-- @Riesgo_Sintetico      , --51
   0 ,-- @Precio_Reversa_Sintetico             , --52
                        'N',--calzado                               , --53
                        @codigo_unico                                --54
                     )
      SELECT 'AGREGADO'
   END ELSE BEGIN
      IF @clase_mensaje = 50
      BEGIN
         UPDATE MFCA SET caestado = 'A' WHERE numerointerfaz = @codigo_unico
         SELECT 'ANULADO'
      END
   END
   SET NOCOUNT OFF
END

GO
