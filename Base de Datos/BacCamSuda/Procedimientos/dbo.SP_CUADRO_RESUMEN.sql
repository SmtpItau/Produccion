USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CUADRO_RESUMEN]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_CUADRO_RESUMEN]
AS 
BEGIN

   SET NOCOUNT ON

   DECLARE @Contador       INTEGER
          ,@motipope       CHAR(1)    
          ,@motipmer       CHAR(4)    
          ,@mocodmon       CHAR(3)
          ,@mocodcnv       CHAR(3)
          ,@motctra        NUMERIC(19,4)
          ,@moticam        NUMERIC(19,4)
          ,@moticamORIG    NUMERIC(19,4)
          ,@moussme        NUMERIC(19,4)
          ,@mopartr        NUMERIC(19,8)
          ,@moparme        NUMERIC(19,8)
          ,@momonmo        NUMERIC(19,4)
          ,@mocostofo      NUMERIC(10,4)
          ,@moutilpe       NUMERIC(19)
          ,@cp_totco       NUMERIC(19,4)
          ,@cp_totve       NUMERIC(19,4) 
          ,@cp_pmecoci     NUMERIC(15,4)
          ,@cp_pmeveci     NUMERIC(19,4)
          ,@acobser        NUMERIC(10,4)
          ,@monumope       NUMERIC(07)
          ,@cMXRrda        CHAR(01)
	  ,@Resu	   FLOAT		  
	  ,@Resu2	   FLOAT
	  ,@param1 	   NUMERIC(19,4)
	  ,@param2 	   NUMERIC(19,4)

   DECLARE @Fec_Proceso   CHAR(10)      
          ,@nVolComUsd    NUMERIC(19,4)   
          ,@nVolVenUsd    NUMERIC(19,4)      
          ,@nVolComMon    NUMERIC(19,4)   
          ,@nVolVenMon    NUMERIC(19,4)   
          ,@nVolTotal     NUMERIC(19,4)   
          ,@nRenComUsd    NUMERIC(19,4)      
          ,@nRenVenUsd    NUMERIC(19,4)      
          ,@nRenComMon    NUMERIC(19,4)   
          ,@nRenVenMon    NUMERIC(19,4)   
          ,@nRenTotal     NUMERIC(19,4)   
          ,@nUtilCom      NUMERIC(19,4)   
          ,@nUtilVen      NUMERIC(19,4)   
          ,@nUtimCom      NUMERIC(19,4)   
          ,@nUtimVen      NUMERIC(19,4)   
          ,@nUtilFon      NUMERIC(19,4)   
          ,@nEstObs       NUMERIC(10,4)     
          ,@nTrading      NUMERIC(19,4)   
          ,@nUtilMon      NUMERIC(19,4)   
          ,@nUtilArb      NUMERIC(19,4)   
          ,@acUtili       NUMERIC(19,4)    
          ,@nSpread       NUMERIC(19,4)
          ,@nResultClp    NUMERIC(19)    
          ,@nParidadT     NUMERIC(19,8)
          ,@nParidadC     NUMERIC(19,8)
          ,@nVolCom       NUMERIC(19,4)
	  ,@acnombre	  CHAR(20)
          ,@nVolVen       NUMERIC(19,4)
	  

   SELECT  @nVolComUsd = 0
          ,@nVolVenUsd = 0
          ,@nVolComMon = 0
          ,@nVolVenMon = 0
          ,@nVolTotal  = 0
          ,@nRenComUsd = 0
          ,@nRenVenUsd = 0
          ,@nRenComMon = 0
          ,@nRenVenMon = 0
          ,@nRenTotal  = 0
          ,@nUtilCom   = 0
          ,@nUtilVen   = 0
          ,@nUtimCom   = 0
          ,@nUtimVen   = 0
          ,@nUtilFon   = 0
          ,@nEstObs    = 0
          ,@nTrading   = 0
          ,@nUtilMon   = 0
          ,@nUtilArb   = 0
          ,@acUtili    = 0
          ,@nSpread    = 0
          ,@nResultClp = 0
          ,@nParidadT  = 0
          ,@nParidadC  = 0
          ,@nVolCom    = 0
          ,@nVolVen    = 0

   SELECT  @cp_totco       = CP_TOTCO
          ,@cp_totve       = CP_TOTVE
          ,@cp_pmecoci     = CP_PMECOCI
          ,@cp_pmeveci     = CP_PMEVECI
          ,@acobser        = vmvalor
	  ,@acnombre	   = acnombre
          ,@Fec_Proceso    = CONVERT(CHAR(10),ACFECPRO,103)
          ,@acUtili        = ACUTILI
   FROM    MEAC,
	   VIEW_VALOR_MONEDA 
   WHERE  CONVERT( CHAR(8) , vmfecha , 112 ) = 	CONVERT( CHAR(8) , ACFECPRO , 112 ) AND
          vmcodigo = 994

   SELECT  monumope
          ,motipmer
          ,motipope
          ,mocodmon
          ,mocodcnv
          ,motctra 
          ,moticam 
          ,moussme 
          ,mopartr 
          ,moparme 
          ,momonmo 
          ,mocostofo
          ,moutilpe 
          ,'mostatus' = ' '
     INTO  #tmpmemo
     FROM  memo
    WHERE (moestatus  = 'M'    OR  moestatus  = ' ')    AND 
          (motipmer   = 'EMPR' OR  motipmer   = 'ARBI') AND
           monumfut   = 0
 ORDER BY  monumope

   WHILE (1=1) BEGIN

      select @contador = @contador + 1

      SELECT @monumope = -1

      SET ROWCOUNT 1
          SELECT  @monumope  	= monumope
                 ,@motipmer  	= motipmer
                 ,@motipope  	= motipope
                 ,@mocodmon  	= mocodmon
                 ,@mocodcnv  	= mocodcnv
                 ,@motctra   	= motctra 
      		 ,@moticam   	= moticam 
		 ,@moticamORIG 	= moticam 
             	 ,@moussme   	= moussme 
                 ,@mopartr   	= mopartr 
                 ,@moparme   	= moparme 
                 ,@momonmo   	= momonmo 
                 ,@mocostofo 	= mocostofo
                 ,@moutilpe  	= moutilpe 
            FROM  #tmpmemo
           WHERE  mostatus = ' '
      SET ROWCOUNT 0

      IF @monumope = -1 BEGIN
         BREAK
      END

      -- Recupera si la moneda se multiplica o se divide
      SELECT @cMXRrda = mnrrda FROM view_moneda WHERE mnnemo = @mocodmon

      IF @cMXRrda = 'D' BEGIN
         SELECT @nParidadC = @moparme
         SELECT @nParidadT = @mopartr
      END 
      ELSE BEGIN
	 EXECUTE sp_div 1 , @moparme , @nParidadC OUTPUT
	 EXECUTE sp_div 1 , @mopartr , @nParidadT OUTPUT
