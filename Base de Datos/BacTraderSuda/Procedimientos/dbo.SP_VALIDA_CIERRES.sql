USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CIERRES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_CIERRES]
AS
BEGIN
DECLARE @Cierre_Mesa CHAR(1),
        @Market      CHAR(1)
/* TRADER ----------------------------------------------------------- */
SELECT @Cierre_Mesa = ACSW_MESA,
       @Market      = ACSW_MM
  FROM MDAC
IF @Cierre_Mesa = '0'
BEGIN
   SELECT 'NO', 'CIERRE MESA TRADER NO REALIZADO.'
   RETURN 0
END
IF @Market = '0'
BEGIN
   SELECT 'NO', 'PROCESO MARK TO MARKET DE TRADER NO REALIZADO.'
   RETURN 0
END
/* FORWARD ---------------------------------------------------------- */
SELECT @Cierre_Mesa = ACSW_CIEMEFWD
  FROM VIEW_MFAC
IF @Cierre_Mesa = '0'
BEGIN
   SELECT 'NO', 'CIERRE MESA TRADER NO REALIZADO.'
   RETURN 0
END
/* SPOT ------------------------------------------------------------- */
SELECT @Cierre_Mesa = SUBSTRING(ACLOGDIG,9,1)
  FROM VIEW_MEAC
IF @Cierre_Mesa = '0'
BEGIN
   SELECT 'NO', 'CIERRE MESA SPOT NO REALIZADO.'
   RETURN 0
END
SELECT 'SI',''
END   /* FIN PROCEDIMIENTO */


GO
