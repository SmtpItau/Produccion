USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ObtieneApoderados]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FUSION_SP_ObtieneApoderados]
AS
BEGIN


	SELECT  apnombre
		,'primerNombre'     = LEFT(apnombre, ISNULL(NULLIF(CHARINDEX(' ', apnombre) - 1, -1), LEN(apnombre)))
		,'segundoNombre'    = LEFT((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), ISNULL(NULLIF(CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) - 1, -1), LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))
										
		,'primerApellido'   = LEFT((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))), ISNULL(NULLIF(CHARINDEX(' ', (SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))) - 1, -1), LEN((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))))))
		,'segundoApellido'  = LEFT((SUBSTRING((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))), CHARINDEX(' ', (SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))) + 1, LEN((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))))), ISNULL(NULLIF(CHARINDEX(' ', (SUBSTRING((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))), CHARINDEX(' ', (SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))) + 1, LEN((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))))))) - 1, -1), LEN((SUBSTRING((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))))), CHARINDEX(' ', (SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) +1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))) + 1, LEN((SUBSTRING((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))), CHARINDEX(' ', (SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre)))) + 1, LEN((SUBSTRING(apnombre, CHARINDEX(' ', apnombre) + 1, LEN(apnombre))))))))))))
		, aprutcli ,  apdvcli, apcodcli, aprutapo,apdvapo, apemail
	INTO #tmpClientes_Apoderado
	FROM  dbo.CLIENTE_APODERADO  AS ap  WITH (NOLOCK) INNER JOIN
	      dbo.FUSION_ClientesFindur c  WITH (NOLOCK) ON ap.aprutcli = c.rutCliente AND ap.apdvcli = c.dvCliente AND ap.apcodcli = c.codigoClienteCorpbanca
	WHERE ap.aprutcli <> ap.aprutapo   


	SELECT ROW_NUMBER() OVER(PARTITION BY aprutcli ORDER BY aprutcli) AS Id
	     ,  apnombre
		 , 'nombres'   = RTRIM(primerNombre) + ' '   + RTRIM(segundoNombre)
		 , 'apellidos' = RTRIM(primerApellido) + ' ' + RTRIM(segundoApellido) 
		 , flagCompuestos
		 , aprutcli
		 , apdvcli
		 , apcodcli
		 , aprutapo
		 , apdvapo
		 , apemail
    INTO #tmpApodDescomp
		FROM (
				SELECT apnombre
				, primerNombre
				, 'segundoNombre'   = CASE WHEN RTRIM(segundoNombre) = 'DE' OR RTRIM(segundoNombre) = 'DEL' THEN '' ELSE segundoNombre END
				, 'primerApellido'  = CASE WHEN RTRIM(segundoNombre) = 'DE' OR RTRIM(segundoNombre) = 'DEL' THEN segundoNombre +' '+ primerApellido ELSE primerApellido END
				, 'segundoApellido' = CASE WHEN  primerApellido <> segundoApellido THEN segundoApellidoComp ELSE segundoApellido   END
				,  aprutcli ,  apdvcli, apcodcli, aprutapo,apdvapo,  apemail
				, 'flagCompuestos'  = CASE WHEN RTRIM(segundoNombre) = 'DE' OR RTRIM(segundoNombre) = 'DEL' THEN 'x' ELSE '' END
					FROM (  SELECT  apnombre
							 , 'primerNombre'        = primerNombre
							 , 'segundoNombre'       = CASE WHEN segundoApellido = '' THEN '' ELSE segundoNombre END
							 , 'primerApellido'      = CASE WHEN segundoApellido = '' THEN segundoNombre ELSE primerApellido END
							 , 'segundoApellido'     = CASE WHEN segundoApellido = '' THEN primerApellido ElSE  segundoApellido END
							 , 'segundoApellidoComp' = CASE WHEN segundoApellido = '' THEN primerApellido ElSE  SUBSTRING(apnombre, CHARINDEX(segundoApellido, apnombre),LEN(apnombre)) END
							 , aprutcli ,  apdvcli, apcodcli, aprutapo,apdvapo, apemail
							 FROM #tmpClientes_Apoderado
						  ) tmp2
			) tmp3
	ORDER BY flagCompuestos


	SELECT 	    -- 'orden'		     = Id
				'rutContraparte'	 = aprutcli -- CASE WHEN aprutcli = 76762250 THEN 77777777  ELSE (CASE WHEN aprutcli = 77648350 THEN 88888888 ELSE  ISNULL(aprutcli, '') END) END  -- ISNULL(aprutcli, '')
				,'dvContraparte'     = apdvcli -- CASE WHEN aprutcli = 76762250 THEN '7'       ELSE (CASE WHEN aprutcli = 77648350 THEN '8' ELSE  apdvcli END) END   --apdvcli
				,'lastName'	         = ISNULL(apellidos, '')
				,'forename'          = ISNULL(nombres, '')
				,'rutApoderado'		 = aprutapo
				,'dvApoderado'       = apdvcli
				, flagCompuestos
		FROM  #tmpApodDescomp 
		ORDER BY flagCompuestos

 END 

GO