--         SELECT @nParidadC = 1/@moparme
--         SELECT @nParidadT = 1/@mopartr
      END 
      
      IF @motipmer = 'EMPR' BEGIN
         -- Operaciones de Empresa
         IF @motipope = 'C' BEGIN
            IF @mocodmon = 'USD' BEGIN        -- NORMAL
              
               SELECT @nSpread    = ROUND((@motctra - @moticam),4)           
               SELECT @nResultClp = (@moussme * @nSpread)
               SELECT @nVolComUsd = @nVolComUsd + (@moticam * @moussme)
               SELECT @nRenComUsd = @nRenComUsd + @nResultClp
                
               SELECT @nUtilFon   = @nUtilFon + (@momonmo * (@motctra - @mocostofo))
               SELECT @nUtilCom   = @nUtilCom + (@momonmo * (@motctra - @mocostofo))
            END 
            ELSE BEGIN                        -- ARBITRAJE
                 
               IF @mocodcnv = 'USD' BEGIN
                  SELECT @moticam = @acobser
               END
	   set @resu=0
	   set @resu2=0

	     execute sp_div @motctra ,@nParidadT,@resu output
	     execute sp_div @moticam,@nParidadC, @resu2 output
	   set 	@nSpread    = @resu-@resu2
--               SELECT @nSpread    = (@motctra / @nParidadT) - (@moticam / @nParidadC)
               SELECT @nResultClp = @momonmo * @nSpread
               SELECT @nVolComMon = @nVolComMon + (@moticamORIG * @moussme)
               SELECT @nRenComMon = @nRenComMon + @nResultClp
                  
            END
         END
         ELSE BEGIN
            IF @mocodmon = 'USD' BEGIN 
            
               SELECT @nSpread    = ROUND((@moticam - @motctra),4)           
               SELECT @nResultClp = (@moussme * @nSpread)
               SELECT @nVolVenUsd = @nVolVenUsd + (@moticam * @moussme)
               SELECT @nRenVenUsd = @nRenVenUsd + @nResultClp
                 
               SELECT @nUtilFon   = @nUtilFon - (@momonmo * (@motctra - @mocostofo))
               SELECT @nUtilVen   = @nUtilVen - (@momonmo * (@motctra - @mocostofo))
                 
            END 
            ELSE BEGIN
                   
               IF @mocodcnv = 'USD' BEGIN	 	  
                  SELECT @moticam = @acobser
                  SELECT @motctra = @acobser
               END    
          
	   set @resu=0
	   set @resu2=0
	     execute sp_div @moticam ,@nParidadC,@resu output
	     execute sp_div @moticam,@nParidadC, @resu2 output
  	     set 	@nSpread    = @resu-@resu2

