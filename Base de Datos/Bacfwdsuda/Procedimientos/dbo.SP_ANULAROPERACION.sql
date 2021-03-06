USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAROPERACION]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ANULAROPERACION]
   (   @nnumoper      NUMERIC(10) 
   ,   @observacion   CHAR(250)
   )
AS
BEGIN
   SET NOCOUNT ON

   BEGIN TRANSACTION

   DECLARE @ncodpos1    NUMERIC(02)
   DECLARE @ncodmda1    NUMERIC(03)
   DECLARE @ncodsuc1    NUMERIC(03)
   DECLARE @ncodpos2    NUMERIC(02)
   DECLARE @ncodmda2    NUMERIC(03)
   DECLARE @ctipoper    CHAR(01)
   DECLARE @dfecvcto    DATETIME
   DECLARE @cArt84_Est  VARCHAR(3)
   DECLARE @cArt84_Msg  VARCHAR(30)
   DECLARE @nArt84_Mto  NUMERIC(19,0)
   DECLARE @nArt84_Cli  NUMERIC(9)
   DECLARE @oldMonto    NUMERIC(21,04)
   DECLARE @oldtc       NUMERIC(14,04)
   DECLARE @oldtipoper  CHAR(1)
   DECLARE @oldTipMer   CHAR(4)

   SELECT @ncodpos1   = cacodpos1,
          @ncodmda1   = cacodmon1,
          @ncodsuc1   = cacodsuc1,
          @ncodpos2   = cacodpos2,
          @ncodmda2   = cacodmon2,
          @ctipoper   = catipoper,
          @dfecvcto   = cafecvcto,
          @nArt84_Cli = cacodigo ,
          @nArt84_Mto = cadiferen ,
          @oldMonto   = camtomon1 * -1 ,
          @oldTC      = catipcamPtosFwd , --catipcam ,
          @oldTipOper = catipoper
   FROM   MFCA
   WHERE  canumoper   = @nnumoper

   IF @ncodpos1 = 1 OR @ncodpos1 = 4 OR @ncodpos1 = 5 OR @ncodpos1 = 6 OR @ncodpos1 = 7
      SELECT @oldTipMer = 'FUTU' 

   IF @ncodpos1 = 5 
   BEGIN
      SELECT @oldTipMer = '1446'
      SELECT @oldTipOper      = CASE @oldTipOper WHEN 'O' THEN 'C' ELSE 'V' END
   END

   IF @ncodpos1 = 1 OR @ncodpos1 = 4 OR @ncodpos1 = 5 OR @ncodpos1 = 6 OR @ncodpos1 = 7
   BEGIN
	EXECUTE Sp_Gmovto @oldTipMer 
	,	@oldTipOper 
	,	@oldTC  
	,	@oldMonto
	,	1 --vencimiento
   END

   INSERT INTO MFCA_LOG ( canumoper     ,
                          cacodpos1     ,
                          cacodmon1     ,
                          cacodsuc1     ,
                          cacodpos2     ,
                          cacodmon2     ,
                          cacodcart     ,
                          cacodigo      ,
                          cacodcli      ,
                          catipoper     ,
                          catipmoda     ,
                          cafecha       ,
                          catipcam      ,
                          camdausd      ,
                          camtomon1     ,
                          caequusd1     ,
                          caequmon1     ,
                          camtomon2     ,
                          caequusd2     ,
                          caequmon2     ,
                          caparmon1     ,
                          capremon1     ,
                          caparmon2     ,
                          capremon2     ,
                          caestado      ,
                          caretiro      ,
                          cacontraparte ,
                          caobserv      ,
                          captacom      ,
                          captavta      ,
                          caspread      ,
                          cacolmon1     ,
                          cacapmon1     ,
                          catasadolar   ,
                          catasaufclp   ,
                          caprecal      ,
                          caplazo       ,
                          cafecvcto     ,
                          capreant      ,
                          cavalpre      ,
                          caoperador    ,
                          catasfwdcmp   ,
                          catasfwdvta   ,
                          cacalcmpdol   ,
                          cacalcmpspr   ,
                          cacalvtadol   ,
                          cacalvtaspr   ,
                          catasausd     ,
                          catasacon     ,
                          cadiferen     ,
                          cafpagomn     ,
                          cafpagomx     ,
                          cadiftipcam   ,
                          cadifuf       ,
                          caclpinicial  ,
             		  caclpfinal    ,
                          camtodiferir  ,
                          camtodevengar ,
                          cadevacum     ,
                          catipcamval   ,
                          camtoliq      ,
                          camtocalzado  ,
                          calock        ,
                          camarktomarket,
                          capreciomtm   ,
                          capreciofwd   ,
                          camtomon1ini  ,
                          camtomon1fin  ,
                          camtomon2ini  ,
                          camtomon2fin  ,
                          caplazoope    ,
                          caplazovto    ,
                          caplazocal    ,
                          cadiasdev     ,
                          cadelusd      ,
                          cadeluf       ,
                          carevusd      ,
                          carevuf       ,
                          carevtot      ,
                          cavalordia    ,
                          cactacambio_a ,
                          cactacambio_c ,
                          cautildiferir ,
                          caperddiferir ,
                          cautildevenga ,
                          caperddevenga ,
                          cautilacum    ,
                          caperdacum    ,
                          cautilsaldo   ,
                          caperdsaldo   ,
                          caclpmoneda1  ,
                          caclpmoneda2  ,
                          camtocomp     ,
                          caantici      ,
                          cafecvenor    ,
                          cabroker      ,
                          cafecmod      ,
                          cavalorayer ,
                          cahora      ,
                          catasaEfectMon1 ,
                          catasaEfectMon2 ,        
                          catipcamSpot    ,        
                          catipcamFwd     ,        
                          cafecEfectiva   ,
		          fVal_Obtenido,	
		          fRes_Obtenido,
		          CaTasaSinteticaM1,
		          CaTasaSinteticaM2,
		          CaPrecioSpotVentaM1,
		          CaPrecioSpotVentaM2,
		          CaPrecioSpotCompraM1,
		          CaPrecioSpotCompraM2,
			  caArea_Responsable	,
                          cacartera_normativa    ,
                          casubcartera_normativa ,
                          calibro      
                          --PRD 12712
						,bEarlyTermination
						,FechaInicio
						,Periodicidad     
                        )
   SELECT                 canumoper     ,
                          cacodpos1     ,
                          cacodmon1     ,
                          cacodsuc1     ,
                          cacodpos2     ,
                          cacodmon2     ,
                          cacodcart     ,
                          cacodigo      ,
                          cacodcli      ,
                          catipoper     ,
                          catipmoda     ,
                          cafecha       ,
                          catipcam      ,
                          camdausd      ,
                          camtomon1     ,
                          caequusd1     ,
                          caequmon1     ,
                          camtomon2     ,
                          caequusd2     ,
                          caequmon2     ,
                          caparmon1     ,
                          capremon1     ,
                          caparmon2     ,
                          capremon2     ,
                          'A'           ,
                          caretiro      ,
                          cacontraparte ,
                          @observacion ,
                          captacom      ,
                          captavta      ,
                          caspread      ,
                          cacolmon1     ,
                          cacapmon1     ,
                          catasadolar   ,
                          catasaufclp   ,
                          caprecal      ,
                          caplazo       ,
                          cafecvcto     ,
                          capreant      ,
                          cavalpre      ,
                          caoperador    ,
                          catasfwdcmp   ,
                          catasfwdvta   ,
                          cacalcmpdol   ,
                          cacalcmpspr   ,
                          cacalvtadol   ,
                          cacalvtaspr   ,
                          catasausd     ,
                          catasacon     ,
       		          cadiferen     ,
           		  cafpagomn     ,
                          cafpagomx     ,
                          cadiftipcam   ,
                          cadifuf       ,
                          caclpinicial  ,
                          caclpfinal    ,
                          camtodiferir  ,
                          camtodevengar ,
                          cadevacum     ,
                          catipcamval   ,
                          camtoliq      ,
                          camtocalzado  ,
                          calock        ,
                          camarktomarket,
                          capreciomtm   ,
                          capreciofwd   ,
                          camtomon1ini  ,
                          camtomon1fin  ,
                          camtomon2ini  ,
                          camtomon2fin  ,
                          caplazoope    ,
                          caplazovto    ,
                          caplazocal    ,
                          cadiasdev     ,
                          cadelusd      ,
                          cadeluf       ,
                          carevusd      ,
                          carevuf       ,
                          carevtot      ,
                          cavalordia    ,
                          cactacambio_a ,
                          cactacambio_c ,
                          cautildiferir ,
                          caperddiferir ,
                          cautildevenga ,
                          caperddevenga ,
                          cautilacum    ,
                          caperdacum    ,
                          cautilsaldo   ,
                          caperdsaldo   ,
                          caclpmoneda1  ,
                          caclpmoneda2  ,
                          camtocomp     ,
                          caantici      ,
                          cafecvenor    ,
                          cabroker      ,
                          cafecha       ,
                          cavalorayer ,
                          CONVERT( CHAR(08), GETDATE() , 108 ),
                          catasaEfectMon1 ,
                          catasaEfectMon2 ,        
                          catipcamSpot    ,        
                          catipcamFwd     ,        
                          cafecEfectiva   ,
						  fVal_Obtenido,	
						  fRes_Obtenido,
						  CaTasaSinteticaM1,
						  CaTasaSinteticaM2,
						  CaPrecioSpotVentaM1,
						  CaPrecioSpotVentaM2,
						  CaPrecioSpotCompraM1,
						  CaPrecioSpotCompraM2,
						  caArea_Responsable	 ,
                          cacartera_normativa    ,
                          casubcartera_normativa ,
                          calibro  
                          --PRD 12712
						,bEarlyTermination
						,FechaInicio
						,Periodicidad
   FROM                   MFCA
   WHERE                  canumoper = @nnumoper

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al grabar tabla de Log.'      
      SET NOCOUNT OFF
      RETURN
   END

	exec SP_DEL_SEGURO_INFLACION_MV @nnumoper,0 , 'A'



   DELETE FROM MFCA WHERE canumoper = @nnumoper

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Operacirn de Cartera.'
      SET NOCOUNT OFF
      RETURN
   END
   DELETE FROM MFMO WHERE monumoper = @nnumoper 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Operacirn desde movimiento.'
      SET NOCOUNT OFF
      RETURN
   END

   DELETE FROM cortes WHERE cornumoper = @nnumoper 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Cortes (Compensaciones Parciales).'
      SET NOCOUNT OFF
      RETURN
   END

   IF @ctipoper = 'C' OR @ctipoper = 'O' 
   BEGIN
      IF EXISTS( SELECT ccmonto FROM MFCC WHERE ccopecmp = @nnumoper )
      BEGIN
         UPDATE MFCA
         SET    camtocalzado = camtocalzado - ccmonto
         FROM   MFCC
         WHERE  ccopecmp = @nnumoper AND
                ccopevta = canumoper
   
         DELETE MFCC WHERE ccopecmp = @nnumoper
         IF @@error <> 0
         BEGIN
            ROLLBACK TRANSACTION
            SELECT -1, 'Error: al Eliminar Calce'
            SET NOCOUNT OFF
            RETURN
         END
      END

   END ELSE 
   BEGIN
      IF @ctipoper = 'V' OR @ctipoper = 'A'
      BEGIN
         IF EXISTS( SELECT ccmonto FROM MFCC WHERE ccopevta = @nnumoper )
         BEGIN
            UPDATE MFCA
            SET    camtocalzado = camtocalzado - ccmonto
            FROM   MFCC
            WHERE  ccopevta = @nnumoper 
            AND    ccopecmp = canumoper

            DELETE MFCC
            WHERE  ccopevta = @nnumoper

            IF @@error <> 0
            BEGIN
               ROLLBACK TRANSACTION
               SELECT -1, 'Error: al Eliminar Calce' 
               SET NOCOUNT OFF
               RETURN 
            END
         END
      END
   END

   UPDATE bacparamsuda..MDLBTR
   SET    estado_envio     = 'A'
   WHERE  sistema          = 'BFW'
   AND    numero_operacion = @nnumoper

   -- Eliminación de Coberturas --
   DECLARE @MiDerivado   NUMERIC(9)

   SELECT  @MiDerivado    = 0.0
   SELECT  @MiDerivado    = isnull(nCobertura,0.0)
     FROM  BacTraderSuda..COBERTURAS WITH (NoLock)
    WHERE  cModulo        = 'BFW' 
      AND  nDerivado      = @nnumoper

   DELETE BacTraderSuda..DETALLE_COBERTURAS 
   WHERE  nCobertura = @MiDerivado

   IF @@ERROR <> 0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Detalle de la Cobertura.'
      RETURN 
   END

   DELETE BacTraderSuda..COBERTURAS         
   WHERE  nCobertura = @MiDerivado

   IF @@ERROR <> 0
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Cobertura.'
      RETURN 
   END
   -- Eliminación de Coberturas --

   --- Eliminacion de Garantias (PRD-5521)
   IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema = 'BFW' AND OperacionSistema = @nnumoper)
   BEGIN
	/* Ver si hay candidatos a eliminar en tbl_Garantias_Faltantes */
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Garantias_Faltantes
		WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema  = 'BFW' AND OperacionSistema = @nnumoper))
			
		DELETE Bacparamsuda..tbl_Garantias_Faltantes
		WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
		  WHERE Sistema = 'BFW' AND OperacionSistema = @nnumoper)
	
	/* Continuar con el proceso de eliminación del registro de garantías */	

	DELETE Bacparamsuda..tbl_registro_garantias
	WHERE Sistema = 'BFW' AND OperacionSistema = @nnumoper
  	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'Error al Eliminar  Registro de Garantías.'
		RETURN
	END	
  END
  --- Fin eliminacion de Garantias
   COMMIT TRANSACTION
   SET NOCOUNT OFF
   SELECT 0
   RETURN 0
END

GO
