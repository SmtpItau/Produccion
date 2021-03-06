USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_GRABA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTRADAY_GRABA]
 ( @nnumoper                      NUMERIC(10)   = 00,
         @ncodcart                      NUMERIC(09)   = 00,
         @ncodigo                       NUMERIC(09)   = 00,
         @ncodpos1                      NUMERIC(02)   = 00,
         @ncodmon1                      NUMERIC(03)   = 00,
         @ncodmon2                      NUMERIC(03)   = 00,
         @ctipoper                      CHAR(01)      = '',
         @ctipmoda                      CHAR(01)      = '',
         @dfecha                        DATETIME      = '',
         @ntipcam                       FLOAT         = 00,
         @nmdausd                       NUMERIC(03)   = 00,
         @nmtomon1                      NUMERIC(21,04)= 00,
         @nequusd1                      NUMERIC(21,04)= 00,
         @nequmol1                      NUMERIC(21,04)= 00,
  @nmtomon2                      NUMERIC(21,04)= 00,
         @nequusd2                      NUMERIC(21,04)= 00,
         @nequmol2                      NUMERIC(21,04)= 00,
         @nparmon1                      FLOAT         = 00,
         @npremon1                      FLOAT         = 00,
         @nparmon2                      FLOAT         = 00,
         @npremon2                      FLOAT         = 00,
         @cestado                       CHAR(01)      = '',
         @cretiro                       CHAR(01)      = '',
         @ccontraparte                  NUMERIC(09)   = 00,
         @cobserv                       VARCHAR(255)  = '',
         @nspread                       FLOAT         = 00,
         @nprecal                       FLOAT         = 00,
         @nplazo                        NUMERIC(06)   = 00,
         @cfecvcto                      DATETIME      = '',
         @clock                         CHAR(10)      = '',
         @operador                      CHAR(10)      = '',
         @ntasausd                      FLOAT         = 00,
         @ntasacon                      FLOAT         = 00,
         @nfpagomn                      NUMERIC(03)   = 00,
         @nfpagomx                      NUMERIC(03)   = 00,
  @nMtoMon1ini                NUMERIC(21,04)= 00,
  @nMtoMon1fin                NUMERIC(21,04)= 00,
  @nMtoMon2ini                NUMERIC(21,04)= 00,
  @nMtoMon2fin                NUMERIC(21,04)= 00,
         @nentidad                      NUMERIC(05,00)= 00,
         @ncodcli                       NUMERIC(09)   = 00,
  @nMtoDif                       NUMERIC(19,00)= 00,
         @nBroker                       NUMERIC(09,00)= 00,
  @nMontoPFE                NUMERIC(24,01)= 00,
  @nMontoCCE                NUMERIC(24,01)= 00,
-------------------------------------------------------------
  @id_sistema                    CHAR(03)      = '',
  @Precio_Transferencia        NUMERIC(21,11)= 00,
  @Tipo_Sintetico         CHAR(03)      = '',
  @Precio_Spot         NUMERIC(10,04)= 00,
  @Pais_Origen         NUMERIC(05,00)= 00,
  @Moneda_Compensacion        NUMERIC(05,00)= 00,
  @Riesgo_Sintetico        CHAR(03)      = '',
  @Precio_Reversa_Sintetico      NUMERIC(10,04)= 00,
  @Terminal                      CHAR(12) = ''
 )
