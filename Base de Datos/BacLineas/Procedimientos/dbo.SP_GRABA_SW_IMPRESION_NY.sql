USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_SW_IMPRESION_NY]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --sp_helptext   SP_GRABA_SW_IMPRESION 'BEX', '3557', 1



CREATE PROCEDURE [dbo].[SP_GRABA_SW_IMPRESION_NY]
   (
		@Modulo       CHAR(3) 		,
                @Numoper      NUMERIC(10,0)  	,
		@Sw	      NUMERIC(1,0)  	
   )
AS
BEGIN

   SET NOCOUNT ON
  
   IF  @Modulo = 'BCC'
      UPDATE VIEW_MEMO SET
             SwImpresion = @Sw
      WHERE monumope = @Numoper

     ELSE IF @Modulo = 'BFW'
      UPDATE VIEW_MFMO_NY SET
             SwImpresion = @Sw
      WHERE  monumoper = @Numoper
    
     ELSE IF @Modulo = 'PCS'
      UPDATE VIEW_MOVDIARIO_NY SET 
             SwImpresion = @Sw
      WHERE numero_operacion = @Numoper
	
     ELSE IF @Modulo = 'BEX'
      UPDATE VIEW_TEXT_MVT_DRI_NY SET 
             SwImpresion = @Sw
      WHERE monumoper = @Numoper

     ELSE IF @Modulo = 'BTR'
     BEGIN
         UPDATE VIEW_MDMO SET
                SwImpresion = @Sw
         WHERE monumoper = @Numoper

         UPDATE BacTraderSuda.dbo.MDMOPM SET
                SwImpresion = @Sw
         WHERE  monumoper = @Numoper
     END

     ELSE IF @Modulo = 'OPT'

	UPDATE LnkOpc.CbMdbOpcNY.dbo.MoEncContrato SET 
             MoImpreso =CONVERT(CHAR(01),(CASE WHEN @Sw = 1 THEN 'S' ELSE 'N' END))
  	WHERE MoNumContrato = @Numoper

     ELSE 	

	UPDATE VIEW_MDMO SET 
             SwImpresion =@Sw
   	WHERE monumoper = @Numoper


   SET NOCOUNT OFF
   SELECT 'OK'
END

GO
