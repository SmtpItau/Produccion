USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_trae_apoderado_X_MUREX]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[fnc_trae_apoderado_X_MUREX](    
	@clrut INTEGER,   --- 
   @codigo INTEGER=1,   --- 
   @registro as integer,
   @dato as varchar(10)
)
RETURNS VARCHAR(35)             --- The number of 30/360 days
--WITH SCHEMABINDING
AS
BEGIN
	DECLARE @RETORNO AS VARCHAR(35)
	SET @dato = LEFT(@dato, 1)
	
	SET @RETORNO = ''

	SELECT --TOP @registro
		@RETORNO = CASE WHEN UPPER(@dato) = 'N' then
						NOMBRE
					WHEN UPPER(@dato) = 'R' then
						RUT
					ELSE
						''
					END
		FROM 
			(SELECT 
			"REG" = CAST((ROW_NUMBER() OVER(ORDER BY apnombre ASC)) AS INT),
			"NOMBRE" = CAST(LTRIM(RTRIM(REPLACE(AP.apnombre, ',', '.'))) AS VARCHAR(60)),
			"RUT" = CAST(AP.aprutapo AS VARCHAR(14)) + '-' + AP.apdvapo	
		FROM 
			BacParamSuda.dbo.CLIENTE_APODERADO  AS AP  --ORDER BY 1 ,4
		WHERE 
			AP.aprutcli = @clrut	AND --CL.CLRUT AND
	--		AP.apdvcli	= CL.CLDV AND 
			(AP.apcodcli = @codigo OR @codigo = 0)	--CL.CLCODIGO
		) AS TABLA_TEMP
	WHERE 
		REG = @registro
	
	RETURN @RETORNO	
END;
GO
