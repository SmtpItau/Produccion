USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_CARGA]  
       (  
        @nnumoper       NUMERIC(10)  ,  
        @ncodcart       NUMERIC(09)  ,  
        @ncodigo        NUMERIC(09)  ,  
        @ncodpos1       NUMERIC(02)  ,  
        @ncodmon1       NUMERIC(03)  ,  
        @ncodmon2       NUMERIC(03)  ,  
        @ctipoper       CHAR(1)      ,  
        @ctipmoda       CHAR(1)      ,  
        @dfecha         DATETIME     ,  
        @ntipcam        FLOAT        ,  
        @nmdausd        NUMERIC(03)  ,  
        @nmtomon1       NUMERIC(21,4),  
        @nequusd1       NUMERIC(21,4),  
        @nequmol1       NUMERIC(21,4),  
        @nmtomon2       NUMERIC(21,4),  
        @nequusd2       NUMERIC(21,4),  
        @nequmol2       NUMERIC(21,4),  
        @nparmon1       FLOAT        ,  
        @npremon1       FLOAT        ,  
        @nparmon2       FLOAT        ,  
        @npremon2       FLOAT        ,  
        @cestado        CHAR(1)      ,  
        @cretiro        CHAR(1)      ,  
        @ccontraparte   NUMERIC(09)  ,  
        @cobserv        VARCHAR(255) ,  
        @nspread        FLOAT        ,  
        @nprecal        FLOAT        ,  
        @nplazo         NUMERIC(06)  ,  
        @cfecvcto       DATETIME     ,  
        @clock          CHAR(10)     ,  
        @coperador      CHAR(10)     ,  
        @ntasausd       FLOAT        ,  
        @ntasacon       FLOAT        ,  
        @nfpagomn       NUMERIC(03)  ,  
        @nfpagomx       NUMERIC(03)  ,  
  @nMtoMon1ini NUMERIC(21,4)  ,  
  @nMtoMon1fin NUMERIC(21,4)  ,  
  @nMtoMon2ini NUMERIC(21,4)  ,  
  @nMtoMon2fin NUMERIC(21,4)  ,  
  @nCodCli NUMERIC(9,0)   ,  
  @punta  FLOAT     ,  
		@remunera_linea NUMERIC(10,04)	 ,
		@CaCalvtadol	FLOAT			 = 1
       )  