--               SELECT @nSpread    = ( (@moticam / @nParidadC) - (@moticam / @nParidadC) )
               SELECT @nResultClp = @momonmo * @nSpread
               SELECT @nVolVenMon = @nVolVenMon + (@moticamORIG * @moussme)
      	       SELECT @nRenVenMon = @nRenVenMon + @nResultClp
                
              --SELECT @monumope, @nResultClp , @nSpread , @moticam , @nParidadC , @motctra , @nParidadT , @mocodcnv , @momonmo

            END
         END
      END 
      ELSE BEGIN
      
           SELECT @nUtilArb = @nUtilArb + @moutilpe
      
      END
              
      UPDATE #tmpmemo SET mostatus = '1' WHERE monumope = @monumope
             
   END

   SELECT @nVolCom    = @nVolComUsd + @nVolComMon
   SELECT @nVolVen    = @nVolVenUsd + @nVolVenMon
   SELECT @nVolTotal  = @nVolCom    + @nVolVen
   SELECT @nRenTotal  = @nRenComUsd + @nRenVenUsd + @nRenComMon + @nRenVenMon

--   SELECT @nRenComUsd = @nRenComUsd - @nUtilCom
--   SELECT @nRenVenUsd = @nRenVenUsd - @nUtilVen

   SELECT @nUtilMon   = ( @nRenComMon + @nRenVenMon ) - ( @nUtimCom + @nUtimVen )
   SELECT @nTrading   = ( @nRenComUsd + @nRenVenUsd ) - ( @nUtilCom + @nUtilVen )

	SELECT @nRenComUsd = ISNULL( @nRenComUsd , 0 ) - ISNULL( @nUtilCom , 0 ) 
	SELECT @nRenVenUsd = ISNULL( @nRenVenUsd , 0 ) - ISNULL( @nUtilVen , 0 ) 
	SELECT @nRenComMon = ISNULL( @nRenComMon , 0 ) - ISNULL( @nUtimCom , 0 ) 
	SELECT @nRenVenMon = ISNULL( @nRenVenMon , 0 ) - ISNULL( @nUtimVen , 0 ) 
	SELECT @nRenTotal  = ISNULL( @nRenTotal  , 0 ) - ISNULL( @nUtilFon , 0 ) 

	set @param1 = ((@cp_totco * @cp_pmecoci) + (@cp_totve * @cp_pmeveci)) 
	set @param1 = (@cp_totco + @cp_totve)
	set @resu   = 0
	execute sp_div @param1,@param2,@resu output
	set @nEstObs  = @resu

--  SELECT @nEstObs    = (((@cp_totco * @cp_pmecoci) + (@cp_totve * @cp_pmeveci)) / (@cp_totco + @cp_totve))

   SELECT 'Fec_Proceso'=@Fec_Proceso
         ,'nVolComUsd' =ISNULL(@nVolComUsd,0)
         ,'nVolVenUsd' =ISNULL(@nVolVenUsd,0) 
         ,'nVolComMon' =ISNULL(@nVolComMon,0) 
         ,'nVolVenMon' =ISNULL(@nVolVenMon,0) 
         ,'nVolTotal'  =ISNULL(@nVolTotal,0)  
         ,'nRenComUsd' =ISNULL(@nRenComUsd,0) 
         ,'nRenVenUsd' =ISNULL(@nRenVenUsd,0) 
         ,'nRenComMon' =ISNULL(@nRenComMon,0) 
         ,'nRenVenMon' =ISNULL(@nRenVenMon,0) 
         ,'nRenTotal'  =ISNULL(@nRenTotal,0)  
         ,'nUtilCom'   =ISNULL(@nUtilCom,0)   
         ,'nUtilVen'   =ISNULL(@nUtilVen,0)   
         ,'nUtimCom'   =ISNULL(@nUtimCom,0)   
         ,'nUtimVen'   =ISNULL(@nUtimVen,0)   
         ,'nUtilFon'   =ISNULL(@nUtilFon,0)   
         ,'nEstObs'    =ISNULL(@nEstObs,0)    
         ,'nTrading'   =ISNULL(@nTrading,0)   
         ,'nUtilMon'   =ISNULL(@nUtilMon,0)   
         ,'nUtilArb'   =ISNULL(@nUtilArb,0)   
         ,'nUtilFon'   =ISNULL(@nUtilFon,0)   
         ,'acUtili'    =ISNULL(@acUtili,0)    
	 ,'acnombre'    =@acnombre
         ,'contador'   =ISNULL(@contador,0)
         ,'hora'       =CONVERT( CHAR(08), GETDATE(), 108 )

   DROP TABLE #tmpmemo
         
   SET NOCOUNT OFF

END

-- SP_AUTORIZA_EJECUTAR 'bacuser'




GO
