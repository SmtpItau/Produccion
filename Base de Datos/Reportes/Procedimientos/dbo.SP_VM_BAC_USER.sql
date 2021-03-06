USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_USER]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX USUARIO
-- =============================================

--EXEC SP_VM_BAC_USER
CREATE PROCEDURE [dbo].[SP_VM_BAC_USER]
AS BEGIN 

SET NOCOUNT ON 
 
DECLARE @SEP  VARCHAR(1) 
    SET @SEP  = ','

	CREATE TABLE #VM_BAC_USER
		( USR_ID        Int	         --Identificador numérico del usuario o TRADER.
		, USR_NAME      Varchar (40) --Indica el nombre de usuario o TRADER corto que utiliza el sistema.
		, USR_LONG_NAME Varchar (80) --Indica el nombre completo del usuario o TRADER que utiliza el sistema.
		, USR_TITLE     Varchar (80) --Indica el Cargo del usuario o TRADER que utiliza el sistema.
		, USR_MAIL      Varchar(120) --Indica el Correo Electrónica del usuario o TRADER que utiliza el sistema.
		)


	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
DECLARE @Con_Linea_Encabezado VARCHAR(1)	-- PLL-20200512
    SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512
	
	CREATE TABLE #VM_BAC_USER_SALIDA
	(USR_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512


	INSERT INTO #VM_BAC_USER
	SELECT DISTINCT IDTURING
		 , UPPER(USUARIO)
		 , ISNULL(NOMBRE,' ')
		 , ISNULL(TIPO_USUARIO,' ')
		 , ISNULL(EMAIL,' ')
	FROM BACPARAMSUDA..USUARIO 
	WHERE IDTURING IS NOT NULL 
	  AND (TRADER = 'S'
	   OR TIPO_USUARIO LIKE '%ADMIN%' )
	  
	ORDER BY IDTURING DESC

	INSERT INTO #VM_BAC_USER_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"USR_ID" = USR_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			RTRIM(LTRIM(USR_ID))        + @SEP 
		 + RTRIM(LTRIM(USR_NAME))      + @SEP 
		 + RTRIM(LTRIM(USR_LONG_NAME)) + @SEP 
		 + RTRIM(LTRIM(USR_TITLE))     + @SEP 
		 + RTRIM(LTRIM(USR_MAIL))      AS REG_SALIDA
      FROM #VM_BAC_USER
--      ORDER BY USR_ID 	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_SALIDA
		SELECT 
			"USR_ID" = -999,
			"REG_SALIDA" = 'USR_ID'        + @SEP 
							 + 'USR_NAME'      + @SEP 
							 + 'USR_LONG_NAME' + @SEP 
							 + 'USR_TITLE'     + @SEP 
							 + 'USR_MAIL' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_USER_SALIDA 
	ORDER BY USR_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

      
	DROP TABLE #VM_BAC_USER
	DROP TABLE #VM_BAC_USER_SALIDA

END 
GO