AS
BEGIN
   DECLARE @MFACnumoper NUMERIC(10),
           @meacnumoper NUMERIC(10),
           @nombrecliente CHAR(35)
   SET NOCOUNT ON
   
   SELECT @nombrecliente =(SELECT acnomprop FROM MFAC)
   BEGIN TRANSACTION
   IF EXISTS(SELECT 1 FROM MFCA WHERE canumoper = @nnumoper)
   BEGIN
      UPDATE MFCA SET
  cacodpos1 =  @ncodpos1      ,
  cacodmon1 =  @ncodmon1      ,
  cacodmon2 =  @ncodmon2      ,
  cacodcart =  @ncodcart      ,
  cacodigo =  @ncodigo       ,
  catipoper =  @ctipoper      ,
  catipmoda =  @ctipmoda      ,
  cafecha         =  @dfecha        ,
  catipcam =  @ntipcam       ,
  camdausd =  @nmdausd       ,
  camtomon1 =  @nmtomon1      ,
  caequusd1 =  @nequusd1      ,
  caequmon1 =  @nequmol1      ,
  camtomon2 =  @nmtomon2  ,
  caequusd2 =  @nequusd2      ,
  caequmon2 =  @nequmol2      ,
  caparmon1 =  @nparmon1      ,
  capremon1 =  @npremon1      ,
  caparmon2 =  @nparmon2      ,
  capremon2 =  @npremon2      ,
  caestado =  @cestado       ,
  caretiro =  @cretiro       ,
  cacontraparte =  @ccontraparte  ,
  caobserv =  @cobserv       ,
  caspread =  @nspread       ,
  caprecal =  @nprecal       ,
  caplazo         =         @nplazo        ,
  cafecvcto =  @cfecvcto      ,
  caoperador =  @operador      ,
  catasausd =  @ntasausd      ,
  catasacon =  @ntasacon      ,                   
  cafpagomn =  @nfpagomn      ,
  cafpagomx =  @nfpagomx      ,
  camtomon1ini =  @nMtoMon1ini   ,
  camtomon1fin =  @nMtoMon1fin   ,
  camtomon2ini =  @nMtoMon2ini   ,
  camtomon2fin =  @nMtoMon2fin   ,
  cacodsuc1 =  @nentidad      ,
  cacodcli =  @ncodcli       ,
  cadiferen =  @nmtodif       ,
  cabroker =  @nBroker       ,
  camontopfe =  @nMontoPFE     ,
  camontocce =  @nMontoCCE     ,
  id_sistema =  @id_sistema    ,
  precio_transferencia    = @precio_transferencia     , 
  tipo_sintetico =  @tipo_sintetico           ,
  precio_spot =  @precio_spot              ,
  pais_origen =  @pais_origen              ,
  moneda_compensacion = @moneda_compensacion      ,
  riesgo_sintetico = @riesgo_sintetico         ,
  precio_reversa_sintetico= @precio_reversa_sintetico      
          WHERE canumoper = @nnumoper
         IF @@ERROR <> 0 BEGIN
            ROLLBACK TRANSACTION
            SELECT -1, 'ERROR'
            SET NOCOUNT OFF
            RETURN
         END
 
         COMMIT TRANSACTION
         SELECT @nnumoper, 'OK'
         SET NOCOUNT OFF
         RETURN
   END
   UPDATE MFAC SET acnumoper = acnumoper + 1
   SELECT @MFACnumoper = acnumoper FROM MFAC
   INSERT INTO MFCA ( 
                        canumoper                          ,
                        cacodpos1                          ,
                        cacodmon1                          ,
                        cacodmon2                          ,
                        cacodcart                          ,
                        cacodigo                           ,
                        catipoper                          ,
                        catipmoda                          ,
                        cafecha                            ,
                        catipcam                           ,
                        camdausd                           ,
                        camtomon1                          ,
                        caequusd1                          ,
                        caequmon1                          ,
                        camtomon2                          ,
                        caequusd2                          ,
                        caequmon2                          ,
                        caparmon1                          ,
                        capremon1                          ,
                        caparmon2                          ,
                        capremon2                          ,
                        caestado                           ,
                        caretiro                           ,                        
   cacontraparte                      ,
                        caobserv                           ,
          caspread                           ,
                        caprecal                           ,
                        caplazo                            ,
                        cafecvcto                          ,
          caoperador                         ,
                        catasausd                          ,
                        catasacon                          ,
                        cafpagomn                          ,
   cafpagomx      ,  
   camtomon1ini        ,
   camtomon1fin        ,
   camtomon2ini        ,
   camtomon2fin             ,
                        cacodsuc1                          ,
                        cacodcli                           ,
                        cadiferen                          ,
                        cabroker      ,
   camontopfe      ,
   camontocce      ,
                        calzada                            ,
   id_sistema              ,
   precio_transferencia      ,
   tipo_sintetico           ,
   precio_spot      ,
   pais_origen      ,
   moneda_compensacion       ,
   riesgo_sintetico      ,
   precio_reversa_sintetico
                       )
                VALUES 
                       (
                        @MFACnumoper                       ,                        
   @ncodpos1                          ,
                        @ncodmon1                          ,
                        @ncodmon2                          ,
                        @ncodcart                          ,
                        @ncodigo                           ,
                        @ctipoper                          ,
                        @ctipmoda                          ,
                        @dfecha                            ,
                        @ntipcam                           ,
                        @nmdausd                           ,
                        @nmtomon1                          ,
                        @nequusd1                          ,
                        @nequmol1                          ,
                        @nmtomon2      ,
                        @nequusd2                          ,
                        @nequmol2                          ,
                        @nparmon1                          ,
                        @npremon1                          , 
                 @nparmon2                          ,
                        @npremon2                          ,
                        @cestado                           ,
                        @cretiro                           ,
          @ccontraparte                      ,
                        @cobserv                           ,
                        @nspread                           ,
                        @nprecal                           ,
          @nplazo                            ,
                        @cfecvcto                          ,
                        @operador                          ,
                        @ntasausd                          ,
   @ntasacon                          ,
                        @nfpagomn                          ,
                        @nfpagomx      , 
   @nmtomon1ini           ,
   @nmtomon1fin           ,
   @nmtomon2ini           ,
   @nmtomon2fin                    ,
                        @nentidad                          ,
                        @ncodcli                           ,
                        @nmtodif                           ,                        
   @nbroker                    ,
   @nmontopfe      ,
   @nmontocce      ,
                        'N'                                ,
   @id_sistema              ,
   @precio_transferencia      ,
   @tipo_sintetico           ,
   @precio_spot      ,
   @pais_origen      ,
   @moneda_compensacion       ,
   @riesgo_sintetico      ,
   @precio_reversa_sintetico
                       )
   IF @@ERROR <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'ERROR'
      SET NOCOUNT OFF
      RETURN
   END
   /* 
      si es una operación de sintético debe agregarse una 
      operación en la tabla de movimientos de cambio
   */
   IF @ncodpos1 = 4 
   BEGIN 
      UPDATE VIEW_MEAC SET accorope = accorope + 1
      SELECT @meacnumoper = accorope FROM VIEW_MEAC
      SELECT @ctipoper = CASE @ctipoper
                           WHEN 'C' THEN 'V' 
                           WHEN 'V' THEN 'C'
                         END
      INSERT INTO 
            VIEW_MEMO(moentidad
                     ,motipmer
                     ,monumope
                     ,motipope
                     ,morutcli
                     ,mocodcli
                     ,monomcli
                     ,mocodmon
                     ,mocodcnv
                     ,momonmo
                     ,moticam
                     ,motctra
                     ,motcfin
                     ,moparme
                     ,moparcie
                     ,mopartr
                     ,mopar30
                     ,moparfi
                     ,moprecio
                     ,mopretra
                     ,moprefi
                     ,moussme
                     ,mouss30
                     ,mousstr
                     ,moussfi
                     ,momonpe
                     ,moentre
                     ,morecib
                     ,movaluta1
                     ,movaluta2
                     ,movamos
                     ,motlxp1
                     ,motlxp2
                     ,mooper
                     ,mofech
                     ,mohora
                     ,moterm
                     ,mocodoma
                     ,moestatus
                     ,moimpreso
                     ,mopcierre
                     ,morentab
                     ,mocencos
                     ,mounidad
                     ,mocodejec
                     ,mogrpgen
                     ,mogrppro
                     ,mocorres
                     ,moejecuti
                     ,mopmeco
                     ,mopmeve
                     ,mototco
                     ,mototve
                     ,mototcom
                     ,mototvem
                     ,moenvia
                     ,moalinea
                     ,moaprob
                     ,monumche
                     ,mocarta
                     ,motipcar
                     ,monumfut
                     ,mofecini
                     ,swift_corresponsal
                     ,swift_recibimos
                     ,swift_entregamos
                     ,plaza_corresponsal
                     ,plaza_recibimos
                     ,plaza_entregamos
                     ,precio_cliente
                     ,forma_pago_cli_nac
                     ,forma_pago_cli_ext
                     ,valuta_cli_nac
                     ,valuta_cli_ext
                     ,apoderado_izquierda
                     ,apoderado_derecha
                     ,id_sistema
                     ,contabiliza
                     ,sintetico
                     ,mercado
                     ,codigo_pais
                     ,casa_matriz
                     ,marca
                     ,numerointerfaz
                     )
               VALUES(@nentidad
                     ,'PTAS'
                     ,@meacnumoper
                     ,@ctipoper 
                     ,@ncodigo
                     ,@ncodcli
                     ,@nombrecliente
                     ,'USD'
                     ,'USD'
                     ,@nmtomon1
                     ,@precio_spot
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,@nmtomon1 * @precio_spot  -- monto clp = monto * precio dólar
                     ,0  -- cod. f. pago entreg.
                     ,0  -- cod. f. pago recib.
                     ,'' -- valuta entreg. f. vencim.
                     ,'' -- valuta recib. f. vencim.
                     ,0
                     ,0
                     ,0
                     ,@operador -- operador del sistema
                     ,@dfecha
      ,CONVERT(CHAR(8), GETDATE(), 108)
                     ,@terminal  -- terminal
                     ,0
                     ,''
                     ,'N'
                     ,'N'
                     ,0
                     ,''
                     ,''
                     ,0
                     ,0
                     ,0
                     ,0
                     ,''
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,''
                     ,''
                     ,''
                     ,0
                     ,''
                     ,0
                     ,@MFACnumoper
                     ,''
                     ,''
                     ,''
                     ,''
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,0
                     ,''
                     ,''
                     ,0
                     ,0
                     ,'BCC'
                     ,'N'
                     ,'S'
                     ,'L'
                     ,0
                     ,0
                     ,''
                     ,0
                     )
      IF @@ERROR <> 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'ERROR'
         SET NOCOUNT OFF
         RETURN
      END
      COMMIT TRANSACTION
   END
   SELECT @MFACnumoper, 'OK'
   SET NOCOUNT OFF
END

GO
