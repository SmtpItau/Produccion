USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_MDRS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_ACTUALIZA_MDRS]    
   (   @Fecha_Hoy  DATETIME    
   ,   @fecha_prox DATETIME    
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   DECLARE @nrutctr       NUMERIC(10,0)    
       SET @nrutctr       = 97029000    
    
   DECLARE @Rut_estado    NUMERIC(10,0)    
       SET @Rut_estado    = 97030000    
    
   UPDATE  MDRS    
      SET  rstipobono  = ''    
        ,  rscondpacto = ''    
    WHERE  rsfecha    >= @Fecha_Hoy      
      AND  rsfecha    <  @fecha_prox     
      AND (rsrutcli   <> @nrutctr AND rstipopero <> 'IB' AND rstipoper <> 'VC' AND rstipoper <> 'VCP')    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO rsVIMIENTOS 0.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* Tipos de BONOS                                                         */    
   /*========================================================================*/    
   /* BONOS Empresas                                                         */    
   /*========================================================================*/    
    
   UPDATE MDRS    
      SET rstipobono = '1'    
     FROM VIEW_EMISOR    
     ,    VIEW_INSTRUMENTO    
    WHERE rsfecha   >=  @Fecha_Hoy    
      AND rsfecha    <  @fecha_prox    
      AND inserie    =  'BONOS'    
      AND rsrutemis  =  emrut    
      AND emtipo     <> '2'    
      and rscodigo   =  incodigo    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO RSVIMIENTOS 1.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* BONOS BANCARIOS                                                        */    
   /*========================================================================*/    
    
   UPDATE MDRS    
      SET rstipobono =  '2'   -- tipo bono    
     FROM MDRS    
      ,   VIEW_EMISOR    
      ,   VIEW_INSTRUMENTO     
    WHERE rsfecha    >= @Fecha_Hoy    
      AND rsfecha    <  @fecha_prox    
      AND rscodigo   =  incodigo     
      AND inserie    =  'BONOS'    
      AND rsrutemis  =  emrut    
      AND emtipo     =  '2'    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO rsVIMIENTOS 2.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* Condiciones de Compra Definitiva                                       */    
   /*========================================================================*/    
   /* Compra Definitiva                                                      */    
   /*========================================================================*/    
    
   UPDATE MDRS    
      SET rscondpacto = CASE WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 0    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 29    
                              AND cltipcli                            IN(4,5,6,7,8,9)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '1'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  30    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <=  89    
                              AND cltipcli                            IN(4,5,6,7,8,9)     
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '2'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  90    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365    
                              AND cltipcli                            IN(4,5,6,7,8,9)    
                              AND clrut                               <> @nrutctr    
         AND vitipoper                           <> 'CI'             THEN '3'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 366    
 AND cltipcli         IN(4,5,6,7,8,9)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '4'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  0    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <=  29    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '5'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  30    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <=  89    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '6'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  90    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '7'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 366    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND vitipoper                           <> 'CI'             THEN '8'    
                             WHEN vitipoper                           =  'CI'    
                              AND cltipcli                            IN(4,5,6,7,8,9)     THEN '21'    
                             WHEN vitipoper                           =  'CI'    
                              AND cltipcli                            IN(1,2,3)           THEN '22'    
                             WHEN clrut                               = @nrutctr          THEN '20'     
                        END    
   FROM  MDRS    
         INNER JOIN VIEW_CLIENTE ON rsrutcli  = clrut     AND rscodcli  = clcodigo    
         INNER JOIN MDVI         ON rsnumoper = vinumoper AND rsnumdocu = vinumdocu AND rscorrela = vicorrela    
   WHERE rsfecha    >= @Fecha_HoY    
   AND   rsfecha     < @fecha_prox    
   AND   rscartera   = '111'    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO rsVIMIENTOS 4.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* Compra Definitiva                                                      */    
   /* LCHR (Emision Propia)                                                  */    
   /*========================================================================*/    
    
   UPDATE MDRS    
   SET    rscondpacto    = '1'    
   FROM   MDAC    
   WHERE  rsfecha       >= @Fecha_Hoy    
   AND    rsfecha        < @fecha_prox    
   AND    rscartera      = '111'    
   AND    rscodigo       = 20    
   AND    rsrutemis      = acrutprop    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO rsVIMIENTOS 3.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* Compra Definitiva                                                      */    
   /* LCHR (Otras Emision)                                                   */    
   /*========================================================================*/    
   UPDATE MDRS    
      SET rscondpacto = '2'    
     FROM MDAC    
    WHERE rsfecha    >= @Fecha_Hoy    
      AND rsfecha    <  @fecha_prox    
      AND rscartera   = '111'    
      AND rsrutemis  <> acrutprop    
    
   IF @@ERROR <> 0    
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO rsVIMIENTOS 4.'    
      RETURN 1    
   END    
    
   /*========================================================================*/    
   /* Condiciones de Compra con Pacto                                        */    
   /*========================================================================*/    
   UPDATE MDRS    
      SET rscondpacto = CASE WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >  365 AND cltipcli IN(4,5,6,7,8,9,13) THEN '1'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >  365 AND cltipcli IN(1,2,3)          THEN '2'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365 AND cltipcli IN(4,5,6,7,8,9,13) THEN '3'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365 AND cltipcli IN(1,2,3)          THEN '4'    
                        END    
   FROM  MDRS    
         INNER JOIN VIEW_CLIENTE ON rsrutcli = clrut AND rscodcli = clcodigo    
   WHERE rsfecha   >= @Fecha_HoY    
     AND rsfecha   <  @fecha_prox    
     AND rstipopero IN('CI','RV','RVA')    
    
   /*========================================================================*/    
   /* Condiciones de Venta con Pacto/Recompra/Recompra Anticipada            */    
   /*========================================================================*/    
    
   UPDATE MDRS    
      SET rscondpacto = CASE WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 0    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 29    
                              AND cltipcli                            IN(4,5,6,7,8,9, 11, 13)     
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '1'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 30    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 89    
                              AND cltipcli                            IN(4,5,6,7,8,9, 11, 13)    
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '2'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  90    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365    
                              AND cltipcli                            IN(4,5,6,7,8,9, 11, 13)    
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '3'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 366    
                              AND cltipcli                            IN(4,5,6,7,8,9, 11, 13)    
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '4'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  0    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <=  29    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '5'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  30    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <=  89    
                              AND cltipcli                            IN(1,2,3)    
            AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '6'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >=  90    
                              AND DATEDIFF(DAY, rsfecinip, rsfecvtop) <= 365    
                              AND cltipcli                            IN(1,2,3)    
             AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '7'    
                             WHEN DATEDIFF(DAY, rsfecinip, rsfecvtop) >= 366    
                              AND cltipcli                            IN(1,2,3)    
                              AND clrut                               <> @nrutctr    
                              AND rstipopero                          <> 'CI'         THEN '8'    
                             WHEN clrut                               = @nrutctr      THEN '20'    
                             WHEN rstipopero                          = 'CI'    
                              AND cltipcli                            IN(4,5,6,7,8,9, 11, 13) THEN '21'    
                             WHEN rstipopero                          = 'CI'    
                              AND cltipcli                            IN(1,2,3)       THEN '22'    
                        END    
   FROM  MDRS    
         INNER JOIN VIEW_CLIENTE ON rsrutcli = clrut AND rscodcli = clcodigo    
   WHERE rsfecha    >= @Fecha_HoY    
   AND   rsfecha     < @fecha_prox    
   AND   rscartera  IN('114','115')    
    
   IF @@ERROR <> 0    
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO VECIMIENTOS 17.'    
      RETURN 1    
   END    
    
   /*===========================================================================*/    
   /* Este Filtro es solamente para los IB     */    
   /*           */    
   /*===========================================================================*/    
    
   UPDATE MDRS    
   SET    rscondpacto = CASE WHEN rsrutcli  = @nrutctr                                            THEN '9'    
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 128 and rsforpagv = 128 THEN '10'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 128 and rsforpagv = 128 THEN '11'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 129 and rsforpagv = 129 THEN '12'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 129 and rsforpagv = 129 THEN '13'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 130 and rsforpagv = 130 THEN '14'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 130 and rsforpagv = 130 THEN '15'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 132 and rsforpagv = 132 THEN '16'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 132 and rsforpagv = 132 THEN '17'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 133 and rsforpagv = 133 THEN '18'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 133 and rsforpagv = 133 THEN '19'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 134 and rsforpagv = 134 THEN '20'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 134 and rsforpagv = 134 THEN '21'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 135 and rsforpagv = 135 THEN '22'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 135 and rsforpagv = 135 THEN '23'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 136 and rsforpagv = 136 THEN '24'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 136 and rsforpagv = 136 THEN '25'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 137 and rsforpagv = 137 THEN '26'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 137 and rsforpagv = 137 THEN '27'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 138 and rsforpagv = 138 THEN '28'     
                             WHEN rsrutcli <> @rut_estado and rsforpagi = 138 and rsforpagv = 138 THEN '29'     
                             WHEN rsrutcli  = @rut_estado and rsforpagi = 139 and rsforpagv = 139 THEN '30'     
                 WHEN rsrutcli <> @rut_estado and rsforpagi = 139 and rsforpagv = 139 THEN '31'     
                             WHEN rsrutcli  = @rut_estado                                         THEN '1'    
                             WHEN rsrutcli <> @rut_estado                                         THEN '5'    
                             ELSE                                                                      '0'    
                        END    
   FROM  MDRS    
         INNER JOIN VIEW_CLIENTE ON rsrutcli = clrut AND rscodcli = clcodigo    
   WHERE rsfecha    >= @Fecha_HoY    
   AND   rsfecha     < @fecha_prox    
   AND   rscartera   IN('121')    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO VECIMIENTOS 17.'    
      RETURN 1    
   END    
    
    
   /*===========================================================================*/    
   /* Condiciones de (130) Devengamiento y (121) Vencimientos de Interbancarios.*/    
   /* Solo interbancarios con el BCCH.                                          */    
   /*===========================================================================*/    
    
   UPDATE MDRS     
      SET rscondpacto  = '9'     
    WHERE rsfecha     >= @Fecha_HoY    
      AND rstipoper    = 'VC'    
      AND rscartera    IN('130','121')    
      AND rsrutcli     = @nrutctr    
    
   IF @@ERROR <> 0     
   BEGIN    
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO VECIMIENTOS 18.'    
      RETURN 1    
   END    
    
   RETURN 0    
    
END    

GO
