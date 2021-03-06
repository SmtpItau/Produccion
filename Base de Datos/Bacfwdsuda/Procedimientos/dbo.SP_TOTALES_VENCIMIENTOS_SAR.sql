USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTALES_VENCIMIENTOS_SAR]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_TOTALES_VENCIMIENTOS_SAR]
AS 
BEGIN 
SET NOCOUNT ON
DECLARE @ACFECHA  CHAR(8)
DECLARE @totalreg NUMERIC(19)
DECLARE @TOTALSUM NUMERIC(19)
SELECT @ACFECHA = CONVERT(CHAR(8),acfecproc,112) FROM MFAC
SELECT @totalreg = ISNULL(COUNT(*),0)
    FROM mfca a  WHERE  a.cafecha = @acfecha
SELECT @TOTALSUM = ISNULL(SUM(caequmon1),0)
    FROM mfca    WHERE  cafecha = @acfecha
          
select   'ctreg' =  2
 ,'crut'  =  'TRAILER'
 ,'cref'  =  space(20)
 ,'ccope' =  space(5)
 ,'ccorr' =  space(2)
 ,'cncua' =  space(3)
 ,'cntoc' =  space(3)
 ,'csepa' = ''
 ,'cncep' =  space(3)
 ,'cfven' =  CONVERT(DATETIME,@ACFECHA)
 ,'cvamo' =  space(15)                  -- equivalente en pesos
 ,'cinte' =  space(15)
 ,'ccomi' =  space(15)
 ,'cvcuo' =  @totalreg
 ,'csvca' =  @TOTALSUM
 ,'ctasa' =  space(7)
 ,'crell' =  space(8)
END

GO
