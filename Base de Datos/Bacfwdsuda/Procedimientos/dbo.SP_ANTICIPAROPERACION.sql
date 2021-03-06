USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANTICIPAROPERACION]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ANTICIPAROPERACION]
       (
        @nnumoper   NUMERIC ( 10, 00 ),
        @ctipoper   CHAR ( 01 )       ,
        @ntasaufclp FLOAT             ,
        @cfecvenor  DATETIME          ,
        @nmtoliq    NUMERIC ( 21, 04 )
       )
AS
BEGIN
SET NOCOUNT ON
   DECLARE @dfecproc    DATETIME
   DECLARE @ndolarobs   NUMERIC ( 10, 2 )
   BEGIN TRANSACTION


    ROLLBACK TRANSACTION
    SELECT -1, 'Error: Opcion no se debe utilizar.'
    SET NOCOUNT OFF
    RETURN


   SELECT @dfecproc = acfecproc FROM MFAC
   SELECT @ndolarobs = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @dfecproc
 
   INSERT INTO MFCA_LOG (
                                canumoper     ,
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
                                cavalorayer    ,
				fVal_Obtenido,	
				fRes_Obtenido,
				CaTasaSinteticaM1,
				CaTasaSinteticaM2,
				CaPrecioSpotVentaM1,
				CaPrecioSpotVentaM2,
				CaPrecioSpotCompraM1,
				CaPrecioSpotCompraM2,
				caserie,
				caseriado,
				ValorRazonableActivo,
				ValorRazonablePasivo,
				mtm_hoy_moneda1,
				mtm_hoy_moneda2	,
				caArea_Responsable	,
				cacartera_normativa	,
				casubcartera_normativa	,
				calibro	
				--PRD 12712
				, bEarlyTermination
				, FechaInicio
				, Periodicidad
           )
                        SELECT  canumoper     ,
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
                                'M'           ,
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
                                @dfecproc     ,
                                cavalorayer,
				fVal_Obtenido,	
				fRes_Obtenido,
				CaTasaSinteticaM1,
				CaTasaSinteticaM2,
				CaPrecioSpotVentaM1,
				CaPrecioSpotVentaM2,
				CaPrecioSpotCompraM1,
	  			CaPrecioSpotCompraM2,
				caserie,
				caseriado,
				ValorRazonableActivo,
				ValorRazonablePasivo,
				mtm_hoy_moneda1,
				mtm_hoy_moneda2,
				caArea_Responsable	,
				cacartera_normativa	,
				casubcartera_normativa	,
				calibro	
				--PRD 12712
				, bEarlyTermination
				, FechaInicio
				, Periodicidad
	   	 FROM			MFCA
                 WHERE			canumoper = @nnumoper
   
   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1,
             'Error: al crear el nuevo registro en la tabla de cartera.'
      SET NOCOUNT OFF
      RETURN
   END
   UPDATE MFCA SET cafecvcto   = @dfecproc  ,
                   catasaufclp = @ntasaufclp,
                   caantici    = 'A'        ,
                   cafecvenor  = @cfecvenor ,
                   camtoliq    = @nmtoliq   ,
                   caclpfinal  = @nmtoliq
   WHERE           canumoper   = @nnumoper
   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualizaci¢n de cartera.'
      SET NOCOUNT OFF
      RETURN
   END
   IF @ctipoper = 'C' OR @ctipoper = 'O' BEGIN
      IF EXISTS( SELECT ccmonto FROM MFCC WHERE ccopecmp = @nnumoper ) BEGIN
         SELECT @nnumoper, 'CC'
   UPDATE MFCA SET camtocalzado=camtocalzado-ccmonto 
  FROM MFCA,MFCC
  WHERE canumoper=ccopevta AND ccopecmp=@nnumoper
  IF @@error <> 0 BEGIN
    ROLLBACK TRANSACTION
    SELECT -1, 'Error: al actualizar calces.'
           SET NOCOUNT OFF
    RETURN
  END
         DELETE MFCC WHERE ccopecmp = @nnumoper
  IF @@error <> 0 BEGIN
    ROLLBACK TRANSACTION
    SELECT -1, 'Error: al borrar calces.'
           SET NOCOUNT OFF
    RETURN
  END
      END
   END ELSE IF @ctipoper = 'V' OR @ctipoper = 'A' BEGIN
      IF EXISTS( SELECT ccmonto FROM MFCC WHERE ccopevta = @nnumoper ) BEGIN
         SELECT @nnumoper, 'CC'
    UPDATE MFCA SET camtocalzado=camtocalzado-ccmonto 
  FROM MFCA,MFCC
  WHERE canumoper=ccopecmp AND ccopevta=@nnumoper
  IF @@error <> 0 BEGIN
    ROLLBACK TRANSACTION
    SELECT -1, 'Error: al actualizar calces.'
           SET NOCOUNT OFF
    RETURN
  END
       DELETE MFCC WHERE ccopevta = @nnumoper
  IF @@error <> 0 BEGIN
    ROLLBACK TRANSACTION
    SELECT -1, 'Error: al borrar calces.'
           SET NOCOUNT OFF
    RETURN
  END
      END
   END
   COMMIT TRANSACTION
   SELECT @nnumoper, 'OK'
   SET NOCOUNT OFF
END

GO
