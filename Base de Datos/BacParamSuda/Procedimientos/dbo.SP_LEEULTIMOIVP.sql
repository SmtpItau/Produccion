USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEULTIMOIVP]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEULTIMOIVP]( @FechaIVP        DATETIME ,
      @FechaIPC        DATETIME 
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nValorIVP     FLOAT 
 DECLARE @cFechaIVP     CHAR(10)
 DECLARE @nValorIIPC    FLOAT
 DECLARE @nValorIIPC_actual FLOAT
 DECLARE @cFechaIIPC    CHAR(10) 
 DECLARE @nValorIIPCa    FLOAT
 DECLARE @cFechaIIPCa    CHAR(10)
 DECLARE @FechaSemAnt   DATETIME
 SET ROWCOUNT 1  
 SELECT @FechaSemAnt = CONVERT(CHAR(10),DATEADD (MONTH, -6, @FechaIPC),112)
 -- Ultimo Valor Conocido de IVP
 SELECT  @nValorIVP = vmvalor  
 FROM  valor_moneda
 WHERE  vmcodigo = 997  
  AND vmfecha  = @FechaIVP
     
 SELECT  @nValorIIPC = vmvalor
 FROM  valor_moneda
 WHERE vmcodigo = 502
  AND vmfecha  = @FechaIPC
                             
 SELECT  @nValorIIPCa = vmvalor  
 FROM  valor_moneda
 WHERE  vmcodigo = 502
  AND vmfecha  = @FechaSemAnt
 SELECT  @cFechaIVP   = CONVERT(CHAR(10),@FechaIVP,103) 
 SELECT  @cFechaIIPC  = CONVERT(CHAR(10),@FechaIPC, 103)
 SELECT  @cFechaIIPCa = CONVERT(CHAR(10),@FechaSemAnt, 103)
 SELECT  'ValorIVP'    = ISNULL(@nValorIVP , 0.00)  , --1
  'FechaIVP'    = ISNULL(@cFechaIVP ,   '')  , --2  
  'ValorIPC'    = ISNULL(@nValorIIPC, 0.00)  , --3
  'FechaIIPC'   = ISNULL(@cFechaIIPC,   '')  , --4
  'ValorIPCa'   = ISNULL(@nValorIIPCa,0.00)  , --5  
  'FechaIIPCa'  = ISNULL(@cFechaIIPCa,   '')    --6
 SET ROWCOUNT 0
 RETURN
 SET NOCOUNT OFF
END
                
-- sp_leeultimoIVP '20020109', '20020101','20011201'

GO
