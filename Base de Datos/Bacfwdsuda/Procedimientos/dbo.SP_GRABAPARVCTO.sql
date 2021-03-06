USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPARVCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAPARVCTO]    
   (   @nNumOpe    NUMERIC(8)    
   ,   @nParVcto   NUMERIC(10,6)    
   ,   @CompEst    FLOAT = 0.0    
   )    
AS    
BEGIN         
    
   SET NOCOUNT ON    
    
   DECLARE @dFechaProceso     DATETIME    
       SET @dFechaProceso     = (SELECT acfecproc FROM MFAC with (nolock) )    
    
   DECLARE @iTasFwd           FLOAT    
   DECLARE @iTasMerc          FLOAT    
   DECLARE @vPres             FLOAT    
   DECLARE @vMerc             FLOAT    
   DECLARE @vDif              FLOAT    
   DECLARE @dFecCalc          DATETIME    
   DECLARE @Fecha_Vcto_Papel  DATETIME    
   DECLARE @Instrumento       CHAR(20)    
   DECLARE @dv01              FLOAT    
    
   CREATE TABLE #Temporal1    
   (   TR            FLOAT           --      5.3    
   ,   TE            FLOAT           --      3.625    
   ,   TV            FLOAT           --      3.625    
   ,   TT            FLOAT           --      0    
   ,   BA            FLOAT           --      365    
   ,   BF            FLOAT           --      0    
   ,   NOM           FLOAT           --      10000000    
   ,   MT            FLOAT           --      9059857.878    
   ,   VV            FLOAT           --      181250    
   ,   VP            FLOAT           --      0    
   ,   PVP           FLOAT           --      89.515019    
   ,   VAN           FLOAT           --      23.75688913    
   ,   FP            DATETIME        --      00:00.0    
   ,   FE            DATETIME        --      00:00.0    
   ,   FV            DATETIME        --      15/05/2013    
   ,   FU            DATETIME        --      00:00.0    
   ,   FX            DATETIME        --      00:00.0    
   ,   FC            DATETIME        --      00:00.0    
   ,   CI            FLOAT           --      5    
   ,   CT            FLOAT           --      20    
   ,   INDEV         FLOAT           --      108355.9783    
   ,   PRINC         FLOAT           --      8951501.9    
   ,   FIP           DATETIME        --      15/05/2005    
   ,   CAP           FLOAT           --      0    
   ,   INCTR         FLOAT           --      0    
   ,   SPREAD        FLOAT           --      0    
   ,   TD_SUMINT     FLOAT           --      36.25    
   ,   TD_SUMAMO     FLOAT           --      100    
   ,   TD_SUMFLU     FLOAT           --      136.25    
   ,   TD_SUMSAL     FLOAT           --      1900    
   ,   TD_SUMFDE     FLOAT           --      23.75688913    
   ,   PX_IN         FLOAT           --      181250    
   ,   PX_AM         FLOAT           --      0    
   ,   V001          FLOAT           --      1.0265    
   ,   V002          FLOAT           --      74    
   ,   V003          FLOAT           --      184    
   ,   V004          FLOAT           --      15.40217391    
   ,   V005          FLOAT           --      1.083559783    
   ,   V006          FLOAT           --      8951501.9    
   ,   V007          FLOAT           --      0    
   ,   V008          FLOAT           --      184    
   ,   V009          FLOAT           --      110    
   ,   V0010         FLOAT           --      0    
   ,   FACTOR        FLOAT           --      1    
   ,   DUR_MAC       FLOAT           --      6.561844817    
   ,   DUR_MOD       FLOAT           --      6.392445024    
   ,   CONVEXI       FLOAT)          --      48.15489175    
    
    
   DECLARE @Valor_obs       FLOAT    
       SET @Valor_obs         = (SELECT vmvalor   FROM VIEW_VALOR_MONEDA with (nolock) WHERE vmcodigo = 994 AND vmfecha = @dFechaProceso)    
       
   DECLARE @nCacodpos1		  INT
       SET @nCacodpos1 = ISNULL((SELECT cacodpos1 FROM MFCA with (nolock) WHERE canumoper = @nNumOpe),0)    
    
	IF @nCacodpos1 = 1
	BEGIN	
		UPDATE	MFCA
		SET		camtocomp	= CASE  WHEN catipoper = 'C' THEN	ROUND(( @nParVcto	-	catipcam)	* camtomon1, 0)
									ELSE						ROUND(( catipcam	-	@nParVcto)	* camtomon1, 0)
							  END
		WHERE	canumoper	= @nNumOpe

		RETURN
	END

   IF @nCacodpos1 = 10    
   BEGIN    
      SELECT @dFecCalc = cafecvcto    
      ,      @iTasFwd  = catipcam    
      ,      @iTasMerc = @nParVcto    
      FROM   MFCA      with (nolock)    
      WHERE  canumoper = @nNumOpe    
          
      EXECUTE SP_VALORIZA_INSTUMENTO_FBT @dFecCalc , @nNumOpe , @iTasFwd , @iTasMerc , @vPres OUTPUT , @vMerc OUTPUT , @vDif OUTPUT        
      UPDATE MFCA      with (rowlock)    
      SET    caprecal  = @nparvcto    
      ,      camtocomp = @vDif    
      WHERE  canumoper = @nnumope    
      AND    cacodpos1 = 10    
    
	  SELECT 0    
      RETURN    
   END    
    
   IF @nCacodpos1 = 12    
   BEGIN    
    
       UPDATE MFCA      with (rowlock)    
          SET caprecal  = @nparvcto    
            , catasacon = @nparvcto    
            , camtocomp = (catipcam - @nParVcto) * camtomon1    
            , camtoliq  = 0    
         FROM MFCA      
        WHERE canumoper = @nnumope    
          AND cacodpos1 = 12    
    
      RETURN    
   END    
    
   IF @nCacodpos1 = 11    
   BEGIN    
      DECLARE @Tipo_operacion   CHAR(1)    
      DECLARE @Nominal          FLOAT    
      DECLARE @VpTasaContrato FLOAT    
      DECLARE @MtoVcto         FLOAT    
      DECLARE @TasaBennchMark FLOAT    
    
      SELECT  @dFecCalc        = cafecvcto    
      ,       @iTasFwd         = catipcam    
      ,       @iTasMerc        = @nParVcto    
      ,       @Instrumento     = caserie    
      ,       @Tipo_operacion  = catipoper    
      ,       @Nominal         = camtomon1    
      FROM    MFCA             with (nolock)    
      WHERE   canumoper        = @nNumOpe    
         
      SELECT @Fecha_Vcto_Papel = Fecha_Vcto     
        FROM INSTRUMENTOS_SUBYACENTES_INV_EXT with (nolock)    
       WHERE Cod_Nemo          = @Instrumento    
    
      --------------------------------------------------------------    
    
      INSERT INTO #temporal1        
      EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @dFechaProceso , @Nominal , @iTasFwd , 0 , 0 , 2    
    
      SELECT @VpTasaContrato = MT     
      FROM   #Temporal1    
    
      IF @CompEst <> 0     
      BEGIN    
         DELETE #temporal1    
     
         IF @Tipo_operacion = 'C'     
            SET @MtoVcto = @VpTasaContrato + @CompEst    
         ELSE     
            SET @MtoVcto = @VpTasaContrato - @CompEst    
    
         DELETE #temporal1      
       
         INSERT INTO #temporal1        
         EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @dFechaProceso , @Nominal , @iTasFwd , 0 , 0 , 3 , 0 , @MtoVcto    
       
         SELECT @MtoVcto = MT    
         , @TasaBennchMark = TR    
         FROM #temporal1    
      END ELSE     
      BEGIN    
    
         DELETE #temporal1    
    
         SELECT @TasaBennchMark = @nParVcto    
    
         INSERT INTO #temporal1        
         EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @dFechaProceso , @Nominal , @TasaBennchMark , 0 , 0 , 2    
     
         SELECT @MtoVcto = MT    
         FROM #temporal1    
    
         IF @Tipo_operacion = 'C'     
            SET @CompEst = @MtoVcto - @VpTasaContrato    
         ELSE    
            SET @CompEst = @VpTasaContrato - @MtoVcto    
      END    
     
      --------------------------------------------------------------    
    
      EXECUTE dbo.SP_CALCULA_DV01 @dFechaProceso    
                                , @Fecha_Vcto_Papel    
                                , @instrumento    
                                , 100.0    
                                , @iTasMerc    
                                , @dv01       OUTPUT    
    
      UPDATE MFCA      with (rowlock)    
         SET caprecal  = @TasaBennchMark --@nparvcto    
           , camtocomp = @CompEst  --ROUND((CASE WHEN @Tipo_operacion = 'C' THEN @dv01 * (  @iTasFwd - @iTasMerc) * @Nominal / 100.0    
      --  ELSE                            @dv01 * (- @iTasFwd + @iTasMerc) * @Nominal / 100.0    
      --  END) * @Valor_obs, 0.0)    
           , catasacon = @dv01    
           , camtoliq  = 0    
        FROM MFCA    
       WHERE canumoper = @nnumope    
         AND cacodpos1 = 11    
    
      SELECT 0    
      RETURN    
   END    
    
    
   DECLARE @dFecVto         DATETIME    
   DECLARE @dFecPro         DATETIME    
   DECLARE @nEstado         INTEGER    
   DECLARE @nValUSD         NUMERIC(21,10) --> FLOAT    
   DECLARE @PrecioFWD       NUMERIC(21,10) --> FLOAT    
   DECLARE @nTCcierre       NUMERIC(21,10) --> FLOAT    
   DECLARE @nMtoMex         NUMERIC(22,10) --> FLOAT    
   DECLARE @nMtoCnv         NUMERIC(21,10) --> FLOAT    
   DECLARE @nMtoComp        NUMERIC(21,10) --> FLOAT    
   DECLARE @cFuerte         CHAR(1)    
   DECLARE @cTipCli         CHAR(1)    
   DECLARE @cTipOpe         CHAR(1)    
   DECLARE @ID_Sistema      CHAR(3)    
   DECLARE @tesTipOpe       CHAR(4)    
   DECLARE @Rut_Cliente     NUMERIC(10)    
   DECLARE @Codigo_Rut      NUMERIC(5)    
   DECLARE @Moneda          CHAR(2)    
   DECLARE @cFPago          CHAR(4)    
   DECLARE @Entidad         INTEGER    
    
  
   --------------------------------->> Actualiza Cartera & Tresury    
   BEGIN TRANSACTION       
    
   UPDATE MFCA      with (rowlock)    
      SET caprecal  = @nparvcto    
     FROM MFCA    
    WHERE @nnumope  = canumoper      
      AND cacodpos1 = 2    
    
   IF @@ERROR <> 0    
   BEGIN    
      ROLLBACK TRANSACTION    
      SELECT -1, 'No se pudo actualizar Arbitraje'    
      RETURN    
   END    
    
   -->> Carga Operacion    
   SELECT  @dFecVto        = CONVERT(CHAR(8), b.cafecvcto, 112)    
   ,       @dFecPro        = CONVERT(CHAR(8), @dFechaProceso, 112)    
   ,       @nTCcierre      = b.caprecal    
   ,       @tesTipOpe      = 'V' + CONVERT(CHAR(1), b.cacodpos1) + @cTipOpe + b.catipmoda    
   ,       @nMtoMex        = b.camtomon1    
   ,       @nMtoCnv        = b.camtomon2    
   ,       @cFuerte        = m.mnrrda    
   ,       @nValUSD        = ISNULL(v.vmvalor,1.0)    
   ,       @cTipCli        = CASE WHEN c.clpais = 6 THEN 'L' ELSE 'E' END   -- Tipo Cliente segun mdtc.tbcateg = 180    
   ,       @Rut_Cliente    = b.cacodigo    
   ,       @Codigo_Rut     = b.cacodcli    
   ,       @Entidad        = b.cacodsuc1    
   ,       @cFPago         = CONVERT(CHAR(4),b.cafpagomn)    
   ,       @cTipOpe        = b.catipoper    
   FROM    MFCA                         b with (nolock)    
           INNER JOIN VIEW_CLIENTE      c with (nolock) ON c.clrut    = b.cacodigo     AND c.clcodigo = b.cacodcli    
           INNER JOIN VIEW_MONEDA       m with (nolock) ON m.mncodmon = b.cacodmon1    
           INNER JOIN VIEW_VALOR_MONEDA v with (nolock) ON v.vmfecha  = @dFechaProceso AND v.vmcodigo = 994    
   WHERE   b.canumoper     = @nNumOpe    
    
   IF @@ROWCOUNT = 0    
   BEGIN
      ROLLBACK TRANSACTION   
      SELECT -1, 'No se pudo capturar datos de Arbitraje'    
      RETURN    
   END    
    
   -->> Tesoreria    
   SET @ID_Sistema = 'BFW'    
   SET @nMtoComp   = 0.0    
    
   -->> Calcula Compensacion    
   IF @dFecVto <= @dFecpro
   BEGIN
      SET @PrecioFWD = @nTCcierre    
    
      IF @nTCcierre = 0     
         SET @nTCcierre = 1    
    
      ----IF @cFuerte = 'D'     
      ----   EXECUTE Sp_Div 1 , @nTCcierre , @PrecioFWD OUTPUT     
    
      IF @cTipOpe = 'C'     
         /* SET @nMtoComp = ROUND( @nMtoMex * @PrecioFWD , 2 ) - @nMtoCnv     */
         IF @cFuerte = 'D'    
            SET @nMtoComp = - @nMtoCnv + ROUND( @nMtoMex / @nTCcierre , 2)    
         ELSE    
            SET @nMtoComp = - @nMtoCnv + ROUND( @nMtoMex * @nTCcierre , 2)   		 
      ELSE    
         IF @cFuerte = 'D'    
            SET @nMtoComp = @nMtoCnv - ROUND( @nMtoMex / @nTCcierre , 2)    
         ELSE    
            SET @nMtoComp = @nMtoCnv - ROUND( @nMtoMex * @nTCcierre , 2)    
      -- select 'debug', '@nMtoComp', @nMtoComp
      IF @cTipCli = 'L'    
         SET @nMtoComp = ROUND(@nMtoComp * @nValUSD,0)    
   END    
   
   UPDATE MFCA      with (rowlock)    
      SET camtocomp = @nMtoComp    
     FROM MFCA    
    WHERE @nnumope  = canumoper      
      AND cacodpos1 = 2    
    
   -->> No hay monto a liquidar     
   IF @nMtoComp = 0    
   BEGIN    
      COMMIT TRANSACTION            
      RETURN    
   END    
    
   -->> Monto y Moneda a Liquidar     
   IF @cTipCli = 'L'    
      SET @Moneda = '$$'    
   ELSE     
      SET @Moneda  = 'USD'    
    
   -->> Tipo de Operacion para Tesoreria    
   IF @nMtoComp < 0    
   BEGIN    
      SELECT @tesTipOpe = SUBSTRING(@tesTipOpe,1,2)     
                        + (CASE WHEN @cTipOpe = 'C' THEN 'V' ELSE 'C' END)    
                        + SUBSTRING(@tesTipOpe,4,1)    
      SELECT @nMtoComp  = @nMtoComp * -1.0    
   END ELSE    
   BEGIN    
      SELECT @tesTipOpe = SUBSTRING(@tesTipOpe,1,2)     
                        + 'V'    
                        + SUBSTRING(@tesTipOpe,4,1)    
   END    
    
   COMMIT TRANSACTION    
    
   SELECT 0    
    
END
GO
