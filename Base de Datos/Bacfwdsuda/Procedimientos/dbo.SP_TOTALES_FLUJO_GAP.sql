USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTALES_FLUJO_GAP]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TOTALES_FLUJO_GAP]
as
BEGIN 
SET NOCOUNT ON
DECLARE @ACFECHA  CHAR(8)
DECLARE @totalreg NUMERIC(19)
DECLARE @TOTALSUM NUMERIC(19)
SELECT @ACFECHA = CONVERT(CHAR(8),acfecproc,112) FROM MFAC
SELECT @totalreg = COUNT(*)
    FROM mfca a  WHERE  a.cafecha = @acfecha
SELECT @TOTALSUM = ISNULL(SUM(caequmon1),0)
    FROM mfca    WHERE  cafecha = @acfecha
SELECT  'CTREG'  = 3      --1
 ,'CRUT '  = SPACE(9)     --2
 ,'CREF'  = SPACE(20)     --3
 ,'Ccope' = SPACE(5)     --4  
 ,'CcSUP' = space(4)     --5
 ,'Cctas'  = space(3)     --6
 ,'Cscta' = space(2)     --7
 ,'Ccali' = space(1)     --8
 ,'Ctipc' = space(4)     --9
 ,'Ccpro' = space(3)     --10
 ,'Ctcar' = space(3)     --11
 ,'Ctcre' = space(2)     --12
 ,'Cfoto' = CONVERT(DATETIME,@ACFECHA)     --13
 ,'Cvori' = SPACE(15)     --14 equivalente pesos
 ,'Ccupo' = SPACE(15)     --15
 ,'Cvatc' = SPACE(12)     --14
 ,'Cmon'  = SPACE(2)     --17
 ,'Cmor'  = SPACE(2)     --18
 ,'Cmone' = SPACE(3)     --19
 ,'Ctasb' = space(3)     --20
 ,'Ctasa' = space(6)     --21
 ,'Cttas' = space(3)     --22
 ,'Ctcom' = space(6)     --23
 ,'Ctcof' = space(6)     --24
 ,'Cfext' = SPACE(8)     --25
 ,'Cfven' = SPACE(8)     --26
 ,'Ccapi' = @TOTALSUM     --27 equivalente pesos
 ,'Cpcrb' = Space(3)     --28
 ,'cpzop' = space(4)     --29
 ,'cncua' = space(3)     --30
 ,'cmcua' = space(16)     --31
 ,'cmatr' = space(2)     --32
 ,'cisis' = SPACE(3)     --33
 ,'cofio' = SPACE(5)     --34
 ,'cofco' = SPACE(1)     --35
 ,'cceje' = space(3)     --36
 ,'cccos' = space(5)     --37
 ,'cftas' = SPACE(8)     --38
 ,'cntoc' = SPACE(1)     --39
 ,'cncup' = SPACE(1)     --40
 ,'ccopi' = space(5)     --41
 ,'cinte' = space(15)     --42
 ,'ccopr' = space(5)     --43
 ,'creaj' = space(15)     --44
 ,'ccjud' = space(1)     --45
 ,'cinfo' = SPACE(1)     --46
 ,'crell' = space(15)      --47
 
END 

GO
