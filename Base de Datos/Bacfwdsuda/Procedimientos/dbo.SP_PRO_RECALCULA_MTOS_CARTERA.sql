USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRO_RECALCULA_MTOS_CARTERA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_PRO_RECALCULA_MTOS_CARTERA]
   (   @Nro_Oper   INT   )
AS  
BEGIN   
 SET NOCOUNT ON  
  
 DECLARE @cFechaProc DATETIME  
 , @CaMtoMon1 NUMERIC(21,4)  
 , @CaMtoMon2 NUMERIC(21,4)  
  
 SELECT @cFechaProc = acfecproc  
 FROM MFAC  
  
 SELECT @CaMtoMon1 = ISNULL((SELECT SUM(Ctf_Monto_Principal)   
     FROM TBL_CARTERA_FLUJOS   
     WHERE Ctf_Numero_OPeracion = @Nro_Oper  
     AND Ctf_Fecha_Vencimiento > @cFechaProc),0)  
  
        DECLARE @nResMesa       FLOAT
            SET @nResMesa       = ISNULL( (SELECT SUM( Ctf_Spread ) 
                                             FROM TBL_CARTERA_FLUJOS 
                                            WHERE Ctf_Numero_OPeracion = @Nro_Oper 
                                         GROUP BY Ctf_Numero_OPeracion), 0)

 UPDATE MFCA     
 SET camtomon2 = @CaMtoMon1 * caprecal  
 , caequmon2 = @CaMtoMon1 * caprecal  
 , camtomon2fin = @CaMtoMon1 * caprecal  
 , camtomon1 = @CaMtoMon1  
 , Resultado_Mesa  = @nResMesa 
 WHERE canumoper = @Nro_Oper  
 AND cacodpos1 = 13  
  
        UPDATE  MFMO
        SET     Resultado_Mesa  = @nResMesa
	WHERE	monumoper	= @Nro_Oper
	AND	mocodpos1	= 13
        
 SET NOCOUNT OFF  
END  
GO