AS  
BEGIN  
SET NOCOUNT ON  
   /*=======================================================================*/  
   /* Declaraci«n de Variables                                              */  
   /*=======================================================================*/  
   /*=======================================================================*/  
   /* Inicio de la transacci«n                                              */  
   /*=======================================================================*/  
   BEGIN TRANSACTION  
      /*====================================================================*/  
      /* Insertar el nuevo registro en la tabla de movimiento.              */  
      /*====================================================================*/  
      INSERT INTO MFMO (  
                        monumoper                          ,  
                        mocodpos1                          ,  
                        mocodmon1                          ,  
                        mocodmon2                          ,  
                        mocodcart                          ,  
                        mocodigo                           ,  
                        mocodcli                           ,  
                        motipoper                          ,  
                        motipmoda                          ,  
                        mofecha                            ,  
                        motipcam                           ,  
                        momdausd                           ,  
                        momtomon1                          ,  
                        moequusd1                          ,  
                        moequmon1                          ,  
                        momtomon2                          ,  
                        moequusd2                          ,  
                        moequmon2                          ,  
                        moparmon1                          ,  
                        mopremon1                          ,  
                        moparmon2                          ,  
                        mopremon2                          ,  
                        moestado                           ,  
                        moretiro                           ,  
                        mocontraparte              ,  
                        moobserv                           ,  
                        mospread                           ,  
                        moprecal                           ,  
                        moplazo                            ,  
                        mofecvcto                          ,  
                        molock                             ,  
                        mooperador                         ,  
                        motasausd                          ,  
                        motasacon                          ,  
                        mofpagomn                          ,  
                        mofpagomx         ,  
         momtomon1ini        ,  
         momtomon1fin        ,  
         momtomon2ini        ,  
         momtomon2fin        ,  
         mopreciopunta        ,  
					    moremunera_linea				   ,
					    MoCalvtadol
                       )  
                VALUES (  
                        @nnumoper                          ,  
                        @ncodpos1                          ,  
                        @ncodmon1                          ,  
                        @ncodmon2                          ,  
                        @ncodcart                          ,  
                        @ncodigo                           ,    
                        @ncodcli                           ,  
                        @ctipoper                          ,  
                        @ctipmoda                          ,  
                        @dfecha                            ,  
                        @ntipcam                           ,  
                        @nmdausd                           ,  
                        @nmtomon1                          ,  
                        @nequusd1                          ,  
                        @nequmol1                          ,  
                        @nmtomon2                          ,  
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
                        @clock                             ,  
                        @coperador                         ,  
                        @ntasausd                          ,  
                        @ntasacon                          ,  
                        @nfpagomn                          ,  
                        @nfpagomx         ,  
         @nMtoMon1ini        ,  
         @nMtoMon1fin        ,  
         @nMtoMon2ini        ,  
         @nMtoMon2fin        ,  
         @punta          ,  
					    @remunera_linea					   ,
					    @CaCalvtadol
                       )  
      /*====================================================================*/  
      /*====================================================================*/  
      IF @@error <> 0 BEGIN  
         ROLLBACK TRANSACTION  
         SELECT -1,  
                'Error: al crear el nuevo registro en la tabla de movimiento.'  
         SET NOCOUNT OFF  
         RETURN  
      END  
      /*====================================================================*/  
      /* Insertar el nuevo registro en la tabla de cartera.                 */  
      /*====================================================================*/  
      INSERT INTO MFCA (  
           canumoper                          ,  
                        cacodpos1                          ,  
                        cacodmon1                          ,  
                        cacodmon2                          ,  
                        cacodcart                          ,  
                        cacodigo                           ,  
                        cacodcli                           ,  
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
                        cafpagomx         ,    
         camtomon1ini        ,  
         camtomon1fin        ,  
         camtomon2ini        ,  
         camtomon2fin        ,  
         capreciopunta        ,  
					    caremunera_linea				   ,
					    CaCalvtadol
                       )  
                VALUES (  
                        @nnumoper                          ,  
                        @ncodpos1                          ,  
                        @ncodmon1                          ,  
                        @ncodmon2                          ,  
                        @ncodcart                          ,  
                        @ncodigo                           ,  
                        @ncodcli                           ,  
                        @ctipoper                          ,  
                        @ctipmoda                          ,  
                        @dfecha                            ,  
                        @ntipcam                           ,  
                        @nmdausd                           ,  
                        @nmtomon1                          ,  
                        @nequusd1                          ,  
                        @nequmol1                          ,  
                        @nmtomon2                          ,  
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
                        @coperador                         ,  
                        @ntasausd                          ,  
                        @ntasacon                          ,  
                        @nfpagomn                          ,  
                        @nfpagomx         ,   
         @nMtoMon1ini        ,  
         @nMtoMon1fin        ,  
         @nMtoMon2ini        ,  
         @nMtoMon2fin        ,  
         @punta          ,  
					    @remunera_linea					   ,
					    @CaCalvtadol
                       )  
      /*====================================================================*/  
      /*====================================================================*/  
      IF @@error <> 0 BEGIN  
         ROLLBACK TRANSACTION  
         SELECT -1,  
                'Error: al crear el nuevo registro en la tabla de cartera.'  
         SET NOCOUNT OFF  
         RETURN  
      END  
   /*=======================================================================*/  
   /* En esta secci«n  esta indicando que  se debe actualizar los datos  de */  
   /* que se esten mostrando en pantalla para todos los usuario.            */  
   /*=======================================================================*/  
--   UPDATE bacuser SET refrescar  = '1'  
   /*=======================================================================*/  
   /* Fin Transacci«n                                                       */  
   /*=======================================================================*/  
   COMMIT TRANSACTION  
   /*=======================================================================*/  
   /*=======================================================================*/  
   SELECT @nnumoper, 'OK'  
SET NOCOUNT OFF  
END  
GO
