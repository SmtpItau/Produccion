USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VALORES_MERCADO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_VALORES_MERCADO]
       (
        @cSistema    CHAR(3),
	@FechaProc   CHAR(08)
       )
AS
BEGIN

   SET NOCOUNT ON 	

   SELECT  ISNULL( b.mnglosa ,'N/R') ,
 
          ISNULL( a.vmValor ,   0 ) ,
	   ISNULL( b.mncodmon,   0)	   
     FROM  View_Valor_Moneda a,     --mdvm a ,
	   View_Moneda       b      --mdmn b	
     WHERE a.vmFecha   = @FechaProc and
	   b.mnCodMon  = a.VMCODIGO and
	   b.mnRefMerc = '1' 	
    SET NOCOUNT off	

END
GO
